import os
import json
import boto3
from datetime import datetime

dynamodb = boto3.resource('dynamodb')
location = boto3.client('location')
sns = boto3.client('sns')

TABLE_NAME = os.environ.get('DEVICE_TABLE')
TRACKER = os.environ.get('TRACKER_NAME')
TOPIC_ARN = os.environ.get('ALERTS_TOPIC_ARN')

def lambda_handler(event, context):
    # Support API Gateway proxy + direct invocation
    body = event.get('body') if isinstance(event, dict) else None
    if body and isinstance(body, str):
        data = json.loads(body)
    else:
        data = event if isinstance(event, dict) else {}

    device_id = data.get('deviceId')
    lat = data.get('lat')
    lon = data.get('lon')
    ts = data.get('ts') or datetime.utcnow().isoformat()

    if not (device_id and lat and lon):
        return { 'statusCode': 400, 'body': json.dumps({'error':'missing deviceId/lat/lon'}) }

    try:
        location.batch_update_device_position(
            TrackerName=TRACKER,
            Updates=[{
                'DeviceId': str(device_id),
                'Position': [float(lon), float(lat)],
                'SampleTime': ts
            }]
        )
    except Exception as e:
        print('Location API error', e)

    try:
        table = dynamodb.Table(TABLE_NAME)
        table.put_item(Item={
            'deviceId': str(device_id),
            'ts': str(ts),
            'lat': str(lat),
            'lon': str(lon)
        })
    except Exception as e:
        print('DynamoDB error', e)

    try:
        if TOPIC_ARN:
            sns.publish(TopicArn=TOPIC_ARN, Message=json.dumps({'deviceId':device_id,'lat':lat,'lon':lon,'ts':ts}))
    except Exception as e:
        print('SNS publish error', e)

    return { 'statusCode': 200, 'body': json.dumps({'ok': True}) }

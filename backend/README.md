# ShadowTrace Backend - AWS Location ingest

This folder contains a minimal AWS SAM CloudFormation template and a Lambda ingest function to accept device GPS pings and forward them to Amazon Location Service.

Files:
- `infrastructure/location_stack.yaml` - SAM template to create DynamoDB table, SNS topic, and a Lambda function with a POST `/ingest` endpoint.
- `lambdas/location_ingest.py` - Lambda handler (same logic is inlined in the SAM template for quick deploy).

Quick deploy (requires AWS SAM CLI):

1. Install and configure AWS CLI and SAM CLI, ensure `aws` is authenticated.

2. From this folder run:

```bash
cd backend/infrastructure
sam build
sam deploy --guided
```

3. During guided deploy provide a stack name and accept the defaults. After deploy, note the API endpoint printed by SAM and configure your Flutter app to POST device pings to that URL.

Example payload (POST /ingest):

```json
{
  "deviceId": "device-123",
  "lat": 37.7749,
  "lon": -122.4194,
  "ts": "2026-05-10T10:00:00Z"
}
```

Next steps:
- Wire Flutter background telemetry to POST to the ingest endpoint.
- Add Cognito authorizer or API key for production.
- Create Step Functions and escalation Lambda based on `device_positions` DynamoDB table.
# Backend Setup (AWS Serverless)

This folder contains a skeleton for AWS serverless resources used by ShadowTrace.

Key components to implement and deploy:
- Cognito User Pool & Identity Pool (phone/email auth)
- API Gateway + Lambda functions (Node.js / Python)
- DynamoDB tables: Users, Guardians, Incidents, LiveTracking, EmergencyLogs, Notifications, Routes, DeviceTokens
- SNS topics for critical alerts
- S3 for media evidence storage
- CloudWatch logs and Step Functions for workflows

Amazon Location Service:
- Use Amazon Location Service for maps, geofencing, trackers, and route analysis.
- Provide a backend proxy (Lambda) to call Amazon Location APIs (avoid storing AWS secrets in the mobile app).
- Example Lambda proxies are under `backend/lambda/location_proxy/`.

Infrastructure (CloudFormation):
- `backend/infra/device_tokens_table.yaml` provides a CloudFormation template for the `DeviceTokens` table.
- `backend/infra/lambda_device_tokens_iam.json` has a minimal IAM policy for Lambdas that write tokens.

API surface:
- `backend/lambda/api/login/index.js`
- `backend/lambda/api/register/index.js`
- `backend/lambda/api/sos/index.js`
- `backend/lambda/api/save_incident/index.js`
- `backend/lambda/api/get_guardians/index.js`
- `backend/lambda/api/update_live_location/index.js`
- `backend/lambda/api/push_notification/index.js`
- `backend/lambda/api/ai_request/index.js`

Schema guide:
- `backend/dynamodb_schema.md`

Deployment note:
- Prefer AWS SAM or CloudFormation to deploy the lambdas, API Gateway routes, DynamoDB tables, and SNS topic.

See `lambda/` for function examples and `infra/` for IaC templates (add Terraform/CloudFormation as needed).

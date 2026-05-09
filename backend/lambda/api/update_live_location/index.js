const { dynamo, json, parseBody, currentUserId, nowIso } = require('../../shared');

exports.handler = async (event) => {
  const body = parseBody(event);
  const userId = currentUserId(event, body);
  const deviceId = body.deviceId || userId;
  const position = body.location || body.position;

  if (!position) {
    return json(400, { error: 'position is required' });
  }

  const record = {
    deviceId,
    userId,
    position,
    routeId: body.routeId || null,
    speed: body.speed || null,
    heading: body.heading || null,
    updatedAt: nowIso(),
  };

  try {
    await dynamo.put({ TableName: process.env.LIVE_TRACKING_TABLE || 'LiveTracking', Item: record }).promise();
    return json(200, { message: 'Live location updated', record });
  } catch (error) {
    return json(500, { error: error.message || 'Unable to update location' });
  }
};

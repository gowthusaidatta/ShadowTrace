const AWS = require('aws-sdk');
const crypto = require('crypto');

const dynamo = new AWS.DynamoDB.DocumentClient({ convertEmptyValues: true });
const cognito = new AWS.CognitoIdentityServiceProvider();
const sns = new AWS.SNS();

function headers() {
  return {
    'Content-Type': 'application/json',
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Headers': 'Content-Type,Authorization,X-User-Id',
    'Access-Control-Allow-Methods': 'OPTIONS,GET,POST,PUT',
  };
}

function json(statusCode, payload) {
  return { statusCode, headers: headers(), body: JSON.stringify(payload) };
}

function parseBody(event) {
  if (!event) return {};
  if (typeof event.body === 'string' && event.body.trim().length > 0) {
    try {
      return JSON.parse(event.body);
    } catch (error) {
      return {};
    }
  }
  return event.body || {};
}

function claims(event) {
  return event?.requestContext?.authorizer?.claims
    || event?.requestContext?.authorizer?.jwt?.claims
    || {};
}

function currentUserId(event, body = {}) {
  return claims(event).sub
    || claims(event).username
    || body.userId
    || event?.headers?.['x-user-id']
    || event?.headers?.['X-User-Id']
    || 'anonymous';
}

function nowIso() {
  return new Date().toISOString();
}

function randomId(prefix) {
  return `${prefix}-${crypto.randomUUID()}`;
}

module.exports = {
  dynamo,
  cognito,
  sns,
  json,
  parseBody,
  claims,
  currentUserId,
  nowIso,
  randomId,
};

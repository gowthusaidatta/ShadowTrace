# ShadowTrace

ShadowTrace – Intelligent Monitoring and Smart Assistant System.

This repository contains the Flutter mobile app, AWS serverless backend skeleton, Amazon Location Service integration path, Firebase messaging setup, SOS handling, AI assistant, and deployment/security guidance.

Quick start:
1. Copy `.env.example` to `.env` and fill keys.
2. Add Firebase config files to Android and iOS.
3. Run the app with Flutter after installing dependencies.

Cognito setup values:
- Callback URL: `shadowtrace://callback`
- Sign-out URL: `shadowtrace://logout`
- Redirect scheme: `shadowtrace`
- OAuth scopes: `openid profile email phone`

Documentation:
- `backend/README.md`
- `backend/dynamodb_schema.md`
- `DEPLOYMENT.md`
- `SECURITY.md`

Backend surface:
- Lambda handlers under `backend/lambda/`
- CloudFormation templates under `backend/infra/`

# SafeAssist (shadowtrace)

Kotlin Android implementation of an intelligent monitoring and smart assistant system focused on personal safety.

## Implemented core features
- Trip start/stop flow with foreground monitoring service
- Trusted contacts add/remove with local persistence
- Continuous location tracking + stall detection
- Automatic escalation to emergency SMS alerts
- Manual SOS trigger
- Voice phrase trigger for emergency actions

## Tech choices
- Kotlin + Jetpack Compose
- Android foreground service + Fused Location Provider
- SharedPreferences (JSON) for local persistence

## Build
```bash
./gradlew test
./gradlew assembleDebug
```

## Notes
- Runtime permissions are requested in app startup.
- IMEI-based tracking is intentionally not implemented due to modern Android privacy/security restrictions.

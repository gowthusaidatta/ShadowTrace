# ShadowTrace – Intelligent Monitoring & Smart Safety Assistant System

ShadowTrace is an AI-powered personal safety and intelligent monitoring platform built using Flutter, Kotlin Android Services, and a fully serverless AWS Cloud Architecture.

The system combines:
- Live tracking
- SOS automation
- AI-powered safe route prediction
- Voice-triggered emergency activation
- Real-time notifications
- Smart behavioral monitoring

to provide proactive personal safety assistance.

---

# Core Features

## Real-Time Live Tracking
- Continuous GPS tracking using AWS Location Service
- Live location sharing with multiple trusted contacts
- Real-time movement updates
- Route history and trip monitoring
- Background tracking using Android Foreground Services

## Intelligent Safe Route Selection (AI/ML)
- AI/ML-based safest path prediction
- Route optimization using:
  - Traffic conditions
  - Weather conditions
  - Route safety score
  - Shortest safe distance
  - Risk analysis
- Dynamic route recalculation

## Smart Location Behavior Detection
- Detects if a user remains at a location for an unusual duration
- Uses:
  - AWS Lambda
  - DynamoDB
  - API Gateway
- Automatic emergency workflow trigger after threshold duration

## SOS Emergency System
- Manual SOS trigger
- Automatic SOS escalation
- Emergency alert broadcasting
- Multi-user emergency notifications
- Emergency contact synchronization

## Voice Command Emergency Activation
- Voice recognition-based SOS activation
- Hands-free emergency triggering
- Voice keyword detection for danger situations
- Background voice monitoring support

## Weather-Aware Safety Monitoring
- Real-time weather forecasting API integration
- Weather risk analysis
- Route adjustments during:
  - Heavy rain
  - Storms
  - Unsafe weather conditions

## OTP & Authentication System
- AWS Cognito authentication
- OTP verification system
- Secure login/signup
- OAuth integration
- Token-based authentication

## Smart Notification System
- AWS SNS integration
- Push notifications
- Emergency broadcast notifications
- Location-based alerts
- Escalation alerts for guardians and trusted contacts

---

# Technology Stack

## Frontend
- Flutter
- Kotlin (Android Services)
- Jetpack Compose

## Backend
- AWS Lambda
- Amazon API Gateway
- Amazon DynamoDB
- AWS SNS
- AWS Cognito
- Amazon Location Service

## AI/ML Features
- Safe route prediction
- Risk-based route scoring
- Intelligent behavioral analysis
- Smart emergency detection

## Maps & Navigation
- Amazon Location Service
- Live route rendering
- Real-time tracking
- Navigation assistance

---

# AWS Cloud Architecture

## Implemented AWS Services

### Authentication & Security
- AWS Cognito
- OAuth 2.0 Authentication
- OTP Verification

### Serverless Backend
- AWS Lambda Functions
- Amazon API Gateway

### Database
- Amazon DynamoDB
- Real-time tracking storage
- User activity persistence

### Notifications
- AWS SNS
- Emergency alert messaging
- Push notifications

### Maps & Tracking
- Amazon Location Service
- GPS tracking
- Route calculation
- Live location sharing

---

# Backend APIs Implemented

## Tracking APIs
- Start Live Tracking API
- Stop Tracking API
- Share Live Location API
- Route Tracking API

## Safety APIs
- SOS Trigger API
- Emergency Broadcast API
- Voice SOS API
- Stall Detection API

## AI & Route APIs
- Safe Route Recommendation API
- Weather-Aware Route API
- Route Risk Analysis API

## Authentication APIs
- Login API
- Signup API
- OTP Verification API
- Token Validation API

## Notification APIs
- SNS Notification API
- Guardian Alert API
- Escalation Alert API

---

# Smart Monitoring Workflow

1. User starts tracking
2. Live GPS monitoring begins
3. AI continuously evaluates:
   - Route safety
   - Weather
   - Movement behavior
4. If unusual activity is detected:
   - Emergency verification starts
   - SOS escalation triggers automatically
5. Trusted contacts receive:
   - Live location
   - Emergency alerts
   - Route updates
6. Voice commands can instantly activate SOS

---

# Repository Structure

```plaintext
shadowtrace/
│
├── lib/
├── android/
├── ios/
├── backend/
│   ├── lambda/
│   ├── infra/
│   ├── apis/
│   └── dynamodb/
│
├── docs/
├── assets/
├── SECURITY.md
├── DEPLOYMENT.md
├── README.md
└── .env.example
```

---

# Quick Start

## 1. Clone Repository

```bash
git clone https://github.com/yourusername/shadowtrace.git
cd shadowtrace
```

---

## 2. Configure Environment Variables

Copy:

```bash
.env.example
```

to:

```bash
.env
```

Add:
- AWS Cognito Keys
- API Gateway URLs
- AWS Location Service Keys
- SNS Keys
- Weather API Keys
- Firebase Keys

---

## 3. Firebase Setup

Add Firebase configuration files:

### Android
```plaintext
android/app/google-services.json
```

### iOS
```plaintext
ios/Runner/GoogleService-Info.plist
```

---

## 4. Flutter Setup

```bash
flutter pub get
flutter run
```

---

# Cognito Configuration

```plaintext
Callback URL: shadowtrace://callback
Sign-out URL: shadowtrace://logout
Redirect Scheme: shadowtrace

OAuth Scopes:
- openid
- profile
- email
- phone
```

---

# Build Commands

## Flutter
```bash
flutter build apk
flutter build ios
```

## Kotlin Android
```bash
./gradlew test
./gradlew assembleDebug
```

---

# Security Features

- JWT Authentication
- Secure Token Validation
- API Gateway Authorization
- Role-based Access
- Encrypted Communication
- Secure Emergency Data Handling

---

# Future Enhancements

- Wearable device integration
- Smartwatch SOS
- AI anomaly prediction
- Offline emergency mode
- Camera-based threat detection
- Accident detection using sensors

---

# Documentation

- `backend/README.md`
- `backend/dynamodb_schema.md`
- `DEPLOYMENT.md`
- `SECURITY.md`

---

# Vision

ShadowTrace aims to become a complete intelligent personal safety ecosystem capable of:
- Predicting unsafe situations
- Providing AI-assisted navigation
- Delivering proactive emergency response
- Ensuring continuous user safety monitoring in real time

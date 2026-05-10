# ShadowTrace AI – Intelligent Travel Monitoring & Smart Emergency Assistant

ShadowTrace AI is an advanced personal safety and intelligent travel monitoring platform designed to provide proactive emergency protection, live tracking, route intelligence, and AI-powered safety assistance for travelers, students, employees, and families.

The system combines real-time location monitoring, AI/ML-based safe route analysis, emergency SOS triggering, AWS cloud infrastructure, and voice-assisted safety automation into a unified mobile platform.

---

# 🚀 Core Features

## 🔴 Smart Live Tracking
- Continuous real-time GPS tracking
- Live location sharing with multiple trusted users
- Route movement monitoring using AWS Location Service
- Real-time synchronization between traveler and guardians
- Background location updates even when app is minimized

---

## 🧠 AI/ML-Based Safe Route Selection
The application uses AI/ML algorithms to intelligently select the safest travel route based on:

- Shortest and optimized route
- Weather conditions
- Traffic density
- Network availability
- Route safety score
- Historical route reliability
- Dead-zone prediction

### AI Route Optimization Includes:
- Weather forecasting integration
- Dynamic rerouting
- Dangerous area avoidance
- Smart travel recommendations

---

## 🌦 Weather Forecasting API
Integrated weather monitoring system using AWS Lambda and API Gateway.

### Features:
- Real-time weather forecasting
- Rain and storm alerts
- Route weather analysis
- Dangerous weather notifications
- Weather-aware safe route planning

### AWS Services Used:
- AWS Lambda
- API Gateway
- OpenWeather API
- CloudWatch Logs

---

# 🆘 Intelligent SOS System

## Manual SOS
Users can manually trigger emergency alerts instantly.

## Voice Command SOS
Integrated voice recognition system allows users to trigger emergency alerts using predefined voice commands without touching the device.

### Example Commands:
- "Help me"
- "Send SOS"
- "Emergency"
- "I am in danger"

### Features:
- Hands-free emergency activation
- Background voice detection
- Quick emergency escalation

---

# 📍 Smart Stationary Detection System

The platform continuously monitors movement patterns.

If a user remains in the same location for a suspiciously long duration:
- The system detects inactivity
- AWS Lambda validates movement status
- DynamoDB stores tracking history
- Automated emergency workflow is triggered
- Trusted contacts receive alerts

### Detection Logic:
- Continuous location comparison
- Time-based stationary analysis
- Emergency escalation after threshold timeout
- False-positive prevention system

---

# 📡 AWS Cloud Architecture

## AWS Services Integrated

### AWS Lambda
Serverless backend logic for:
- SOS processing
- Weather forecasting
- Route analysis
- Location verification
- Emergency workflows

### Amazon API Gateway
REST APIs for:
- Live tracking
- Emergency alerting
- Route monitoring
- Weather services
- User verification

### Amazon SNS
Used for:
- Emergency notifications
- OTP verification
- SMS alerts
- Guardian alert broadcasting

### Amazon Cognito
Authentication and authorization system:
- Secure login/signup
- OTP verification
- JWT authentication
- User session management

### Amazon DynamoDB
Stores:
- User live locations
- Tracking history
- SOS events
- Emergency logs
- Stationary detection records

### AWS Location Service
Provides:
- Maps integration
- Live navigation
- Route generation
- Real-time location visualization
- Tracking visualization

### CloudWatch
- API monitoring
- Lambda logs
- Performance tracking
- Error diagnostics

---

# 📲 Live Multi-User Sharing

Users can share their:
- Live location
- Route progress
- ETA
- Emergency status

with:
- Parents
- Guardians
- Friends
- Emergency contacts

Features include:
- Multi-user live monitoring
- Shared tracking dashboard
- Emergency broadcast system

---

# 🔐 Security Features

- JWT-based authentication
- AWS Cognito secure sessions
- OTP verification
- Encrypted API communication
- Role-based access
- Secure cloud infrastructure

---

# 🧩 Technology Stack

## Frontend
- Flutter
- Kotlin (Android modules)
- Jetpack Compose

## Backend
- AWS Lambda
- API Gateway
- Node.js
- Python FastAPI

## Database
- DynamoDB
- PostgreSQL
- PostGIS

## Cloud Services
- AWS SNS
- AWS Cognito
- AWS Location Service
- AWS IoT Core
- Firebase Realtime Database

## AI/ML
- Safe route prediction
- Intelligent route analysis
- Weather-aware path optimization
- Emergency behavior analysis

---

# 🔗 API Endpoints

## Emergency APIs

### Trigger Emergency Alert
POST
```bash
/respond-alert
```

### SOS Alert API
POST
```bash
/trigger-alert
```

### Live Location API
POST
```bash
/location
```

---

# 🌐 API Gateway URLs

```bash
https://ycr7hmmo89.execute-api.us-east-1.amazonaws.com/dev
```

```bash
https://bt0afo9upa.execute-api.us-east-1.amazonaws.com/dev
```

---

# 🛠 Project Architecture

The system follows a cloud-native serverless architecture.

## Workflow
1. Mobile app continuously tracks user location
2. AWS Location Service processes mapping and routes
3. Lambda functions analyze movement and route safety
4. AI engine predicts best and safest path
5. DynamoDB stores telemetry and travel history
6. SNS sends alerts during emergencies
7. Guardians receive live tracking and emergency notifications

---

# 📌 Advanced Features

## Dead-Zone Detection
- Detects low network coverage areas
- Sends predictive safety alerts
- Starts emergency countdown timer

## Smart Emergency Escalation
- Automatic emergency triggering
- Voice-assisted activation
- Location inactivity monitoring

## Real-Time Notifications
- Push notifications
- SMS alerts
- Emergency broadcasts

---

# 📂 Project Structure

```bash
shadowtrace/
│
├── frontend/
│   ├── flutter_app/
│   └── android_modules/
│
├── backend/
│   ├── lambda/
│   ├── api_gateway/
│   ├── dynamodb/
│   ├── cognito/
│   └── sns/
│
├── ai_ml/
│   ├── route_prediction/
│   └── safety_analysis/
│
├── docs/
└── README.md
```

---

# ⚙ Setup Instructions

## Clone Repository
```bash
git clone https://github.com/Mohansivakumar017/shadowtrace
```

## Install Dependencies
```bash
flutter pub get
```

## Configure Environment Variables
Create `.env` file:

```env
AWS_REGION=
COGNITO_POOL_ID=
COGNITO_CLIENT_ID=
AWS_LOCATION_MAP=
SNS_TOPIC_ARN=
OPENWEATHER_API_KEY=
```

---

# ▶ Run Project

```bash
flutter run
```

---

# 📈 Future Enhancements

- Offline map caching
- Power-button silent SOS trigger
- AI danger-zone prediction
- Smart wearable integration
- Real-time crime analytics
- Emergency video/audio streaming
- Satellite emergency mode

---

# 👨‍💻 Developed For
AWS Development with DevOps Project Review

## Team
PS-065

## Project Title
ShadowTrace Travel AI

---

# 📜 Conclusion

ShadowTrace AI is a next-generation intelligent safety ecosystem that combines AI, cloud computing, live monitoring, emergency automation, and smart route intelligence into a single scalable platform.

The system focuses on:
- Proactive safety
- Intelligent emergency detection
- Real-time communication
- AI-assisted travel monitoring
- Cloud-native scalability

It provides a complete smart safety solution for modern travel and personal protection scenarios.

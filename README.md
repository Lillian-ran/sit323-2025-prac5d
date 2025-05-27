# Task 5.2D: Microservice Dockerization & Cloud Publishing

## Overview
This project dockerizes the enhanced calculator microservice from Task 5.1P and publishes it to a private Google Cloud container registry. The solution includes production-ready containerization with validation steps.

---

## Environment Setup
### Prerequisites
1. **Tools**:
   - [Git](https://git-scm.com/)
   - [Node.js](v18+) ([Download](https://nodejs.org/en/download/))
   - [Docker Desktop](https://www.docker.com/products/docker-desktop/)
   - [Google Cloud SDK](https://cloud.google.com/sdk/docs/install)

2. **GCP Account**:  
   School-provided Google Cloud account with permissions to:
   - Create Artifact Registry repositories
   - Push Docker images

---

## Containerization Workflow
### Step 1: Create Private Container Registry
```bash
gcloud artifacts repositories create sit323-2025-prac5d \
  --repository-format=docker \
  --location=australia-southeast2 \
  --description="Production registry for calculator microservice"
```

### Step 2: Docker Build & Tagging
```bash
# Build image with GCP-compliant naming
docker build -t australia-southeast2-docker.pkg.dev/sit323-25t1-yanran-li-8cae0a7/sit323-2025-prac5d/sit323-2025-prac5d:latest

# Optional: Add secondary tag
docker tag australia-southeast2-docker.pkg.dev/.../calculator-service:1.0.0 calculator:latest
```

### Step 3: Registry Authentication
```bash
gcloud auth configure-docker australia-southeast2-docker.pkg.dev
```

### Step 4: Push to GCP Registry
```bash
docker push australia-southeast2-docker.pkg.dev/sit323-25t1-yanran-li-8cae0a7/sit323-2025-prac5d/sit323-2025-prac5d:latest
```

### Step 5: Validate Deployment
```bash
# Pull and run from registry
docker run -dp 3000:3000 \
  australia-southeast2-docker.pkg.dev/sit323-25t1-yanran-li-8cae0a7/sit323-2025-prac5d/sit323-2025-prac5d:latest

# Verify service
curl http://localhost:3000/add?num1=15&num2=23
```

---

## Key Components
### Dockerfile
```dockerfile
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY . .
EXPOSE 3000
CMD ["node", "app.js"]
```

### Cloud Configuration
| Parameter               | Value                                  |
|-------------------------|----------------------------------------|
| **Project ID**          | `sit323-25t1-yanran-li-8cae0a7`        |
| **Registry Region**     | `australia-southeast2`                 |
| **Image URI**           | `australia-southeast2-docker.pkg.dev/.../sit323-2025-prac5d:latest` |

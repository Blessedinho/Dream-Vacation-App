# Dream Vacation Destinations

This application allows users to create a list of countries they'd like to visit, providing basic information about each country. The project is structured to mimic a real-life production environment, employing best practices in software development, deployment, and continuous integration/continuous delivery (CI/CD).

## Setup

### Backend
1. Navigate to the `backend` directory.
2. Run `npm install` to install dependencies.
3. Set up your PostgreSQL database and update the `.env` file with your database URL.
4. Run `npm start` to start the server.

### Frontend
1. Navigate to the `frontend` directory.
2. Run `npm install` to install dependencies.
3. Update the `.env` file with your API URL (e.g., `REACT_APP_API_URL=http://localhost:3001`).
4. Run `npm start` to start the React development server.

## Features
- **Add Countries**: Users can add countries to their dream vacation list.
- **View Country Details**: Displays capital, population, and region information for each country.
- **Remove Countries**: Users can remove countries from their list.
- **Production-Ready Setup**: The project is designed to be scalable and maintainable, following industry-standard practices for deployment and CI/CD.

## Roadmap
- **CI/CD Implementation**: Automate the build, test, and deployment process using industry-standard CI/CD tools.
- **Infrastructure as Code (IaC)**: Implement IaC for automated environment setup and management.
- **Scalability**: Enhance the application to support multiple environments (staging, production) with proper domain names and configurations.
- **Security**: Utilize Kubernetes Secrets and environment variables for secure data management.
- **Microservices**: Modularize the application into microservices to improve maintainability and scalability.

## Technologies Used
- **Frontend**: React
- **Backend**: Node.js with Express
- **Database**: PostgreSQL
- **External API**: REST Countries API
- **CI/CD**: To be implemented with [CI/CD tools, e.g., GitHub Actions, Jenkins, or Azure DevOps]
- **Infrastructure as Code**: To be implemented with tools like Terraform or Helm

## Best Practices
- **Version Control**: All changes are tracked in Git for collaboration and history management.
- **Environment Management**: Separate configurations for different environments (development, staging, production) using environment variables.
- **Security**: Sensitive information is managed using environment variables and Kubernetes Secrets.
- **Documentation**: The project is well-documented to facilitate onboarding and maintenance.

## CI/CD Pipeline

This repo uses two GitHub Actions workflows — `.github/workflows/backend.yml` and
`.github/workflows/frontend.yml` — so the backend and frontend build and deploy
independently of each other.

### Triggers
Each workflow runs on:
- Every `push` to `main` or `dev`
- Every `pull_request` targeting `main` or `dev`

Path filters (`paths: backend/**` / `frontend/**`) mean a change to only the
frontend won't trigger a pointless backend rebuild, and vice versa.

### Stages
Each workflow has two jobs, run in sequence:

1. **`ci` (Lint, Test & Build)** — runs on every push and PR.
   - Installs dependencies with `npm ci`
   - Runs `npm run lint` (skipped automatically if no lint script exists)
   - Runs `npm test` (skipped automatically if no test script exists)
   - Does a local Docker build as a sanity check (image is not pushed anywhere)

2. **`cd` (Push Image to Docker Hub)** — only runs on a direct `push` to
   `main` or `dev` (not on pull requests), and only if the `ci` job passed.
   - Logs into Docker Hub using the `DOCKER_USERNAME` / `DOCKER_TOKEN` secrets
   - Builds and pushes the image tagged two ways:
     - `<username>/dream-vacation-backend:<commit-sha>` — an immutable, traceable tag for that exact commit
     - `<username>/dream-vacation-backend:latest` — always the most recent build on that branch
   - (Same pattern for the frontend image)

### Required GitHub Secrets
Set these under **Settings → Secrets and variables → Actions**:

| Secret | Purpose |
|---|---|
| `DOCKER_USERNAME` | Docker Hub username |
| `DOCKER_TOKEN` | Docker Hub access token (Account Settings → Security → New Access Token) |

### Running locally
```bash
docker-compose up --build
```
This builds both images locally and starts `frontend` (port 3000), `backend`
(port 3001), and `db` (Postgres, port 5432) on the `dream-network` bridge
network, using the same Dockerfiles the pipeline uses.

### Pulling the CI-built images instead of building locally
```bash
docker pull <your-dockerhub-username>/dream-vacation-backend:latest
docker pull <your-dockerhub-username>/dream-vacation-frontend:latest
```

## CI/CD Pipeline

This repo uses two GitHub Actions workflows — `.github/workflows/backend.yml` and
`.github/workflows/frontend.yml` — so the backend and frontend build and deploy
independently of each other.

### Triggers
Each workflow runs on:
- Every `push` to `main` or `dev`
- Every `pull_request` targeting `main` or `dev`

Path filters (`paths: backend/**` / `frontend/**`) mean a change to only the
frontend won't trigger a pointless backend rebuild, and vice versa.

### Stages
Each workflow has two jobs, run in sequence:

1. **`ci` (Lint, Test & Build)** — runs on every push and PR.
   - Installs dependencies with `npm ci`
   - Runs `npm run lint` (skipped automatically if no lint script exists)
   - Runs `npm test` (skipped automatically if no test script exists)
   - Does a local Docker build as a sanity check (image is not pushed anywhere)

2. **`cd` (Push Image to Docker Hub)** — only runs on a direct `push` to
   `main` or `dev` (not on pull requests), and only if the `ci` job passed.
   - Logs into Docker Hub using the `DOCKER_USERNAME` / `DOCKER_TOKEN` secrets
   - Builds and pushes the image tagged two ways:
     - `<username>/dream-vacation-backend:<commit-sha>` — an immutable, traceable tag for that exact commit
     - `<username>/dream-vacation-backend:latest` — always the most recent build on that branch
   - (Same pattern for the frontend image)

### Required GitHub Secrets
Set these under **Settings → Secrets and variables → Actions**:

| Secret | Purpose |
|---|---|
| `DOCKER_USERNAME` | Docker Hub username |
| `DOCKER_TOKEN` | Docker Hub access token (Account Settings → Security → New Access Token) |

### Running locally
```bash
docker-compose up --build
```
This builds both images locally and starts `frontend` (port 3000), `backend`
(port 3001), and `db` (Postgres, port 5432) on the `dream-network` bridge
network, using the same Dockerfiles the pipeline uses.

### Pulling the CI-built images instead of building locally
```bash
docker pull <your-dockerhub-username>/dream-vacation-backend:latest
docker pull <your-dockerhub-username>/dream-vacation-frontend:latest
```

## CI/CD Pipeline

This repo uses two GitHub Actions workflows — `.github/workflows/backend.yml` and
`.github/workflows/frontend.yml` — so the backend and frontend build and deploy
independently of each other.

### Triggers
Each workflow runs on:
- Every `push` to `main` or `dev`
- Every `pull_request` targeting `main` or `dev`

Path filters (`paths: backend/**` / `frontend/**`) mean a change to only the
frontend won't trigger a pointless backend rebuild, and vice versa.

### Stages
Each workflow has two jobs, run in sequence:

1. **`ci` (Lint, Test & Build)** — runs on every push and PR.
   - Installs dependencies with `npm ci`
   - Runs `npm run lint` (skipped automatically if no lint script exists)
   - Runs `npm test` (skipped automatically if no test script exists)
   - Does a local Docker build as a sanity check (image is not pushed anywhere)

2. **`cd` (Push Image to Docker Hub)** — only runs on a direct `push` to
   `main` or `dev` (not on pull requests), and only if the `ci` job passed.
   - Logs into Docker Hub using the `DOCKER_USERNAME` / `DOCKER_TOKEN` secrets
   - Builds and pushes the image tagged two ways:
     - `<username>/dream-vacation-backend:<commit-sha>` — an immutable, traceable tag for that exact commit
     - `<username>/dream-vacation-backend:latest` — always the most recent build on that branch
   - (Same pattern for the frontend image)

### Required GitHub Secrets
Set these under **Settings → Secrets and variables → Actions**:

| Secret | Purpose |
|---|---|
| `DOCKER_USERNAME` | Docker Hub username |
| `DOCKER_TOKEN` | Docker Hub access token (Account Settings → Security → New Access Token) |

### Running locally
```bash
docker-compose up --build
```
This builds both images locally and starts `frontend` (port 3000), `backend`
(port 3001), and `db` (Postgres, port 5432) on the `dream-network` bridge
network, using the same Dockerfiles the pipeline uses.

### Pulling the CI-built images instead of building locally
```bash
docker pull <your-dockerhub-username>/dream-vacation-backend:latest
docker pull <your-dockerhub-username>/dream-vacation-frontend:latest
```

## AWS Deployment (EC2 via ClickOps + CI/CD)

This section documents deploying the Dream Vacation App to AWS EC2, with
infrastructure provisioned manually through the AWS Console and deployment
automated through the existing GitHub Actions pipeline.

### Part 1 — Networking

A custom VPC was created to isolate this project's infrastructure:

| Resource | Name | Details |
|---|---|---|
| VPC | `dream-vpc` | CIDR: `10.0.0.0/16` |
| Subnet | `dream-subnet` | CIDR: `10.0.1.0/24` |
| Internet Gateway | `dream-igw` | Attached to `dream-vpc` |
| Route Table | `dream-rt` | Route `0.0.0.0/0` → `dream-igw`, associated with `dream-subnet` |

This gives the subnet outbound/inbound internet access via the attached
internet gateway, making instances launched into it publicly reachable.

**Screenshot:** VPC and subnet
`docs/screenshots/vpc-subnet.png`

### Part 2 — EC2 Instance

| Setting | Value |
|---|---|
| AMI | Ubuntu Server 22.04 LTS |
| Instance type | `t2.micro` (Free Tier) |
| VPC / Subnet | `dream-vpc` / `dream-subnet` |
| Public IP | Auto-assigned |
| Security group | `dream-sg` — inbound: SSH (22), HTTP (80), custom TCP (3001) |

A **user data script** was supplied at launch to install Docker and the
Docker Compose plugin automatically on first boot, so the instance is
deployment-ready as soon as it's running:

```bash
#!/bin/bash
apt-get update -y
apt-get install -y ca-certificates curl gnupg
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update -y
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
usermod -aG docker ubuntu
systemctl enable docker
systemctl start docker
```

**Screenshot:** EC2 instance running
`docs/screenshots/ec2-running.png`

### Part 3 — CI/CD Deployment

The existing `backend.yml` GitHub Actions workflow was extended with a third
job, `deploy`, that runs after the image build/push stage succeeds:
The `deploy` job:
1. Copies `docker-compose.prod.yml` to the EC2 instance via `scp-action`
2. SSHes into the instance via `ssh-action`
3. Runs `docker compose -f docker-compose.prod.yml pull` to fetch the latest
   images from Docker Hub
4. Runs `docker compose -f docker-compose.prod.yml up -d` to restart the
   stack with the new images

`docker-compose.prod.yml` differs from the local development compose file in
one key way: instead of `build:` instructions, it references the pre-built
images directly from Docker Hub (`blessedinho/dream-vacation-backend:latest`,
`blessedinho/dream-vacation-frontend:latest`), so the server only ever pulls
images — it never builds from source.

A `.env` file with production database credentials was placed on the EC2
instance directly (once, manually) rather than passed through the pipeline,
to avoid putting secrets in transit through CI logs.

**Required GitHub Secrets** (in addition to `DOCKER_USERNAME` / `DOCKER_TOKEN`):

| Secret | Purpose |
|---|---|
| `EC2_HOST` | Public IP of the EC2 instance |
| `EC2_USER` | SSH user (`ubuntu`) |
| `EC2_SSH_KEY` | Full private key content (including `-----BEGIN/END-----` lines) for SSH auth |

**Screenshot:** CI/CD pipeline showing successful `ci` → `cd` → `deploy` run
`docs/screenshots/pipeline-success.png`

### Verifying the Deployment

Once deployed, the running containers can be confirmed directly on the server:

```bash
ssh -i dream-key.pem ubuntu@<EC2_PUBLIC_IP> "docker ps"
```

Expected containers: `dreamvacation-db`, `dreamvacation-backend`,
`dreamvacation-frontend`.

The live app is accessible at:
**Screenshot:** App running in browser
`docs/screenshots/app-in-browser.png`


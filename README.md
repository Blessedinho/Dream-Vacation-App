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

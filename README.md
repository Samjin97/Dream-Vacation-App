# Dream Vacation App CI/CD Pipeline

This repository uses GitHub Actions to automate linting, Docker image building, and Docker Hub image publishing for both the frontend and backend of the Dream Vacation App.


## CI/CD Workflow Overview

Both the frontend and backend pipelines perform the following:

- Run on push and pull requests to the `dev` branch
- Lint JavaScript files using GitHub Super Linter
- Build Docker images using Buildx
- Tag images with the short Git commit SHA (e.g., `abc1234`)
- Push images to Docker Hub

## GitHub Secrets Required

| Secret Name            | Purpose                         |
|------------------------|----------------------------------|
| `DOCKERHUB_USERNAME`   | Your Docker Hub username         |
| `DOCKERHUB_TOKEN`      | Your Docker Hub personal access token |

## Linting

Linting is handled using the GitHub Super Linter with default ESLint rules. No custom ESLint configuration or `package.json` modification is required.

## Docker Image Tagging

Each Docker image is tagged using the short SHA of the current commit. Example tags:

- `docker.io/your-username/dva-frontend:abc1234`
- `docker.io/your-username/dva-backend:abc1234`

## Docker Push

Docker images are pushed to Docker Hub after a successful build using credentials stored in GitHub secrets.

## CI Execution Screenshots

### Frontend CI Success

<img src="Screenshots/frontend CI running successfully.PNG" alt="Frontend CI Success" width="800"/>

### Backend CI Success

<img src="Screenshots/backend CI running successfully.PNG" alt="Backend CI Success" width="800"/>

## Expected Outcomes

After setting up this CI/CD pipeline:

- Lint checks run automatically on pushes and pull requests
- Docker images are built and tagged with each commit
- Tagged images are pushed to your Docker Hub registry

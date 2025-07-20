# Dream Vacation App – Dockerized with Docker Compose

This project containerizes the **Dream Vacation App**, which includes a React frontend, a Node.js backend, and a PostgreSQL database. The goal was to dockerize each part and run the full app using Docker Compose.

---

## My Workflow

### 1. Cloned the Repository

I started by cloning the provided repository:

git clone https://github.com/obusorezekiel/Dream-Vacation-App.git
cd Dream-Vacation-App

### 2. Installed Docker & Docker Compose

I installed Docker and Docker Compose on an Ubuntu EC2 instance with the following commands:

sudo apt update
sudo apt install docker.io docker-compose -y
sudo systemctl start docker
sudo systemctl enable docker

---

### 3. Created `frontend/Dockerfile`

### 4. Created `backend/Dockerfile`

### 5. Created `.env` and `.env.example`

To separate private credentials from public config:

- `.env` → Contains sensitive values (not pushed to GitHub)
- `.env.example` → Public template

---

### 6. Created `docker-compose.yml`

Orchestrates the full app: frontend, backend, and PostgreSQL.


### 7. Logged Into Docker Hub and Pushed Images

Logged in from CLI:

docker login command

Then built and pushed images:

# Backend
docker build -t samjin97/dream-vacation-backend ./backend
docker push samjin97/dream-vacation-backend

# Frontend
docker build -t samjin97/dream-vacation-frontend ./frontend
docker push samjin97/dream-vacation-frontend

Screenshots of both images on Docker Hub were taken after pushing.

### 8. Ran the App

To start all services:

docker-compose up --build

---

## Project Structure

```
Dream-Vacation-App/
├── backend/
│   └── Dockerfile
├── frontend/
│   └── Dockerfile
├── .env              # hidden
├── .env.example      # safe to share
├── docker-compose.yml
└── README.md
```

---

## Features

- React frontend served by nginx
- Node.js backend running on port 3001
- PostgreSQL database with Docker volume persistence
- Environment variables managed with `.env`
- Secure separation using `.env.example`
- Images pushed to Docker Hub
- All services started with `docker-compose up --build`

---

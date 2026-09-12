# 🗺️ Roadmap AI

An interactive learning roadmap platform for exploring structured learning paths, topics, resources, and progress.

> **Original Project:** [Shubham Londhe (`LondheShubham153`)](https://github.com/LondheShubham153)
> **This fork/deployment:** [Shashank Pipal](https://github.com/shashankcodes-10)
> **Live Deployment:** [roadmap-ai.shashankpipal.in](https://roadmap-ai.shashankpipal.in)

---

## 🌐 Live Demo

🚀 **Live Application:**
https://roadmap-ai.shashankpipal.in/

The deployed application provides the same core Roadmap AI experience with additional deployment and DevSecOps automation implemented in this fork.

---

## 📌 About the Project

Roadmap AI is a learning roadmap application designed to help learners follow structured paths for different technologies and career areas.

The application provides:

* 📚 Structured learning roadmaps
* 🗂️ Subjects and topics
* 📈 Learning progress tracking
* 🔗 Learning resources
* 👤 User authentication
* 🔐 Learner and admin roles
* 🎯 Career-level based content
* 🧭 Interactive roadmap navigation
* 📱 Responsive user interface

The original application and concept were created by **Shubham Londhe**.

This repository is a fork used for learning, deployment, infrastructure, and DevSecOps implementation.

---

# ✨ Features

## 📚 Learning Roadmaps

Explore structured learning paths containing:

* Subjects
* Topics
* Subtopics
* Learning levels
* Resources
* Topic relationships

---

## 👤 Authentication

The application provides credential-based authentication using Auth.js.

Users can:

* Create an account
* Sign in
* Access their dashboard
* Track their learning progress

---

## 📈 Progress Tracking

Learners can track completed topics and monitor their progress through the roadmap.

---

## 🔐 Role-Based Access

The application supports different user roles, including:

* Learner
* Admin

Administrative functionality allows roadmap content to be managed.

---

## 🔗 Learning Resources

Topics can contain external learning resources such as:

* Articles
* Documentation
* Tutorials
* Other learning material

---

# 🛠️ Tech Stack

### Frontend

* Next.js
* React
* TypeScript
* Tailwind CSS
* shadcn/ui
* Lucide React

### Backend

* Next.js App Router
* Auth.js
* Drizzle ORM

### Database

Development / testing:

* SQLite
* better-sqlite3

Production:

* Turso
* libSQL

### Testing

* Vitest
* Playwright

### DevOps

* Docker
* Docker Compose
* GitHub Actions
* AWS EC2
* Terraform

### DevSecOps

* Gitleaks
* npm audit
* Trivy
* Hadolint
* SonarQube
* CodeQL
* OWASP ZAP

---

# 🏗️ Project Architecture

```text
                         ┌──────────────────────┐
                         │      Developer       │
                         └──────────┬───────────┘
                                    │
                                    ▼
                              Git Repository
                                    │
                                    ▼
                              GitHub Actions
                                    │
                 ┌──────────────────┼──────────────────┐
                 │                  │                  │
                 ▼                  ▼                  ▼
          Code Quality       Security Scans      Code Tests
                 │                  │                  │
                 └──────────────────┼──────────────────┘
                                    │
                                    ▼
                              Docker Scan
                                    │
                                    ▼
                              Docker Image
                                    │
                                    ▼
                              Deployment
                                    │
                                    ▼
                         ┌────────────────────┐
                         │   Roadmap AI App   │
                         └─────────┬──────────┘
                                   │
                         ┌─────────┴─────────┐
                         ▼                   ▼
                      Turso               Vercel
                    Production DB       Web Deployment
```

---

# 📁 Project Structure

```text
roadmap.ai/
│
├── app/
│   ├── api/
│   ├── dashboard/
│   ├── login/
│   ├── signup/
│   ├── tracks/
│   └── ...
│
├── components/
│   └── ...
│
├── e2e/
│   └── smoke.spec.ts
│
├── lib/
│   ├── db/
│   │   ├── client.ts
│   │   ├── migrate.ts
│   │   ├── schema.ts
│   │   └── seed.ts
│   └── ...
│
├── drizzle/
│   ├── migrations
│   └── meta/
│
├── tests/
│   └── ...
│
├── public/
│   └── ...
│
├── .github/
│   └── workflows/
│
├── Dockerfile
├── docker-compose.yml
├── drizzle.config.ts
├── playwright.config.ts
├── next.config.ts
├── package.json
├── package-lock.json
└── README.md
```

---

# 🚀 Getting Started

## Prerequisites

Install the following:

* Node.js 22+
* npm
* Git

Optional:

* Docker
* Docker Compose

---

# 1. Clone the Repository

```bash
git clone https://github.com/shashankcodes-10/roadmap.ai-workflows.git
```

Navigate into the project:

```bash
cd roadmap.ai-workflows
```

---

# 2. Install Dependencies

```bash
npm ci
```

For development environments where the lockfile needs to be regenerated:

```bash
npm install
```

---

# 3. Configure Environment Variables

Create a local environment file:

```bash
touch .env
```

Add the required environment variables.

For local SQLite development:

```env
SQLITE_PATH=sqlite.db
AUTH_SECRET=your-local-secret
```

For production using Turso:

```env
TURSO_DATABASE_URL=your-turso-database-url
TURSO_AUTH_TOKEN=your-turso-auth-token
AUTH_SECRET=your-production-secret
```

### ⚠️ Security

Never commit:

```text
.env
```

or production credentials to Git.

---

# 🗄️ Database Setup

## Local SQLite

The project automatically uses SQLite when:

```env
TURSO_DATABASE_URL=
```

or when `TURSO_DATABASE_URL` is not configured.

Run migrations:

```bash
npm run db:migrate
```

Seed the database:

```bash
npm run db:seed
```

---

# 🌱 Seed Data

The seed script creates the initial application data.

Run:

```bash
npm run db:seed
```

The project includes initial roadmap subjects, topics, resources, and the default administrative account used by the seed implementation.

### ⚠️ Important

If the seed script creates a default admin account, change the default password before using the application publicly.

---

# 💻 Run the Development Server

Start Next.js:

```bash
npm run dev
```

Open:

```text
http://localhost:3000
```

---

# 📦 Available npm Scripts

| Command               | Purpose                     |
| --------------------- | --------------------------- |
| `npm run dev`         | Start development server    |
| `npm run build`       | Create production build     |
| `npm run start`       | Start production server     |
| `npm run lint`        | Run ESLint                  |
| `npm run typecheck`   | Run TypeScript checks       |
| `npm run test`        | Run Vitest tests            |
| `npm run test:e2e`    | Run Playwright E2E tests    |
| `npm run db:generate` | Generate Drizzle migrations |
| `npm run db:migrate`  | Run database migrations     |
| `npm run db:studio`   | Open Drizzle Studio         |
| `npm run db:seed`     | Seed database               |

---

# 🧪 Testing

The project uses two testing layers.

## Unit Tests

Run:

```bash
npm run test
```

This executes the Vitest test suite.

---

# 🌐 End-to-End Tests

E2E tests use Playwright.

Install the browser:

```bash
npx playwright install --with-deps chromium
```

Run:

```bash
npm run test:e2e
```

The Playwright configuration uses a dedicated SQLite database:

```text
sqlite.e2e.db
```

This prevents E2E tests from using production data.

---

# 🧪 E2E Database Setup

Before running E2E tests manually:

```bash
rm -f sqlite.e2e.db
npm run db:migrate
npm run db:seed
npm run test:e2e
```

The database flow is:

```text
Delete old E2E database
        ↓
Run migrations
        ↓
Seed application data
        ↓
Start Next.js
        ↓
Run Playwright
```

---

# 🔐 E2E Authentication

The E2E environment uses a dedicated dummy Auth.js secret:

```text
e2e-test-secret
```

This is configured in:

```text
playwright.config.ts
```

Example:

```ts
env: {
  SQLITE_PATH: "sqlite.e2e.db",
  AUTH_SECRET: "e2e-test-secret",
},
```

This value is **only for E2E testing**.

It must not be used as the production authentication secret.

---

# 🐳 Docker

Build the Docker image:

```bash
docker build -t roadmap-ai:latest .
```

Run the image:

```bash
docker run -p 3000:3000 roadmap-ai:latest
```

Open:

```text
http://localhost:3000
```

---

# 🐳 Docker Compose

If using the project's Docker Compose configuration:

```bash
docker compose up --build
```

Stop the services:

```bash
docker compose down
```

---

# 🔒 DevSecOps Pipeline

This fork includes a modular reusable GitHub Actions DevSecOps pipeline.

The pipeline contains:

```text
Code Quality
      ↓
Secrets Scanning
      ↓
Dependency Check
      ↓
Docker Scan
      ↓
SonarQube Scan
      ↓
Code Test
      ↓
Docker Push
      ↓
Deploy
      ↓
DAST
```

---

# 🔍 Security Checks

## Code Quality

Checks:

* ESLint
* TypeScript

---

## Secret Scanning

Uses:

```text
Gitleaks
```

to detect accidentally committed secrets.

---

## Dependency Security

Uses:

```bash
npm audit --audit-level=high
```

to identify vulnerable npm dependencies.

---

## Docker Security

The Docker workflow performs:

* Dockerfile linting with Hadolint
* Docker image vulnerability scanning with Trivy

The Trivy scan checks:

```text
OS vulnerabilities
Library vulnerabilities
HIGH severity issues
CRITICAL severity issues
```

---

## SonarQube

SonarQube is used for:

* Static analysis
* Code quality
* Maintainability
* Security analysis

---

## CodeQL

CodeQL can be used for deeper source-code security analysis.

---

## DAST

OWASP ZAP is used after deployment to perform dynamic application security testing against the running application.

---

# 🔄 Reusable GitHub Actions

The DevSecOps pipeline is divided into reusable workflows:

```text
.github/workflows/

├── devsecops.yml
├── code_quality.yml
├── secrets_scanning.yml
├── dependency_check.yml
├── docker_scan.yml
├── sonar_scan.yml
├── code_test.yml
├── docker_push.yml
├── deploy.yml
└── dast.yml
```

The main workflow calls the individual reusable workflows.

This keeps each security and CI/CD stage modular and easier to maintain.

---

# 🚦 DEVSECOPS Trigger

The pipeline runs when code is pushed to the production branch.

Documentation-only changes are ignored.

For example:

```yaml
on:
  push:
    branches: [master]
    paths-ignore:
      - "**/*.md"
```

Therefore:

```text
README.md
docs/setup.md
docs/security.md
```

will not trigger the DevSecOps pipeline when they are the only changed files.

However:

```text
README.md + application code
```

will trigger the pipeline.

---

# ☁️ Deployment

## Live Application

The deployed application is available at:

**https://roadmap-ai.shashankpipal.in/**

---

# 🌐 Production Architecture

The production setup separates the application, database, and CI/CD systems.

```text
                    GitHub
                       │
                       ▼
               GitHub Actions
                       │
             ┌─────────┴─────────┐
             │                   │
             ▼                   ▼
       DevSecOps Checks       Deployment
             │                   │
             └─────────┬─────────┘
                       ▼
                 Roadmap AI
                       │
                       ├──────────────► Production Database
                       │                 Turso / libSQL
                       │
                       └──────────────► Production URL
                                        roadmap-ai.shashankpipal.in
```

---

# 🔑 Production Environment Variables

Production requires environment variables such as:

```env
AUTH_SECRET=...
TURSO_DATABASE_URL=...
TURSO_AUTH_TOKEN=...
```

Store production secrets securely.

Do not commit them to GitHub.

For an EC2-based production setup, environment configuration can be stored outside the repository, for example:

```text
/opt/roadmap-ai/.env
```

---

# 🖥️ EC2 Deployment

For an EC2 deployment, the application can be maintained outside the GitHub Actions workspace.

Example environment location:

```text
/opt/roadmap-ai/.env
```

This prevents deployment environment variables from being tied to the GitHub Actions working directory.

---

# 🔁 Recommended Development Flow

```text
Create feature branch
        ↓
Make changes
        ↓
Run tests locally
        ↓
git push
        ↓
Open Pull Request
        ↓
Review
        ↓
Merge to master
        ↓
DevSecOps pipeline
        ↓
Security checks
        ↓
Build / deployment
        ↓
DAST
        ↓
Production
```

---

# 🧹 Cleanup

Stop the local development server with:

```text
Ctrl + C
```

Stop Docker Compose:

```bash
docker compose down
```

Remove the local E2E database:

```bash
rm -f sqlite.e2e.db
```

---

# 🤝 Credits

## Original Author

This project is based on the original Roadmap AI project by:

**Shubham Londhe (`LondheShubham153`)**

Original GitHub profile:

https://github.com/LondheShubham153

The original project's application structure, concept, and source implementation should be attributed to the original author.

## This Fork

Deployment, infrastructure, CI/CD, DevSecOps workflows, testing automation, and deployment configuration in this fork were implemented by:

**Shashank Pipal**

GitHub:

https://github.com/shashankcodes-10

Live deployment:

https://roadmap-ai.shashankpipal.in/

---

# ⭐ Acknowledgement

This repository is maintained as a learning and DevOps/DevSecOps implementation based on the original Roadmap AI project.

The goal of this fork is to demonstrate how an existing full-stack application can be:

* Containerized
* Tested
* Security scanned
* Integrated with CI/CD
* Deployed
* Monitored through automated security checks

while preserving credit to the original application author.


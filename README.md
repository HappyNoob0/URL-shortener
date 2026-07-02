# 🚀 Scalable Distributed URL Shortener

A production-oriented distributed URL shortening platform built using **React, Fastify, MongoDB, Redis, Docker, Nginx, JWT Authentication, ZooKeeper, and Rate Limiting**.

The platform provides secure URL shortening, distributed token generation, analytics tracking, caching, authentication, load balancing, and protection against API abuse.

---

# ✨ Features

- 🔗 URL Shortening
- 🔐 JWT Authentication
- 👤 User Registration & Login
- 📊 Analytics Dashboard
- 👥 Unique Visitor Tracking
- 🌐 Browser Detection
- 📱 Device Detection
- 📈 Click Tracking
- 🌍 Visitor Location Tracking
- ⚡ Redis Caching
- 🚦 API Rate Limiting
- 🐳 Dockerized Deployment
- ⚖️ Nginx Load Balancing
- 🦓 ZooKeeper-Based Token Generation

---

# 🏗️ System Architecture

```text
                    Client Browser
                           │
                           ▼
                 Nginx Reverse Proxy
                           │
                    Load Balancer
                           │
          ┌────────────────┼────────────────┐
          ▼                ▼                ▼
      Server-1         Server-2         Server-3
      (Fastify)        (Fastify)        (Fastify)
          │                │                │
          └────────────────┼────────────────┘
                           │
                           ▼
                       Redis Cache
                           │
                           ▼
                        MongoDB
                           │
                           ▼
                       ZooKeeper
```

---

# 🔗 URL Shortening Strategy

Unlike traditional URL shorteners that rely on Base62 encoding of database IDs, this system uses ZooKeeper-assisted distributed token generation.

## Token Characteristics

- Character Set: **A-Z, a-z, 0-9**
- Token Length: **6**
- Total Possible URLs: **62^6 = 56,800,235,584 (~56.8 Billion)**

### Example

**Original URL**

```text
https://leetcode.com/problems/two-sum
```

**Generated Token**

```text
tyDLAj
```

**Short URL**

```text
http://localhost/tyDLAj
```

### Benefits

- ✅ Collision Resistant
- ✅ No Sequential IDs
- ✅ Horizontally Scalable
- ✅ Distributed-System Friendly
- ✅ Difficult to Predict

---

# 🔄 URL Creation Flow

```text
User
 ↓
Submit URL
 ↓
Validate URL
 ↓
Check Existing URL
 ↓
Generate Distributed Token (ZooKeeper)
 ↓
Store URL Mapping (MongoDB)
 ↓
Cache URL Mapping (Redis)
 ↓
Return Short URL
```

---

# 🚦 URL Redirection Flow

```text
User Opens Short URL
          ↓
         Nginx
          ↓
     Fastify Server
          ↓
      Redis Check
          ↓
   Hit           Miss
    ↓              ↓
Return URL     MongoDB
                  ↓
             Cache Result
                  ↓
          Save Analytics
                  ↓
              Redirect
```

---

# 📊 Analytics Dashboard

Visitor information collected:

- 🌍 Country
- 🗺️ Region / State
- 🏙️ City
- 🌐 Browser
- 📱 Device Type
- 📍 IP Address
- 🕒 Timestamp

Dashboard metrics:

- 👥 Total Visitors
- 🎯 Unique Visitors
- 🌐 Unique Browsers
- 📱 Unique Devices
- 📈 Total Clicks

---

# 🔐 Authentication

## Registration

```text
User → Register → Hash Password (bcrypt) → MongoDB
```

## Login

```text
User → Login → Verify Password → Generate JWT → Return Token → Store in Browser
```

---

# ⚡ Redis Caching

```text
Request
 ↓
Redis Lookup
 ↓
Hit → Return URL

Miss
 ↓
MongoDB
 ↓
Store in Redis
 ↓
Return URL
```

Benefits:

- Faster URL Resolution
- Reduced Database Load
- Lower Response Latency
- Improved Scalability

---

# 🚦 Rate Limiting

API rate limiting is implemented using **Fastify Rate Limit**.

| Endpoint | Limit |
|----------|-------|
| `POST /api/urls` | **20 requests/minute/IP** |
| All Other API Endpoints | **100 requests/minute/IP** |

Benefits:

- 🛡️ Prevents Abuse
- 🔐 Protects Backend Resources
- ⚡ Reduces Unnecessary Load
- 📈 Improves Stability
- 🌐 Supports Scalable Systems

---

# ⚖️ Load Balancing

Nginx distributes incoming requests using **Round Robin**.

```text
Request 1 → Server-1
Request 2 → Server-2
Request 3 → Server-3
Request 4 → Server-1
```

---

# 🦓 ZooKeeper Coordination

ZooKeeper coordinates distributed token generation to prevent collisions across multiple Fastify instances.

---

# 🛠️ Tech Stack

## Frontend
- React
- TypeScript
- Material UI
- Redux Toolkit Query
- React Router

## Backend
- Node.js
- Fastify
- TypeScript

## Database
- MongoDB
- Mongoose

## Cache
- Redis
- ioredis

## Authentication
- JWT
- bcrypt

## Infrastructure
- Docker
- Docker Compose
- Nginx
- ZooKeeper

## Analytics
- geoip-lite
- ua-parser-js

---

# 🚀 Run Locally

```bash
git clone https://github.com/PRIYANSHUMNNIT01/Distributed-url-shortener.git
cd Distributed-url-shortener
docker compose up --build
```

Application URLs

- Frontend: http://localhost
- Backend: http://localhost/api

---

# ⚡ Performance Benchmark

Benchmarked using **wrk** with **4 threads**, **100 concurrent connections**, and **30 seconds** duration.

## Frontend Benchmark

```bash
wrk --latency -t4 -c100 -d30s http://localhost:5173/
```

| Metric | Value |
|--------|------:|
| Average Latency | **12.35 ms** |
| P50 Latency | **10.88 ms** |
| P90 Latency | **12.66 ms** |
| P99 Latency | **47.57 ms** |
| Requests/sec | **8705.40** |
| Transfer/sec | **10.59 MB/s** |

## Backend Benchmark

```bash
wrk --latency -t4 -c100 -d30s http://localhost/n60fxD
```

| Metric | Value |
|--------|------:|
| Average Latency | **108.39 ms** |
| P50 Latency | **105.62 ms** |
| P90 Latency | **126.37 ms** |
| P99 Latency | **173.30 ms** |
| Requests/sec | **920.91** |
| Transfer/sec | **1.12 MB/s** |

### Benchmark Environment

- Docker Compose
- Nginx Reverse Proxy
- 3 Fastify Backend Instances
- Redis
- MongoDB
- ZooKeeper

---

# 📈 Scalability Highlights

- Multiple Fastify Backend Instances
- Nginx Load Balancer
- Redis Caching Layer
- ZooKeeper Distributed Coordination
- MongoDB Persistent Storage
- API Rate Limiting
- Dockerized Infrastructure

The system is designed to scale horizontally by adding additional Fastify instances behind Nginx.

---

# 🔮 Future Improvements

- 📱 QR Code Generation
- ✏️ Custom Short URLs
- 📊 Interactive Analytics Charts
- ☁️ Cloud Deployment (AWS/GCP)
- 📧 Email Verification
- 🔑 Password Reset
- 🌎 Country-Wise Traffic Reports
- 🛡️ Cloudflare Integration
- ⏳ Custom Expiration Policies
- 🚦 Redis-Based Distributed Rate Limiting
- 📈 Prometheus & Grafana Monitoring

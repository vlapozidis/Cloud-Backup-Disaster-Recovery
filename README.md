# ☁️Cloud Backup & Disaster Recovery for University Management System (Azure SQL)

## 📌 Project Overview

This project focuses on the design and implementation of a complete **Cloud Backup & Disaster Recovery system** for a university management information system, built specifically using Azure SQL Database.

The main objectives are:
- Creating and inserting records and indexes  
- Disaster Recovery capability
- Secure and reliable backup strategy
- Monitoring and alerting infrastructure

---

## 🏗️ System Architecture

The system includes the following components:

- Primary Azure SQL Database (production)
- Geo-replicated Secondary Database (DR region)
- Azure Blob Storage for backups
- Azure Monitor & Log Analytics Workspace for monitoring

📌 Architecture Diagram:

<img width="545" height="402" alt="image" src="https://github.com/user-attachments/assets/b8b2ad0f-791a-4d86-8fa0-3a224c205f8e" />

## 📊 Phase 1 — Design & Setup

### 1. ER Diagram

A relational database schema was designed with 10 tables including proper primary and foreign key relationships.

📌 ER Diagram:

<img width="2470" height="948" alt="image" src="https://github.com/user-attachments/assets/c9570491-fa36-431d-9d10-0c6e60027e18" />

### 2. Azure Setup

- Created Azure Free Tier subscription
- Created Resource Group
---
## 🗄️ Phase 2 — Production Database Setup

### 1. Azure SQL Database Provisioning

- Created SQL Server (logical server)
- Deployed Azure SQL Database (Basic tier)
- Configured firewall rules (IP whitelisting)
- Connected using SSMS / Azure Data Studio

<img width="2470" height="948" alt="image" src="https://github.com/user-attachments/assets/ee6347b9-f09a-4153-a221-ebd9474080dc" />

---

### 3. Performance Baseline

- Configured Azure Monitor metrics
- Tracked DTU / vCore usage
- Monitored active connections

📌 Monitoring Dashboard (Baseline):


---

## 💾 Phase 3 — Backup Strategy

### 1. Automated Backups (Azure Native)

The Azure SQL Database provides automatic backups:

- Full backups
- Differential backups
- Transaction log backups

Retention policies:
- Short-term retention 
- Long-term retention 

📌 Backup Configuration:

<img width="1452" height="46" alt="image" src="https://github.com/user-attachments/assets/6cd5078b-9853-4ff5-8bf9-5cb2246b7625" />


---

### 2. Manual Backup (BACPAC Export)

- Exported database as `.bacpac` file
- Stored backup in azure blob storage  
- Verified file in storage container

📌 Blob Storage:


<img width="1695" height="338" alt="image" src="https://github.com/user-attachments/assets/c062645b-7871-44e2-8bdd-aaa05690da23" />


## 🌍 Phase 4 — Geo-Replication & High Availability

### 1. Active Geo-Replication

- Created a secondary server in a different Azure region
- Configured active geo-replication
- Monitored replication status and lag

📌 Geo-Replication Topology:

<img width="1297" height="324" alt="image" src="https://github.com/user-attachments/assets/fd8e4346-1512-4611-85dc-d59d4530d5f4" />


-This architecture represents a geo-replication setup where an application interacts with a primary database responsible for all read and write operations, while a secondary database in a different region is asynchronously synchronized as a read-only replica. The secondary database is used for disaster recovery and can take over in case of primary failure, improving system availability and reducing downtime through failover capability.

- RPO: Near-zero (typically < 1 minute) due to asynchronous replication between primary and secondary regions.
- RTO: 1–5 minutes due to fast failover capability to the secondary region.
RPO and RTO are not fixed values but depend on the Azure SQL Database geo-replication configuration; typically RPO is under 1 minute and RTO is between 1–5 minutes.

This ensures minimal data loss and fast recovery in case of failure.

📌 Disaster Recovery Architecture:

<img width="589" height="325" alt="image" src="https://github.com/user-attachments/assets/dd1486a7-7a68-4d8d-9a6f-30cc82c5fbcf" />

---

## ♻️ Phase 5 — Restore Process

### 1. Point-in-Time Restore

- Simulated incident using accidental DELETE/UPDATE operations
- Restored database to a previous safe timestamp
- Verified data integrity using SQL queries

📌 Incident Example:

![Incident](./screenshots/incident.png)

📌 Restore Process:

![Restore](./screenshots/point-in-time-restore.png)

---
## 📡 Phase 6 — Monitoring & Alerting

- Configured Azure Monitor alerts
- Created Log Analytics Workspace
- Built dashboards for key performance metrics

📌 Monitoring Dashboard:

![Monitoring Dashboard](./screenshots/monitoring-dashboard.png)

📌 Alert Rules:

![Alerts](./screenshots/alerts.png)

---


































---

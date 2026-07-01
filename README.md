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

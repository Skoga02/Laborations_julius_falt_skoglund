README - YrkesCO Database Project

Author: Julius Fält Skoglund 
Course: Datamodellering
School: STI - Stockholms Tekniska Institut

============================================================
PROJECT DESCRIPTION
============================================================

This repository contains a complete database design and implementation
for the vocational school YrkesCo.

The project is divided into two main parts:
- Uppgift 0: Datamodellering
- Uppgift 1: Implementation

The purpose of the project is to design a normalized, scalable, and
well-structured relational database that replaces spreadsheet-based
data handling and supports YrkesCo’s educational operations.

The project follows a full database design workflow.
- Conceptual modeling
- Logical modeling
- Physical modeling
- Implemetation in PostgreSQL
- Validation using SQL JOIN queries

============================================================
FOLDER STRUCTURE
============================================================

lab_yrkesco/
│
├── uppgift_0/
│   │
│   ├── conceptual_model/
│   │   Conceptual ERD created using Crow’s Foot notation.
│   │   Focuses on entities, relationships, and cardinalities
│   │   without technical implementation details.
│   │
│   ├── logical_model/
│   │   Logical data model derived from the conceptual model.
│   │   Includes tables, primary keys, foreign keys, and
│   │   associative entities.
│   │
│   ├── physical_model/
│   │   Physical representation of the database structure
│   │   used as the basis for SQL implementation.
│   │
│   ├── 3NF argumentative text.pdf
│   │   Written argumentation explaining why the database
│   │   fulfills Third Normal Form (3NF).
│   │
│   ├── schema_smal.sql
│   │   SQL schema file used for structural validation
│   │   of the database model.
│   │
│   ├── validation_*
│   │   Supporting validation files used to verify the
│   │   correctness and structure of the data model.
│   │
│   ├── docker-compose.yml
│   │   Docker configuration used during modeling and validation.
│   │
│   └── .env
│       Environment variables used for local configuration.
│
├── uppgift_1/
│   ├── 01_create_tables.sql
│   │   SQL script that drops existing tables and creates all
│   │   database tables with primary keys, foreign keys, and
│   │   constraints.
│   │
│   ├── 02_insert_data.sql
│   │   SQL script that inserts fake test data into the database.
│   │   The data is minimal but sufficient to verify relationships.
│   │
│   ├── 03_queries.sql
│   │   SQL queries using JOINs to validate the database design
│   │   and retrieve information across multiple tables.
│   │
│   ├── docker-compose.yml
│   │   Docker configuration for running PostgreSQL in a container.
│   │   PostgreSQL is exposed on port 5433 to avoid conflicts with
│   │   existing local installations.
│   │
│   └── result-screenshot-uppgift1.png
│       Screenshot showing successful execution of queries.
│
├── .gitignore
│
└── readme.txt
│   Project documentation.

============================================================
HOW TO RUN THE PROJECT
============================================================

1. Start PostgreSQL using Docker:
   docker-compose up -d

2. Connect to the database using pgAdmin or psql:
   Host: localhost
   Port: 5433
   Database: yrkco_db
   User: postgres
   Password: postgres123

3. Run the SQL scripts in the following order:
   1) 01_create_tables.sql
   2) 02_insert_data.sql
   3) 03_queries.sql
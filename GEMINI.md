# Gemini Code Assistant Context

This document provides context for the Gemini code assistant to understand the project structure and conventions.

## Project Overview

This project is a microservices-based e-commerce application. It consists of several services that work together to provide product information, recommendations, and reviews. The services are containerized using Docker and orchestrated using `docker-compose`.

The main services are:

*   **product-service**: Manages the product catalog.
*   **recommendation-service**: Provides product recommendations.
*   **review-service**: Manages customer reviews.
*   **product-composite**: A composite service that aggregates data from the other services and exposes a public API.
*   **gateway**: The API gateway for the microservices.
*   **auth-server**: Handles authentication and authorization.
*   **config-server**: Provides centralized configuration for all services.
*   **eureka**: A service discovery agent that allows services to find each other.

The project also uses the following infrastructure services:

*   **MongoDB**: A NoSQL database used by the `product-service` and `recommendation-service`.
*   **MySQL**: A relational database used by the `review-service`.
*   **Kafka**: A message broker for asynchronous communication between services.

## Observability

The project uses a comprehensive observability stack to monitor the health and performance of the services. The stack includes the following components:

*   **Grafana**: A multi-platform open source analytics and interactive visualization web application. It provides charts, graphs, and alerts for the web when connected to supported data sources.
*   **Loki**: A horizontally-scalable, highly-available, multi-tenant log aggregation system inspired by Prometheus.
*   **Fluent-bit**: A fast and lightweight log processor and forwarder.
*   **Prometheus**: An open-source systems monitoring and alerting toolkit.
*   **Tempo**: A high-volume, minimal-dependency distributed tracing backend.

## Building and Running

The project can be built and run using `docker-compose`.

To build the services, run the following command from the directory containing the `docker-compose.yml` file:

```bash
docker-compose build
```

To start the services, run the following command:

```bash
docker-compose up
```

The `product-composite` service will be available at `http://localhost:8080`.

## Development Conventions

*   The project follows the standard Spring Boot project structure.
*   The code is written in a reactive style using Project Reactor.
*   The service communicates with other services asynchronously using messaging (Kafka) for create and delete operations, and synchronously using HTTP for get operations.
*   The project uses Eureka for service discovery.
*   The project uses `springdoc-openapi` to generate OpenAPI documentation.
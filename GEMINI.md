# Gemini Code Assistant Context

This document provides context for the Gemini code assistant to understand the project structure and conventions.

## Project Overview

This project is a microservices-based e-commerce application. It consists of several services that work together to provide product information, recommendations, and reviews. The services are containerized using Docker and orchestrated using `docker-compose`.

The main services are:

*   **product-service**: Manages the product catalog.
*   **recommendation-service**: Provides product recommendations.
*   **review-service**: Manages customer reviews.
*   **product-composite**: A composite service that aggregates data from the other services and exposes a public API.

The project also uses the following infrastructure services:

*   **MongoDB**: A NoSQL database used by the `product-service` and `recommendation-service`.
*   **MySQL**: A relational database used by the `review-service`.
*   **Kafka**: A message broker for asynchronous communication between services.
*   **Eureka**: A service discovery agent that allows services to find each other.

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

TODO: Add information about coding style, testing practices, and other development conventions.

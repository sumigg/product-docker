#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
CYAN='\033[0;36m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Store the original location and script location
ORIGINAL_DIR=$(pwd)
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Function to build a service
build_service() {
    local service_name=$1
    local service_path=$2
    
    echo -e "\n${CYAN}Building ${service_name}...${NC}"
    cd "${SCRIPT_DIR}/../${service_path}" || {
        echo -e "${RED}Failed to change directory to ${service_path}${NC}"
        return 1
    }
    
    # Check if mvnw exists and is executable
    if [ ! -x "./mvnw" ]; then
        echo -e "${YELLOW}Making mvnw executable for ${service_name}${NC}"
        chmod +x ./mvnw
    fi
    
    ./mvnw clean install -DskipTests
    if [ $? -ne 0 ]; then
        echo -e "${RED}Failed to build ${service_name}${NC}"
        return 1
    fi
    
    echo -e "${GREEN}Successfully built ${service_name}${NC}"
    return 0
}

# Main build process
main() {
    echo -e "${GREEN}Starting build process for all projects...${NC}"
    
    # Array of services to build in order
    # First build the core dependencies (API and util)
    local core_services=(
        "product-api"
        "product-util"
    )

    # Then build the services
    local microservices=(
        "product-service"
        "recommendation-servise"
        "review-service"
        "product-composite-service"
        "product-eureka-server"
        "gateway"
        "auth-server"
    )

    # Build core dependencies first
    echo -e "${YELLOW}Building core dependencies...${NC}"
    for service_path in "${core_services[@]}"; do
        if ! build_service "$service_path" "$service_path"; then
            echo -e "${RED}Build process failed at ${service_path}${NC}"
            cd "$ORIGINAL_DIR"
            exit 1
        fi
    done

    # Then build microservices
    echo -e "\n${YELLOW}Building microservices...${NC}"
    for service_path in "${microservices[@]}"; do
        if ! build_service "$service_path" "$service_path"; then
            echo -e "${RED}Build process failed at ${service_path}${NC}"
            cd "$ORIGINAL_DIR"
            exit 1
        fi
    done
    

    
    echo -e "\n${GREEN}All projects built successfully!${NC}"
    
    # Return to original directory
    cd "$ORIGINAL_DIR"
}

# Run main function
main

#!/bin/bash
set -e

echo "📦 Building Docker images..."

# Build images using host Docker
docker build -t auth-service:latest ./auth-service
docker build -t order-service:latest ./order-service
docker build -t payment-service:latest ./payment-service
docker build -t restaurant-service:latest ./restaurant-service

echo "🚚 Loading images into Minikube..."
# Load images into Minikube context
minikube image load auth-service:latest
minikube image load order-service:latest
minikube image load payment-service:latest
minikube image load restaurant-service:latest

echo "✅ Images built and loaded successfully!"

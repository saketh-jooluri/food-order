#!/bin/bash
echo "🔍 Debugging Postgres..."
NAMESPACE="food-app"
POD_NAME=$(kubectl get pods -n $NAMESPACE -l app=postgres -o jsonpath="{.items[0].metadata.name}")

if [ -z "$POD_NAME" ]; then
  echo "❌ Postgres pod not found!"
  exit 1
fi

echo "📋 Pod Details: $POD_NAME"
kubectl describe pod $POD_NAME -n $NAMESPACE

echo "📜 Logs:"
kubectl logs $POD_NAME -n $NAMESPACE

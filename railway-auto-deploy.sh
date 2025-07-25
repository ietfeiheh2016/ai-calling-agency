#!/bin/bash

# Railway Auto-Deploy Script
# Using Railway API to fully automate deployment

RAILWAY_TOKEN="279cb008-ce13-44bc-b675-03e3b7901cc5"
PROJECT_ID="e00f1ce5-af78-469a-9e79-1cf90990574f"

echo "🚄 Starting automated Railway deployment..."

# Function to make Railway API calls
railway_api() {
    curl -s -X POST \
        https://backboard.railway.app/graphql \
        -H "Authorization: Bearer $RAILWAY_TOKEN" \
        -H "Content-Type: application/json" \
        -d "$1"
}

# 1. Create service in the existing project
echo "📦 Creating service..."
CREATE_SERVICE_MUTATION='{
    "query": "mutation serviceCreate($input: ServiceCreateInput!) { serviceCreate(input: $input) { id name } }",
    "variables": {
        "input": {
            "name": "ai-calling-backend",
            "projectId": "'$PROJECT_ID'",
            "source": {
                "repo": "ietfeiheh2016/ai-calling-agency"
            }
        }
    }
}'

SERVICE_RESPONSE=$(railway_api "$CREATE_SERVICE_MUTATION")
echo "Service created: $SERVICE_RESPONSE"

# Extract service ID (simplified - assumes successful response)
SERVICE_ID=$(echo $SERVICE_RESPONSE | grep -o '"id":"[^"]*' | cut -d'"' -f4)
echo "Service ID: $SERVICE_ID"

# 2. Set environment variables
echo "🔧 Setting environment variables..."

ENV_VARS=(
    "NODE_ENV:production"
    "PORT:5000"
    "SUPABASE_URL:https://ygnnzatykjuuwbxvorfc.supabase.co"
    "SUPABASE_SERVICE_KEY:eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inlnbm56YXR5a2p1dXdieHZvcmZjIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc1MzQ4MDI4OCwiZXhwIjoyMDY5MDU2Mjg4fQ.0sjJnpo96GL_MteLimP1SBiQCwsUAJH5gee3LDV5hFM"
    "UPSTASH_REDIS_REST_URL:https://us1-social-jay-31150.upstash.io"
    "UPSTASH_REDIS_REST_TOKEN:ATdOAAIjcDFlMGJlNmVkMTZkNjI0OGU5YTc4M2JkMGUzZWQ3OTFlOHAxMA"
    "RESEND_API_KEY:AjdOAAIgcDEYBKqkyhftF5HF7-8ATg8FQ3SSGibvlH2CQJuwz5ZOAg"
    "JWT_SECRET:ai-calling-agency-super-secret-jwt-2024"
    "FRONTEND_URL:https://ai-calling-agency.vercel.app"
)

for env_var in "${ENV_VARS[@]}"; do
    KEY="${env_var%%:*}"
    VALUE="${env_var#*:}"
    
    ENV_MUTATION='{
        "query": "mutation variableUpsert($input: VariableUpsertInput!) { variableUpsert(input: $input) { id } }",
        "variables": {
            "input": {
                "projectId": "'$PROJECT_ID'",
                "serviceId": "'$SERVICE_ID'",
                "name": "'$KEY'",
                "value": "'$VALUE'"
            }
        }
    }'
    
    echo "Setting $KEY..."
    railway_api "$ENV_MUTATION" > /dev/null
done

# 3. Deploy the service
echo "🚀 Triggering deployment..."
DEPLOY_MUTATION='{
    "query": "mutation deploymentCreate($input: DeploymentCreateInput!) { deploymentCreate(input: $input) { id status } }",
    "variables": {
        "input": {
            "serviceId": "'$SERVICE_ID'",
            "projectId": "'$PROJECT_ID'"
        }
    }
}'

DEPLOY_RESPONSE=$(railway_api "$DEPLOY_MUTATION")
echo "Deployment triggered: $DEPLOY_RESPONSE"

# 4. Get service URL
echo "🌐 Getting service URL..."
SERVICE_QUERY='{
    "query": "query service($id: String!) { service(id: $id) { name domains { domain } } }",
    "variables": {
        "id": "'$SERVICE_ID'"
    }
}'

sleep 5  # Wait a bit for deployment to start
SERVICE_INFO=$(railway_api "$SERVICE_QUERY")
echo "Service info: $SERVICE_INFO"

echo ""
echo "✅ Deployment initiated successfully!"
echo ""
echo "🔗 Your API will be available at:"
echo "   https://$SERVICE_ID.railway.app"
echo ""
echo "📊 Monitor deployment progress at:"
echo "   https://railway.app/project/$PROJECT_ID"
echo ""
echo "🧪 Test endpoints:"
echo "   Health: https://$SERVICE_ID.railway.app/health"
echo "   API Status: https://$SERVICE_ID.railway.app/api/v1/status"
echo ""
echo "⏳ Deployment typically takes 2-3 minutes to complete."
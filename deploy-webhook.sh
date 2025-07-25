#!/bin/bash

# Deploy using GitHub webhook trigger
echo "🚀 Triggering Railway deployment via webhook..."

# Railway project webhook URL (if configured)
WEBHOOK_URL="https://railway.app/webhooks/deploy/$PROJECT_ID"

# Trigger deployment
curl -X POST "$WEBHOOK_URL" \
  -H "Authorization: Bearer 279cb008-ce13-44bc-b675-03e3b7901cc5" \
  -H "Content-Type: application/json" \
  -d '{
    "ref": "refs/heads/main",
    "repository": {
      "full_name": "ietfeiheh2016/ai-calling-agency"
    }
  }'

echo "✅ Webhook triggered!"

# Alternative: Use Railway CLI simulation
echo ""
echo "🛠️ Simulating Railway CLI commands..."
echo "railway login --token 279cb008-ce13-44bc-b675-03e3b7901cc5"
echo "railway link e00f1ce5-af78-469a-9e79-1cf90990574f"
echo "railway up"

# Create a deployment configuration file
cat > railway.yaml << 'EOF'
version: 2
services:
  backend:
    build:
      command: cd backend && npm install
    start:
      command: cd backend && npm start
    variables:
      NODE_ENV: production
      PORT: 5000
      SUPABASE_URL: https://ygnnzatykjuuwbxvorfc.supabase.co
      SUPABASE_SERVICE_KEY: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inlnbm56YXR5a2p1dXdieHZvcmZjIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc1MzQ4MDI4OCwiZXhwIjoyMDY5MDU2Mjg4fQ.0sjJnpo96GL_MteLimP1SBiQCwsUAJH5gee3LDV5hFM
      FRONTEND_URL: https://ai-calling-agency.vercel.app
EOF

echo "✅ Railway configuration created!"
echo ""
echo "🔗 Your project is ready at:"
echo "   GitHub: https://github.com/ietfeiheh2016/ai-calling-agency"
echo "   Railway Project: https://railway.app/project/e00f1ce5-af78-469a-9e79-1cf90990574f"
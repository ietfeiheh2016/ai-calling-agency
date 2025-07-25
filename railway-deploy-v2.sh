#!/bin/bash

# Railway Deployment Script v2 - Using REST API
RAILWAY_TOKEN="279cb008-ce13-44bc-b675-03e3b7901cc5"
PROJECT_ID="e00f1ce5-af78-469a-9e79-1cf90990574f"

echo "🚄 Railway Automated Deployment v2"
echo "=================================="

# Create deployment using Railway's deploy endpoint
echo "🚀 Creating deployment..."

# Try to deploy directly using Railway's deployment API
curl -X POST \
  "https://railway.app/api/project/$PROJECT_ID/service" \
  -H "Authorization: Bearer $RAILWAY_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "ai-calling-backend",
    "source": {
      "repo": "ietfeiheh2016/ai-calling-agency",
      "branch": "main"
    },
    "variables": {
      "NODE_ENV": "production",
      "PORT": "5000",
      "SUPABASE_URL": "https://ygnnzatykjuuwbxvorfc.supabase.co",
      "SUPABASE_SERVICE_KEY": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inlnbm56YXR5a2p1dXdieHZvcmZjIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc1MzQ4MDI4OCwiZXhwIjoyMDY5MDU2Mjg4fQ.0sjJnpo96GL_MteLimP1SBiQCwsUAJH5gee3LDV5hFM",
      "UPSTASH_REDIS_REST_URL": "https://us1-social-jay-31150.upstash.io",
      "UPSTASH_REDIS_REST_TOKEN": "ATdOAAIjcDFlMGJlNmVkMTZkNjI0OGU5YTc4M2JkMGUzZWQ3OTFlOHAxMA",
      "RESEND_API_KEY": "AjdOAAIgcDEYBKqkyhftF5HF7-8ATg8FQ3SSGibvlH2CQJuwz5ZOAg",
      "JWT_SECRET": "ai-calling-agency-super-secret-jwt-2024",
      "FRONTEND_URL": "https://ai-calling-agency.vercel.app"
    }
  }'

echo -e "\n\n📋 Alternative Deployment Methods:"
echo "=================================="
echo ""
echo "1. 🌐 Web Interface (Easiest):"
echo "   - Go to: https://railway.app/new"
echo "   - Select 'Deploy from GitHub repo'"
echo "   - Choose: ietfeiheh2016/ai-calling-agency"
echo "   - Railway will auto-detect the configuration"
echo ""
echo "2. 🔗 Direct GitHub Integration:"
echo "   - Go to: https://railway.app/project/$PROJECT_ID"
echo "   - Click 'New Service'"
echo "   - Select 'GitHub Repo'"
echo "   - Choose your repository"
echo ""
echo "3. 📦 Template Deployment:"
echo "   - Use this URL: https://railway.app/template/supabase"
echo "   - Connect your GitHub repo when prompted"
echo ""
echo "🔧 Environment Variables to Set:"
echo "NODE_ENV=production"
echo "PORT=5000"
echo "SUPABASE_URL=https://ygnnzatykjuuwbxvorfc.supabase.co"
echo "SUPABASE_SERVICE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inlnbm56YXR5a2p1dXdieHZvcmZjIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc1MzQ4MDI4OCwiZXhwIjoyMDY5MDU2Mjg4fQ.0sjJnpo96GL_MteLimP1SBiQCwsUAJH5gee3LDV5hFM"
echo "FRONTEND_URL=https://ai-calling-agency.vercel.app"
echo ""
echo "✅ Your GitHub repo is ready for deployment!"
echo "🔗 Repository: https://github.com/ietfeiheh2016/ai-calling-agency"
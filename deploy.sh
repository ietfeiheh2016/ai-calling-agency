#!/bin/bash

# AI Calling Agency - Deployment Script
# This script helps you deploy your app using free services

echo "🚀 AI Calling Agency - Free Deployment Setup"
echo "=============================================="

# Check if git is initialized
if [ ! -d ".git" ]; then
    echo "📁 Initializing Git repository..."
    git init
    git add .
    git commit -m "Initial commit: AI calling agency with Supabase integration"
    echo "✅ Git repository initialized"
else
    echo "✅ Git repository already exists"
fi

echo ""
echo "📋 DEPLOYMENT CHECKLIST"
echo "======================="
echo ""

echo "1. 🗄️  SUPABASE SETUP (Database + Auth + Storage)"
echo "   → Go to: https://supabase.com"
echo "   → Create new project"
echo "   → Copy your project details"
echo "   → Run the SQL schema from docs/DEPLOYMENT.md"
echo ""

echo "2. 🔥 UPSTASH SETUP (Redis for Queues)"
echo "   → Go to: https://upstash.com"
echo "   → Create Redis database"
echo "   → Copy connection details"
echo ""

echo "3. 📧 RESEND SETUP (Email Service)"
echo "   → Go to: https://resend.com"
echo "   → Get API key (3000 emails/month free)"
echo ""

echo "4. 🚄 RAILWAY SETUP (Backend Deployment)"
echo "   → Go to: https://railway.app"
echo "   → Connect this GitHub repo"
echo "   → Select 'backend' folder as root"
echo "   → Add environment variables"
echo ""

echo "5. ⚡ VERCEL SETUP (Frontend Deployment)"
echo "   → Go to: https://vercel.com"
echo "   → Import GitHub repository"
echo "   → Set root directory to 'frontend'"
echo "   → Framework preset: 'Vite'"
echo "   → Add environment variables"
echo ""

echo "🔧 NEXT STEPS:"
echo "==============="
echo ""
echo "1. Push this repository to GitHub:"
echo "   git remote add origin https://github.com/YOUR-USERNAME/ai-calling-agency.git"
echo "   git branch -M main"
echo "   git push -u origin main"
echo ""
echo "2. Follow the setup guides for each service above"
echo ""
echo "3. Update environment variables with your actual values:"
echo "   - backend/.env.production"
echo "   - frontend/.env.production"
echo ""
echo "4. Deploy and test your application!"
echo ""

echo "💡 HELPFUL LINKS:"
echo "=================="
echo "📖 Full deployment guide: ./docs/DEPLOYMENT.md"
echo "🔧 Backend environment: ./backend/.env.production"
echo "⚡ Frontend environment: ./frontend/.env.production"
echo "🚀 Vercel config: ./deploy/vercel.json"
echo "🚄 Railway config: ./deploy/railway.json"
echo ""

echo "🎉 You're all set! Happy deploying!"

# Make script executable
chmod +x deploy.sh
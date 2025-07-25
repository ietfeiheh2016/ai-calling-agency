# ⚡ Quick Start Guide

Get your AI Calling Agency live in **15 minutes** using **100% FREE** services!

## 🎯 What You'll Get

- ✅ Professional calling agency platform
- ✅ AI-powered call summaries
- ✅ Real-time dashboard
- ✅ Client management
- ✅ Appointment scheduling
- ✅ Call recording & transcription
- ✅ Analytics & reporting

## 🛠 Free Services Stack

| Service | Purpose | Free Tier |
|---------|---------|-----------|
| **Supabase** | Database + Auth | 500MB DB, 50MB storage |
| **Vercel** | Frontend hosting | Unlimited personal projects |
| **Railway** | Backend hosting | $5/month usage credit |
| **Upstash** | Redis queue | 10K commands/day |
| **Resend** | Email service | 3000 emails/month |

## 🚀 5-Step Deployment

### Step 1: Create GitHub Repository

```bash
# Navigate to your project
cd ai-calling-agency

# Initialize git
git init
git add .
git commit -m "Initial commit"

# Create GitHub repo and push
git remote add origin https://github.com/YOUR-USERNAME/ai-calling-agency.git
git branch -M main
git push -u origin main
```

### Step 2: Setup Supabase (2 minutes)

1. Go to [supabase.com](https://supabase.com) → Create account
2. **Create New Project**:
   - Name: `ai-calling-agency`
   - Password: (save this!)
   - Region: Choose closest
3. Go to **SQL Editor** → New Query
4. Copy & paste this schema:

```sql
-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Clients table
CREATE TABLE clients (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    business JSONB NOT NULL,
    contact JSONB NOT NULL,
    settings JSONB DEFAULT '{}',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Appointments table
CREATE TABLE appointments (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    client_id UUID REFERENCES clients(id) ON DELETE CASCADE,
    customer JSONB NOT NULL,
    service JSONB NOT NULL,
    datetime TIMESTAMP WITH TIME ZONE NOT NULL,
    status VARCHAR(50) DEFAULT 'scheduled',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Calls table
CREATE TABLE calls (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    client_id UUID REFERENCES clients(id) ON DELETE CASCADE,
    from_number VARCHAR(20) NOT NULL,
    to_number VARCHAR(20) NOT NULL,
    status VARCHAR(50) DEFAULT 'initiated',
    duration INTEGER DEFAULT 0,
    recording_url TEXT,
    transcript TEXT,
    start_time TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Call summaries table
CREATE TABLE call_summaries (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    call_id UUID REFERENCES calls(id) ON DELETE CASCADE,
    client_id UUID REFERENCES clients(id) ON DELETE CASCADE,
    summary TEXT,
    key_points JSONB DEFAULT '[]',
    sentiment VARCHAR(20) DEFAULT 'neutral',
    quality_score JSONB DEFAULT '{}',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

5. **Copy these values** from Settings → API:
   - Project URL: `https://xxx.supabase.co`
   - Anon Key: `eyJhbGc...`
   - Service Role Key: `eyJhbGc...`

### Step 3: Setup Upstash Redis (1 minute)

1. Go to [upstash.com](https://upstash.com) → Create account
2. **Create Database**:
   - Name: `ai-calling-queues`
   - Region: Choose closest
   - Type: Pay as you Scale
3. **Copy connection details**:
   - Redis URL: `redis://default:xxx@xxx.upstash.io:6379`
   - REST URL: `https://xxx.upstash.io`
   - REST Token: `Axxx`

### Step 4: Setup Resend (30 seconds)

1. Go to [resend.com](https://resend.com) → Create account
2. Go to **API Keys** → Create API Key
3. Copy the key: `re_xxx`

### Step 5: Deploy Applications (5 minutes)

#### Deploy Backend (Railway)

1. Go to [railway.app](https://railway.app) → Login with GitHub
2. **New Project** → **Deploy from GitHub repo**
3. Select your `ai-calling-agency` repository
4. **Settings** → **Environment Variables** → Add:

```env
NODE_ENV=production
SUPABASE_URL=https://xxx.supabase.co
SUPABASE_SERVICE_KEY=eyJhbGc... (service role key)
UPSTASH_REDIS_REST_URL=https://xxx.upstash.io
UPSTASH_REDIS_REST_TOKEN=Axxx
RESEND_API_KEY=re_xxx
JWT_SECRET=your-super-secret-jwt-key-change-this
PORT=5000
```

5. **Settings** → **Root Directory** → Set to `backend`
6. **Deploy** → Wait for build to complete
7. Copy your Railway URL: `https://xxx.railway.app`

#### Deploy Frontend (Vercel)

1. Go to [vercel.com](https://vercel.com) → Login with GitHub
2. **Import Project** → Select your `ai-calling-agency` repository
3. **Configure Project**:
   - Framework Preset: **Vite**
   - Root Directory: `frontend`
4. **Environment Variables** → Add:

```env
VITE_API_URL=https://xxx.railway.app/api/v1
VITE_SUPABASE_URL=https://xxx.supabase.co
VITE_SUPABASE_ANON_KEY=eyJhbGc... (anon key)
```

5. **Deploy** → Wait for build to complete
6. Your app is live at: `https://xxx.vercel.app` 🎉

## 🧪 Test Your Deployment

1. Visit your Vercel URL
2. Click **Sign Up** → Create account
3. Login to your dashboard
4. Test creating a client
5. Check if real-time features work

## 🔧 Troubleshooting

### Common Issues:

**❌ CORS Error**
```javascript
// Add your Vercel URL to Railway environment:
ALLOWED_ORIGINS=https://xxx.vercel.app
```

**❌ Database Connection Failed**
```bash
# Check your Supabase URL and keys are correct
# Make sure you ran the SQL schema
```

**❌ Build Failed**
```bash
# Check package.json scripts
# Verify all dependencies are listed
```

### Debug Steps:

1. **Backend Logs**: Railway → View Logs
2. **Frontend Logs**: Vercel → Functions → View Function Logs  
3. **Database**: Supabase → Table Editor
4. **Redis**: Upstash → Data Browser

## 🎯 Next Steps

1. **Custom Domain**: Add your domain in Vercel
2. **Email Templates**: Setup in Resend
3. **Twilio Integration**: Add phone calling
4. **OpenAI Integration**: Add AI features
5. **Monitoring**: Setup Sentry for error tracking

## 💡 Pro Tips

- **Free Limits**: All services have generous free tiers
- **Scaling**: Upgrade individual services as you grow
- **Monitoring**: Set up alerts before hitting limits
- **Backup**: Export your Supabase data regularly

## 🏆 You Did It!

Your AI calling agency is now **LIVE** and ready for business! 

**Share your success**: `https://your-app.vercel.app`

Need help? Check the full docs in `/docs/DEPLOYMENT.md`
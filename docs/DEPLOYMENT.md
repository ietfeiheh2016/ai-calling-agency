# 🚀 Deployment Guide

## Quick Deploy Steps

### 1. Setup Supabase (Database + Auth + Storage)

1. Go to [supabase.com](https://supabase.com) and create account
2. Create new project
3. Copy these values:
   - Project URL: `https://[project-id].supabase.co`
   - Anon Key: `eyJhbGc...`
   - Service Role Key: `eyJhbGc...`

4. Run SQL schema:
```sql
-- Enable required extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Create clients table
CREATE TABLE clients (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    business JSONB NOT NULL,
    contact JSONB NOT NULL,
    settings JSONB DEFAULT '{}',
    subscription JSONB DEFAULT '{}',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create appointments table
CREATE TABLE appointments (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    client_id UUID REFERENCES clients(id) ON DELETE CASCADE,
    customer JSONB NOT NULL,
    service JSONB NOT NULL,
    datetime TIMESTAMP WITH TIME ZONE NOT NULL,
    status VARCHAR(50) DEFAULT 'scheduled',
    metadata JSONB DEFAULT '{}',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create calls table
CREATE TABLE calls (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    client_id UUID REFERENCES clients(id) ON DELETE CASCADE,
    appointment_id UUID REFERENCES appointments(id) ON DELETE SET NULL,
    from_number VARCHAR(20) NOT NULL,
    to_number VARCHAR(20) NOT NULL,
    direction VARCHAR(20) DEFAULT 'outbound',
    status VARCHAR(50) DEFAULT 'initiated',
    duration INTEGER DEFAULT 0,
    recording_url TEXT,
    transcript TEXT,
    metadata JSONB DEFAULT '{}',
    start_time TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    end_time TIMESTAMP WITH TIME ZONE
);

-- Create call_summaries table
CREATE TABLE call_summaries (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    call_id UUID REFERENCES calls(id) ON DELETE CASCADE,
    client_id UUID REFERENCES clients(id) ON DELETE CASCADE,
    summary TEXT,
    key_points JSONB DEFAULT '[]',
    action_items JSONB DEFAULT '[]',
    sentiment VARCHAR(20) DEFAULT 'neutral',
    quality_score JSONB DEFAULT '{}',
    follow_up_required BOOLEAN DEFAULT false,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Enable Row Level Security
ALTER TABLE clients ENABLE ROW LEVEL SECURITY;
ALTER TABLE appointments ENABLE ROW LEVEL SECURITY;
ALTER TABLE calls ENABLE ROW LEVEL SECURITY;
ALTER TABLE call_summaries ENABLE ROW LEVEL SECURITY;

-- Create policies (allow authenticated users to access their data)
CREATE POLICY "Users can access their own data" ON clients
    FOR ALL USING (auth.uid()::text = id::text);

CREATE POLICY "Users can access their appointments" ON appointments
    FOR ALL USING (auth.uid()::text = client_id::text);

CREATE POLICY "Users can access their calls" ON calls
    FOR ALL USING (auth.uid()::text = client_id::text);

CREATE POLICY "Users can access their summaries" ON call_summaries
    FOR ALL USING (auth.uid()::text = client_id::text);
```

### 2. Setup Upstash Redis (Queue Management)

1. Go to [upstash.com](https://upstash.com)
2. Create Redis database
3. Copy connection details:
   - Redis URL: `redis://default:[password]@[endpoint]:6379`
   - REST URL: `https://[endpoint].upstash.io`
   - REST Token: `your-token`

### 3. Setup Resend (Email Service)

1. Go to [resend.com](https://resend.com)
2. Create account and get API key
3. Add domain (optional) or use `onboarding@resend.dev`

### 4. Deploy Backend to Railway

1. Go to [railway.app](https://railway.app)
2. Connect GitHub repo
3. Select backend folder
4. Add environment variables from `.env.production`
5. Deploy automatically

### 5. Deploy Frontend to Vercel

1. Go to [vercel.com](https://vercel.com)
2. Import GitHub repository
3. Set framework preset to "Vite"
4. Set root directory to "frontend"
5. Add environment variables
6. Deploy

### 6. Update Environment Variables

Update these files with your actual values:
- `backend/.env.production`
- `frontend/.env.production`
- `deploy/vercel.json`

## 🔧 Configuration

### Backend Environment Variables
```bash
# Copy your actual values
DATABASE_URL=postgresql://postgres:[PASSWORD]@db.[PROJECT-ID].supabase.co:5432/postgres
SUPABASE_URL=https://[PROJECT-ID].supabase.co
SUPABASE_ANON_KEY=eyJhbGc...
REDIS_URL=redis://default:[PASSWORD]@[ENDPOINT]:6379
RESEND_API_KEY=re_[API-KEY]
```

### Frontend Environment Variables
```bash
REACT_APP_API_URL=https://your-backend.railway.app/api/v1
REACT_APP_SUPABASE_URL=https://[PROJECT-ID].supabase.co
REACT_APP_SUPABASE_ANON_KEY=eyJhbGc...
```

## 🧪 Testing

1. Visit your Vercel URL
2. Register new account
3. Create test client
4. Test API endpoints
5. Check real-time features

## 📱 Mobile Testing

Your app is responsive and works on:
- iOS Safari
- Android Chrome
- Desktop browsers

## 🔍 Monitoring

Add these free monitoring services:
- **Sentry**: Error tracking
- **Vercel Analytics**: Performance
- **Railway Metrics**: Backend monitoring

## 🚨 Troubleshooting

### Common Issues:

1. **CORS Error**: Check `ALLOWED_ORIGINS` in backend
2. **Database Connection**: Verify Supabase connection string
3. **Redis Connection**: Check Upstash credentials
4. **Build Fails**: Check package.json scripts

### Debug Steps:
1. Check Railway logs: `railway logs`
2. Check Vercel function logs
3. Test API endpoints directly
4. Verify environment variables

## 🎯 Next Steps

1. Add custom domain to Vercel
2. Set up email templates in Resend
3. Configure webhook endpoints
4. Add monitoring dashboards
5. Set up CI/CD workflows
const { createClient } = require('@supabase/supabase-js');
const logger = require('../utils/logger');

let supabase = null;

const initializeSupabase = () => {
  try {
    const supabaseUrl = process.env.SUPABASE_URL;
    const supabaseServiceKey = process.env.SUPABASE_SERVICE_KEY;

    if (!supabaseUrl || !supabaseServiceKey) {
      throw new Error('Supabase URL and Service Key are required');
    }

    supabase = createClient(supabaseUrl, supabaseServiceKey, {
      auth: {
        autoRefreshToken: false,
        persistSession: false
      }
    });

    logger.info('Supabase initialized successfully');
    return supabase;
  } catch (error) {
    logger.error('Failed to initialize Supabase:', error);
    throw error;
  }
};

const getSupabase = () => {
  if (!supabase) {
    return initializeSupabase();
  }
  return supabase;
};

// Database connection using Supabase
const connectDatabase = async () => {
  try {
    const supabase = getSupabase();
    
    // Test connection
    const { data, error } = await supabase
      .from('clients')
      .select('count')
      .limit(1);

    if (error && error.code !== 'PGRST116') { // PGRST116 is "relation does not exist"
      throw error;
    }

    logger.info('Database connection successful');
    return true;
  } catch (error) {
    logger.error('Database connection failed:', error);
    throw error;
  }
};

// Authentication helpers
const createUser = async (email, password, userData) => {
  try {
    const supabase = getSupabase();
    
    const { data, error } = await supabase.auth.admin.createUser({
      email,
      password,
      user_metadata: userData,
      email_confirm: true
    });

    if (error) throw error;
    return data;
  } catch (error) {
    logger.error('Failed to create user:', error);
    throw error;
  }
};

const getUser = async (userId) => {
  try {
    const supabase = getSupabase();
    
    const { data, error } = await supabase.auth.admin.getUserById(userId);
    
    if (error) throw error;
    return data;
  } catch (error) {
    logger.error('Failed to get user:', error);
    throw error;
  }
};

const updateUser = async (userId, updates) => {
  try {
    const supabase = getSupabase();
    
    const { data, error } = await supabase.auth.admin.updateUserById(
      userId,
      updates
    );

    if (error) throw error;
    return data;
  } catch (error) {
    logger.error('Failed to update user:', error);
    throw error;
  }
};

const deleteUser = async (userId) => {
  try {
    const supabase = getSupabase();
    
    const { data, error } = await supabase.auth.admin.deleteUser(userId);
    
    if (error) throw error;
    return data;
  } catch (error) {
    logger.error('Failed to delete user:', error);
    throw error;
  }
};

// Database query helpers
const query = async (table, operation, params = {}) => {
  try {
    const supabase = getSupabase();
    let query = supabase.from(table);

    switch (operation) {
      case 'select':
        query = query.select(params.select || '*');
        if (params.eq) {
          Object.entries(params.eq).forEach(([key, value]) => {
            query = query.eq(key, value);
          });
        }
        if (params.limit) query = query.limit(params.limit);
        if (params.order) query = query.order(params.order.column, { ascending: params.order.ascending });
        break;

      case 'insert':
        query = query.insert(params.data);
        if (params.select) query = query.select(params.select);
        break;

      case 'update':
        query = query.update(params.data);
        if (params.eq) {
          Object.entries(params.eq).forEach(([key, value]) => {
            query = query.eq(key, value);
          });
        }
        if (params.select) query = query.select(params.select);
        break;

      case 'delete':
        if (params.eq) {
          Object.entries(params.eq).forEach(([key, value]) => {
            query = query.eq(key, value);
          });
        }
        query = query.delete();
        break;

      default:
        throw new Error(`Unsupported operation: ${operation}`);
    }

    const { data, error } = await query;
    
    if (error) throw error;
    return data;
  } catch (error) {
    logger.error(`Database ${operation} failed:`, error);
    throw error;
  }
};

// Storage helpers
const uploadFile = async (bucket, path, file, options = {}) => {
  try {
    const supabase = getSupabase();
    
    const { data, error } = await supabase.storage
      .from(bucket)
      .upload(path, file, options);

    if (error) throw error;
    return data;
  } catch (error) {
    logger.error('File upload failed:', error);
    throw error;
  }
};

const getPublicUrl = (bucket, path) => {
  try {
    const supabase = getSupabase();
    
    const { data } = supabase.storage
      .from(bucket)
      .getPublicUrl(path);

    return data.publicUrl;
  } catch (error) {
    logger.error('Failed to get public URL:', error);
    throw error;
  }
};

const deleteFile = async (bucket, paths) => {
  try {
    const supabase = getSupabase();
    
    const { data, error } = await supabase.storage
      .from(bucket)
      .remove(paths);

    if (error) throw error;
    return data;
  } catch (error) {
    logger.error('File deletion failed:', error);
    throw error;
  }
};

module.exports = {
  initializeSupabase,
  getSupabase,
  connectDatabase,
  createUser,
  getUser,
  updateUser,
  deleteUser,
  query,
  uploadFile,
  getPublicUrl,
  deleteFile
};
-- Enable UUID extension for automatic ID generation
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Permissions Table
-- Stores the unique combination of actions and resources
CREATE TABLE IF NOT EXISTS permissions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    action TEXT NOT NULL,
    resource TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(action, resource)
);

-- Roles Table
CREATE TABLE IF NOT EXISTS roles (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT UNIQUE NOT NULL,
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Role-Permission Mapping
-- Links roles to permissions (Many-to-Many)
CREATE TABLE IF NOT EXISTS role_permissions (
    role_id UUID REFERENCES roles(id) ON DELETE CASCADE,
    permission_id UUID REFERENCES permissions(id) ON DELETE CASCADE,
    PRIMARY KEY (role_id, permission_id)
);

-- User-Role Assignments
-- Links external users to roles, supporting the "Scope" feature
CREATE TABLE IF NOT EXISTS user_roles (
    user_id TEXT NOT NULL, 
    role_id UUID REFERENCES roles(id) ON DELETE CASCADE,
    scope_type TEXT DEFAULT 'global', -- e.g., 'org', 'project'
    scope_id TEXT DEFAULT '*',        -- '*' represents global/all
    assigned_at TIMESTAMPTZ DEFAULT NOW(),
    PRIMARY KEY (user_id, role_id, scope_id)
);

-- Indexes for Performance 
CREATE INDEX idx_user_roles_user_id ON user_roles(user_id);
CREATE INDEX idx_user_roles_scope ON user_roles(scope_type, scope_id);
module.exports = {
  mongodb: {
    server: process.env.ME_CONFIG_MONGODB_SERVER || 'mongo',
    port: process.env.ME_CONFIG_MONGODB_PORT || 27017,
    admin: process.env.ME_CONFIG_MONGODB_ENABLE_ADMIN === 'true',
    adminUsername: process.env.ME_CONFIG_MONGODB_ADMINUSERNAME,
    adminPassword: process.env.ME_CONFIG_MONGODB_ADMINPASSWORD,
  },
  site: {
    port: 8081,
    baseUrl: '/',
  },
  useBasicAuth: false,
}; 
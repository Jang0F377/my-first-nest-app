export default () => ({
  environment: process.env.NODE_ENV || 'development',
  database: {
    host: process.env.MONGO_HOST,
    port: parseInt(process.env.MONGO_PORT, 10) || 27017,
  },
});

const http = require('http');
const url = require('url');
const client = require('prom-client');

// Create Registry
const register = new client.Registry();

// Collect default Node.js & process metrics
client.collectDefaultMetrics({ register });

// Custom counter for HTTP requests
const httpRequestCounter = new client.Counter({
  name: 'devopsx_http_requests_total',
  help: 'Total number of HTTP requests received',
  labelNames: ['route'],
});

register.registerMetric(httpRequestCounter);

const server = http.createServer(async (req, res) => {
  const path = url.parse(req.url).pathname;

  if (path === '/metrics') {
    // Metrics endpoint for Prometheus
    res.setHeader('Content-Type', register.contentType);
    try {
      const metrics = await register.metrics();
      res.end(metrics);
    } catch (err) {
      res.statusCode = 500;
      res.end(err.toString());
    }
  } else {
    // Normal app response
    httpRequestCounter.inc({ route: path || '/' });
    res.writeHead(200, { 'Content-Type': 'text/plain' });
    res.end('DevOpsX app running with Prometheus metrics!\n');
  }
});

server.listen(3000, () => {
  console.log('Server started on port 3000');
});

const http = require('http');

const server = http.createServer((req, res) => {
  res.writeHead(200, { 'Content-Type': 'text/plain' });
  res.end('Dummy HTTP server running on port 8787\n');
});

server.listen(8787, () => {
  console.log('Dummy HTTP server started on port 8787');
});

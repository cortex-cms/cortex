// Require all files that end in __app.jsx
var req = require.context('./', true, /_app\.jsx$/);
req.keys().forEach(req);

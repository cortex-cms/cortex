// Require all files that end in __app.jsx
var req = require.context('./', true, /registration\.jsx$/);
req.keys().forEach(req);

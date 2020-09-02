// Copyright Adam B. Kaplan
//
// SPDX-License-Identifier: Apache-2.0

var express = require('express');
var app = express();

// Routes
app.get('/', function(req, res) {
  res.send('Hello World!');
});

// Listen
console.log("Example NodeJS app built with Shipwright")
var port = process.env.PORT || 8080;
const server = app.listen(port, () => console.log('Listening on localhost:'+ port));

// Signal Handlers
// Note NodeJS will exit with an appropriate error code if SIGKILL or SIGHUP are signaled
// See https://nodejs.org/api/process.html#process_exit_codes
process.on('SIGTERM', () => {
    console.info("Received terminate signal");
    console.log("Shutting down HTTP server");
    server.close(() => console.log("HTTP server shut down"));
});

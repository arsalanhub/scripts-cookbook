const express = require('express');
const { exec } = require('child_process');

const app = express();

// Define endpoint to execute script1
app.get('/redux-saga', (req, res) => {
  const path = req.query.path;
  exec(`redux-saga.sh ${path}`, (error, stdout, stderr) => {
    if (error) {
      console.error(`exec error: ${error}`);
      res.status(500).send('Error executing script1');
      return;
    }
    console.log(`stdout: ${stdout}`);
    console.error(`stderr: ${stderr}`);
    res.send('Redux & Saga setup successful');
  });
});

// Start the server
app.listen(3000, () => {
  console.log('Server started on port 3000');
});

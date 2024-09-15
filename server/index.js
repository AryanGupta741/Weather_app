// const express = require("express");
// const cors = require("cors");
// // creates the route//  Import your API routes
// const apiRoutes = require('./routes/api_registration');

// const app = express();
// const port = 8000;
// // middleware
// app.use(express.json());
// app.use(cors());
// //  Use the API routes
 
// app.use('/api', apiRoutes)

// let storedData = [];

// // Handle GET request
// app.get("/api/get", (req, res) => {
//   res.json({
//     message: "Hello from the server!",
//     data: storedData,
//   });
// });

// // Handle POST request
// app.post("/api/data/post", (req, res) => {
//   const receivedData = req.body; // Correct variable name
//   storedData.push(receivedData);
//   console.log("Received data:", receivedData); // Log received data for debugging
//   console.log(storedData),
//     res.json({
//       message: "Data posted successfully",
//       receivedData: receivedData, // Correct variable name
//     });
// });

// app.listen(port, () => {
//   console.log(`Server is running on port ${port}`);
// });


const express = require('express');
const axios = require('axios');
const cors = require('cors');

const app = express();
const port = 3000;

// Use CORS middleware
app.use(cors());
app.use(express.json());

app.get('/fetch-data/:id', async (req, res) => {
  const id = req.params.id;
  console.log(`${id}`);
  try {
    const response = await axios.get(`http://13.127.246.196:8000/api/registers/${id}`);
    res.json(response.data);
  } catch (error) {
    res.status(500).send('Error fetching data');
  }
});

app.post('/create_data/:id')

app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});

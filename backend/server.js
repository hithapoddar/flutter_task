require('dotenv').config();
const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');


const productRoutes = require('./routes/productRoutes');

const app = express();
app.use(cors());
app.use(express.json()); // Parse JSON body 

// Routes
app.use('/products', productRoutes);

// Connect to MongoDB
mongoose.connect(process.env.MONGO_CONNECTION_STRING)
  .then(() => {
    console.log('MongoDB connected');
    app.listen(process.env.PORT, () => {
      console.log(`Server running on http://localhost:${process.env.PORT}`);
    });
  })
  .catch(err => console.error(err));

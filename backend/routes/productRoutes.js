const express = require('express');
const router = express.Router();
const Product = require('../models/product');

// GET all
router.get('/', async (req, res) => {
  const products = await Product.find();
  res.json(products);
});

// POST new
router.post('/', async (req, res) => {
  console.log('Body:', req.body); // Check if cost is here
  try {
    const product = new Product(req.body);
    await product.save();
    res.status(201).json(product);
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
});


// GET one
router.get('/:id', async (req, res) => {
  const product = await Product.findById(req.params.id);
  res.json(product);
});

// PUT update
router.put('/:id', async (req, res) => {
  try {
    const updatedProduct = await Product.findByIdAndUpdate(
      req.params.id,
      req.body, // This auto-updates all passed fields (including `cost`)
      { new: true, runValidators: true }
    );

    res.status(200).json(updatedProduct);
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
});

// DELETE
router.delete('/:id', async (req, res) => {
  await Product.findByIdAndDelete(req.params.id);
  res.status(204).send();
});

module.exports = router;

const mongoose = require('mongoose');

const productSchema = new mongoose.Schema(
  {
    name: {
      type: String,
      required: [true, 'Product name is required'],
      trim: true,
      minlength: [3, 'Name must be at least 3 characters'],
      maxlength: [100, 'Name cannot exceed 100 characters']
    },
    description: {
      type: String,
      required: [true, 'Product description is required'],
      trim: true,
      maxlength: [1000, 'Description cannot exceed 1000 characters']
    },
    cost: {
      type: Number
      
    },
    category: {
      type: String,
      enum: ['Fruit', 'Vegetable', 'Dairy', 'Grain', 'Other'],
      default: 'Other'
    },
    inStock: {
      type: Boolean,
      default: true
    },
    quantity: {
      type: Number,
      default: 0,
      min: [0, 'Quantity must be at least 0']
    }
  },
  {
    timestamps: true // Automatically adds createdAt and updatedAt
  }
);

module.exports = mongoose.model('Product', productSchema);

# 🌱 Organix
![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)
Organix is a fullstack application that allows users to manage an inventory of organic products like fruits, vegetables, and dairy. 
Users can add, view, edit, and delete products using a sleek mobile interface powered by Flutter and a Node.js backend.

## 🚀 Features

- 🔍 **View Products** – Home screen fetches and lists all products using glassmorphic cards.
- ➕ **Add Product** – Frosted UI form to create a new product (POST).
- 📝 **Edit Product** – Update product details with prefilled inputs (PUT).
- ❌ **Delete Product** – Confirmation dialog and instant deletion (DELETE).
- 📡 **Node.js API Integration** – RESTful backend with MongoDB (GET, POST, PUT, DELETE).
- 🧠 **Provider State Management** – Clean logic separation and reactive UI.

## 🖼️ Screenshots 

### 🏠 **Home Screen**
  ![Screenshot 2025-04-29 151424](https://github.com/user-attachments/assets/9b134019-b902-4ef3-9490-42592c2fb9a9)

  The Organix Home Screen features a calm lilac-themed layout with a fresh and minimalistic design. Each product is showcased using a colored glassmorphic card, with:

  🖼️ Custom images representing the product category

  📌 Tabs to filter by Fruit, Vegetable, Dairy, Grain, or Other

  📋 Product details like name, quantity, price, and category badge

  🌞 A rotating "Today’s Tip" banner promoting wellness

  ➕ A floating action button to add new products quickly

 <p float="left" align="center">
  <img src="https://github.com/user-attachments/assets/94464723-abb8-4d08-bf56-50bf45da5803" width="45%" />
  <img src="https://github.com/user-attachments/assets/e8700dad-1f9e-43b8-abc3-02ca81bf3a32" width="45%" /><br>
  <i>Fruit Category</i> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <i>Vegetable Category</i>
</p>

### 🧾 Product Details Screen  
![Screenshot 2025-04-29 151545](https://github.com/user-attachments/assets/e4cb072e-7ba5-4e1d-9130-828e1d00a3e4)

Displays complete information about the selected product including name, description, price, quantity, category, and stock status. Users can navigate to edit the product using the elegant lilac-themed "Edit Product" button . There is also a Delete "🗑️" icon on the top right corner that helps delete the product. 

### ➕ Add Product Screen  
![Screenshot 2025-04-29 151400](https://github.com/user-attachments/assets/9e1f6ea5-3386-4900-ae6d-972d270b2bc6)

This screen allows users to input new product details such as name, description, cost, quantity, category, and stock status. With a clean and intuitive form layout, users can quickly add products to the inventory and finalize their input using the prominent **Save Product** button.

### ✏️ Edit Product Screen
![Screenshot 2025-04-29 195032](https://github.com/user-attachments/assets/eb632b02-d8f2-4183-8865-57b3233c3598)


This screen allows users to update existing product details such as name, description, cost, quantity, category, and stock status.

## 🛠️ Tech Stack

**Frontend:**
- Flutter
- Dart

**Backend:**
- Node.js
- Express.js
- MongoDB
- Mongoose (MongoDB ORM)

**API Communication:**
- RESTful API (GET, POST, PUT, DELETE)
- HTTP package in Flutter for requests

**Development Tools:**
- VS Code / Android Studio
- Postman (for testing APIs)
- Git & GitHub for version control

## 🧩 Architecture Overview

| Screen               | API Integration                    | State Management                    | Navigation                             |
|----------------------|------------------------------------|--------------------------------------|----------------------------------------|
| **Home Screen**      | Fetch & display products (GET)     | Uses Provider to listen for updates | Navigates to **Add**, **Product Detail** screens |
| **Add Product**      | Add a new product (POST)           | Calls Provider to update list       | Navigates back to **Home**             |
| **Product Detail**   | View product details (GET)         | Uses Provider to fetch details      | Navigates to **Edit**, **Home** screens|
| **Edit Product**     | Update (PUT) & Delete (DELETE)     | Calls Provider to update/remove     | Navigates back to **Home**             |





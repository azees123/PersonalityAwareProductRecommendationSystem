<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Upload Product</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 20px;
            }
            .container {
                max-width: 600px;
                margin: 0 auto;
                background-color: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            h2 {
                text-align: center;
                color: #333;
            }
            form {
                display: flex;
                flex-direction: column;
            }
            label {
                margin-bottom: 8px;
                font-weight: bold;
                color: #555;
            }
            input[type="text"], input[type="number"], textarea, select {
                width: 100%;
                padding: 10px;
                margin-bottom: 15px;
                border: 1px solid #ddd;
                border-radius: 4px;
                box-sizing: border-box;
            }
            textarea {
                resize: vertical;
                height: 100px;
            }
            input[type="submit"] {
                background-color: lightblue;
                color: #fff;
                border: none;
                padding: 15px;
                border-radius: 4px;
                cursor: pointer;
                font-size: 16px;
            }
            input[type="submit"]:hover {
                background: rgba(173, 216, 230, 0.9);
            }
            .form-group {
                margin-bottom: 15px;
            }
            .login-link {
                text-align: center;
                margin-top: 1rem;
            }
            .login-link a {
                color: lightblue;
                text-decoration: none;
                font-weight: bold;
            }
            .login-link a:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Upload Product</h2>
            <form action="addProductServlet" method="post" enctype="multipart/form-data">
                <div class="form-group">
                    <label for="product_name">Product Name:</label>
                    <input type="text" id="product_name" name="product_name" placeholder="Enter product name" required>
                </div>
                <div class="form-group">
                    <label for="brand_name">Brand Name:</label>
                    <input type="text" id="brand_name" name="brand_name" placeholder="Enter brand name">
                </div>
                <div class="form-group">
                    <label for="product_description">Product Description:</label>
                    <textarea id="product_description" name="product_description" placeholder="Enter product description"></textarea>
                </div>
                <div class="form-group">
                    <label for="price">Price:</label>
                    <input type="number" id="price" name="price" step="0.01" placeholder="Enter price">
                </div>
                <div class="form-group">
                    <label for="tag">Tag:</label>
                    <input type="text" id="tag" name="tag" placeholder="Enter tag">
                </div>
                <div class="form-group">
                    <label for="category">Category:</label>
                    <select id="category" name="category">
                        <option value="mobile">Mobile</option>
                        <option value="laptop">Laptop</option>
                        <option value="accessories">Accessories</option>
                        <option value="electronics">Electronics</option>
                        <option value="others">Others</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="product_image">Product Image:</label>
                    <input type="file" id="product_image" name="product_image" accept="image/*" required>
                </div>
                <input type="submit" value="Upload Product">
                <div class="login-link">
                    <p>Back to <a href="adminDashboard.jsp">Home</a></p>
                </div>
            </form>
        </div>
    </body>
</html>

<%@page import="java.util.List"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="papr.Product"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Product List</title>
        <link rel="stylesheet" type="text/css" href="styles.css">
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
            }

            header {
                background-color: #333;
                color: white;
                padding: 10px;
            }

            .header-content {
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .header-right {
                display: flex;
                align-items: center;
            }

            header h1 {
                margin: 0;
            }

            select {
                margin-right: 10px;
                padding: 5px;
            }

            .search-form {
                display: flex;
            }

            .search-form input[type="text"] {
                padding: 5px;
                border: none;
                border-radius: 5px 0 0 5px;
            }

            .search-form button {
                padding: 5px 10px;
                border: none;
                background-color: #007bff;
                color: white;
                border-radius: 0 5px 5px 0;
                cursor: pointer;
            }

            .search-form button:hover {
                background-color: #0056b3;
            }

            .product-container {
                display: flex;
                flex-direction: column;
                align-items: center;
                padding: 20px;
            }

            .product-card {
                display: flex;
                align-items: center;
                border: 1px solid #ddd;
                border-radius: 10px;
                overflow: hidden;
                width: 80%;
                max-width: 800px;
                margin-bottom: 20px;
                text-align: left;
            }

            .product-image {
                width: 150px;
                height: 150px;
                object-fit: cover;
            }

            .product-details {
                padding: 10px;
                flex: 1;
            }

            .product-name {
                font-size: 18px;
                margin: 0;
            }

            .product-price {
                font-size: 16px;
                color: #f60;
                margin: 5px 0;
            }

            .buy-button, .review-link {
                display: inline-block;
                margin-right: 10px;
                padding: 10px;
                color: white;
                text-decoration: none;
                border-radius: 5px;
            }

            .buy-button {
                background-color: #28a745;
            }

            .review-link {
                background-color: #007bff;
            }

            .login-link {
                text-align: center;
                margin-top: 1rem;
            }

            .login-link a {
                color: green;
                text-decoration: none;
                font-weight: bold;
            }

            .login-link a:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body>
        <header>
            <div class="header-content">
                <h1>Products</h1>
                <div class="header-right">
                    <form action="SearchServlet" method="get" class="search-form">
                        <select id="category" name="category">
                            <option value="all">All Categories</option>
                            <option value="mobile">Mobile</option>
                            <option value="electronics">Electronics</option>
                            <option value="accessories">Accessories</option>
                            <option value="laptop">Laptop</option>
                            <option value="others">Others</option>
                        </select>
                        <input type="text" name="query" placeholder="Search...">
                        <button type="submit">Search</button>
                    </form>
                </div>
            </div>
        </header>

        <div class="product-container">
            <%
                List<Product> products = (List<Product>) request.getAttribute("products");
                String userEmail = (String) session.getAttribute("userEmail"); // Get user email from session
                if (products != null && !products.isEmpty()) {
                    for (Product product : products) {
                        String productBrand = product.getBrandName() != null ? product.getBrandName() : "Unknown Brand";
                        String productDescription = product.getProductDescription() != null ? product.getProductDescription() : "No description available";
            %>
            <div class="product-card">
                <img src="ImageServlet?id=<%= product.getId()%>" alt="<%= product.getName()%>" class="product-image">
                <div class="product-details">
                    <h2 class="product-name"><%= product.getName() %></h2>
                    <p class="product-price">$<%= product.getPrice() %></p>
                    <a href="buyNow.jsp?product=<%= URLEncoder.encode(product.getName(), "UTF-8")%>&price=<%= product.getPrice()%>&brand=<%= URLEncoder.encode(productBrand, "UTF-8")%>&description=<%= URLEncoder.encode(productDescription, "UTF-8")%>" class="buy-button">Buy</a>
                    <a href="review.jsp?product=<%= URLEncoder.encode(product.getName(), "UTF-8")%>&price=<%= product.getPrice()%>&brand=<%= URLEncoder.encode(productBrand, "UTF-8")%>&description=<%= URLEncoder.encode(productDescription, "UTF-8")%>&userEmail=<%= URLEncoder.encode(userEmail != null ? userEmail : "", "UTF-8") %>" class="review-link">Review</a>
                </div>
            </div>
            <%
                    }
                } else {
            %>
            <p>No products available at the moment. Please check back later.</p>
            <%
                }
            %>
        </div>
        <div class="login-link">
            <p>Back <a href="userDashboard.jsp">User Dashboard</a></p>
        </div>
    </body>
</html>
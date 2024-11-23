<%@page import="papr.Product"%>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@page import="java.net.URLEncoder"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Recommended Products</title>
        <style>
            body {
                font-family: 'Roboto', sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f8f9fa;
            }
            header {
                background-color: #343a40;
                color: white;
                padding: 15px;
            }
            .header-content {
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
            header h1 {
                margin: 0;
                text-align: center;
                flex: 1;
            }
            .product-container {
                display: flex;
                flex-direction: column;
                align-items: center;
                padding: 20px;
            }
            .product-list {
                display: flex;
                flex-direction: column;
                align-items: center;
                width: 100%;
                padding: 20px;
            }
            .product-card {
                display: flex;
                align-items: flex-start;
                border: 1px solid #ddd;
                border-radius: 10px;
                overflow: hidden;
                width: 90%;
                max-width: 800px;
                margin-bottom: 20px;
                text-align: left;
                transition: transform 0.3s, box-shadow 0.3s;
                background-color: #fdfdfd;
            }
            .product-card:hover {
                transform: translateY(-8px);
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
            }
            .product-image {
                width: 150px;
                height: 150px;
                object-fit: cover;
                border-radius: 5px;
                margin-right: 20px;
            }
            .product-details {
                padding: 20px;
                flex: 1;
                background-color: #ffffff;
                border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            }
            .product-name {
                font-size: 22px;
                font-weight: bold;
                color: #333;
                margin: 0;
                line-height: 1.5;
                text-transform: capitalize;
            }
            .product-name:hover {
                color: #007bff;
                text-decoration: underline;
            }
            .product-price {
                font-size: 18px;
                color: #e63946;
                margin: 10px 0;
                font-weight: bold;
            }
            .button-container {
                display: flex;
                justify-content: flex-start;
                margin-top: 15px;
            }
            .buy-button, .review-link {
                margin-right: 10px;
                padding: 10px 15px;
                color: white;
                text-decoration: none;
                border-radius: 5px;
                transition: background-color 0.3s, transform 0.3s;
                font-weight: bold;
            }
            .buy-button {
                background-color: #28a745;
            }
            .buy-button:hover {
                background-color: #218838;
                transform: scale(1.05);
            }
            .review-link {
                background-color: #007bff;
            }
            .review-link:hover {
                background-color: #0056b3;
                transform: scale(1.05);
            }
            .login-link {
                text-align: center;
                margin-top: 1rem;
            }
            .login-link a {
                color: #007bff;
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
                <h1>Product Recommendations</h1>
            </div>
        </header>

        <div class="product-container">
            <%
                // Database connection parameters
                String jdbcUrl = "jdbc:mysql://localhost:3306/papr"; // Update with your DB details
                String username = "root"; // Update with your DB username
                String password = ""; // Update with your DB password
                List<Product> recommendedProducts = new ArrayList<>();

                // Fetch last searched products
                try (Connection conn = DriverManager.getConnection(jdbcUrl, username, password); Statement stmt = conn.createStatement()) {
                    String sql = "SELECT p.id, p.product_name, p.product_image, p.price, p.product_description, p.brand_name "
                            + "FROM search_history sh "
                            + "JOIN products p ON sh.product_id = p.id "
                            + "ORDER BY sh.search_time DESC LIMIT 10"; // Adjust the limit as needed
                    ResultSet rs = stmt.executeQuery(sql);

                    while (rs.next()) {
                        Product product = new Product(
                                rs.getString("id"),
                                rs.getString("product_image"),
                                rs.getString("product_name"),
                                rs.getDouble("price"),
                                rs.getString("brand_name"),
                                rs.getString("product_description")
                        );
                        recommendedProducts.add(product);
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }

                if (!recommendedProducts.isEmpty()) {
            %>
            <div class="product-list">
                <%
                    String userEmail = (String) session.getAttribute("userEmail"); // Get user email from session
                    for (Product product : recommendedProducts) {
                %>
                <div class="product-card">
                    <img class="product-image" src="<%= product.getImage()%>" alt="<%= product.getName()%>" />
                    <div class="product-details">
                        <h3 class="product-name"><%= product.getName()%></h3>
                        <p class="product-price">Price: $<%= product.getPrice()%></p>
                        <div class="button-container">
                            <a href="buyNow.jsp?product=<%= URLEncoder.encode(product.getName(), "UTF-8")%>&price=<%= product.getPrice()%>&brand=<%= URLEncoder.encode(product.getBrandName(), "UTF-8")%>&description=<%= URLEncoder.encode(product.getProductDescription(), "UTF-8")%>" class="buy-button">Buy</a>
                            <a href="review.jsp?product=<%= URLEncoder.encode(product.getName(), "UTF-8")%>&price=<%= product.getPrice()%>&brand=<%= URLEncoder.encode(product.getBrandName(), "UTF-8")%>&description=<%= URLEncoder.encode(product.getProductDescription(), "UTF-8")%>&userEmail=<%= URLEncoder.encode(userEmail != null ? userEmail : "", "UTF-8")%>" class="review-link">Review</a>
                        </div>
                    </div>
                </div>
                <%
                    }
                %>
            </div>
            <%
            } else {
            %>
            <p>No recommended products available.</p>
            <%
                }
            %>
        </div>
        

        <div class="login-link">
            <p><a href="userDashboard.jsp">User Dashboard</a></p>
        </div>
    </body>
</html>

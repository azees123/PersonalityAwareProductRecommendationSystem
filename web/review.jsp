<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Review Product</title>
        <link rel="stylesheet" type="text/css" href="styles.css">
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 20px;
                background-color: #f4f4f4;
            }

            header {
                background-color: #4CAF50;
                color: white;
                padding: 20px;
                text-align: center;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            }

            .content {
                display: flex;
                justify-content: center;
                margin-top: 30px;
            }

            .product-details, .review-form {
                background: white;
                border-radius: 8px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                padding: 20px;
                width: 100%;
                max-width: 400px;
                margin: 0 10px;
            }

            .product-details img {
                width: 100%;
                height: auto;
                border-radius: 8px;
                margin-bottom: 15px;
            }

            .review-form h3 {
                margin: 0 0 20px;
                font-size: 26px;
                color: #333;
                text-align: center;
            }

            label {
                font-weight: bold;
                color: #555;
                display: block;
                margin-bottom: 5px;
            }

            select, textarea, button {
                width: 100%;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 4px;
                font-size: 16px;
                box-sizing: border-box;
                margin-bottom: 15px;
                transition: border-color 0.3s, box-shadow 0.3s;
            }

            select:focus, textarea:focus {
                border-color: #4CAF50;
                box-shadow: 0 0 5px rgba(76, 175, 80, 0.5);
                outline: none;
            }

            textarea {
                resize: vertical;
            }

            button {
                background-color: #4CAF50;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 16px;
                transition: background-color 0.3s, transform 0.2s;
                padding: 12px;
            }

            button:hover {
                background-color: #45a049;
                transform: translateY(-2px);
            }

            button:active {
                transform: translateY(0);
            }

            .container {
                max-width: 800px;
                margin: 0 auto;
                padding: 20px;
                font-family: Arial, sans-serif;
            }

            h1 {
                text-align: center;
                color: #333;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }

            th, td {
                border: 1px solid #ddd;
                padding: 12px;
                text-align: left;
            }

            th {
                background-color: #f4f4f4;
                color: #333;
            }

            tr:nth-child(even) {
                background-color: #f9f9f9;
            }

            tr:hover {
                background-color: #f1f1f1;
            }

            a {
                color: #007bff;
                text-decoration: none;
            }

            a:hover {
                text-decoration: underline;
            }

            .action-links {
                display: flex;
                gap: 10px;
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
            <h1>Product Review</h1>
        </header>

        <div class="content">
            <div class="product-details">
                <%
                    // Retrieve product details from request parameters
                    String productName = request.getParameter("product");
                    String priceStr = request.getParameter("price");
                    String brandName = request.getParameter("brand");
                    String productDescription = request.getParameter("description");
                    String productImage = request.getParameter("image");
                    double price = 0.0;
                    String userEmail = request.getParameter("userEmail");

                    if (priceStr != null && !priceStr.isEmpty()) {
                        price = Double.parseDouble(priceStr);
                    }
                %>
                <img src="<%= productImage%>" alt="<%= productName%>">
                <h2>Product: <%= productName%></h2>
                <p>Brand: <%= brandName%></p>
                <p>Description: <%= productDescription%></p>
                <p>Price: $<%= price%></p>
                <p>Email: <%= userEmail%></p>
            </div>

            <div class="review-form">
                <h3>Leave a Review</h3>
                <form action="ReviewHandlerServlet" method="post">
                    <input type="hidden" name="product" value="<%= productName%>">
                    <input type="hidden" name="price" value="<%= price%>">
                    <input type="hidden" name="image" value="<%= productImage%>">
                    <input type="hidden" name="description" value="<%= productDescription%>">
                    <input type="hidden" name="userEmail" value="<%= userEmail%>"> <!-- Email passed via request -->

                    <label for="rating">Rating:</label>
                    <select name="rating" id="rating" required>
                        <option value="" disabled selected>Select a rating</option>
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                    </select>
                    <br>

                    <label for="comment">Comment:</label>
                    <textarea name="comment" id="comment" rows="4" placeholder="Leave your comment here..." required></textarea>
                    <br>

                    <button type="submit">Submit Review</button>
                </form>
            </div>
        </div>

        <div class="container">
            <h1>User Reviews</h1>
            <table>
                <thead>
                    <tr>
                        <th>User Email</th>
                        <th>Id</th>
                        <th>Product</th>
                        <th>Rating</th>
                        <th>Review</th>
                        <th>Sentiment Analysis</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        // Database connection details
                        String DB_URL = "jdbc:mysql://localhost:3306/papr";
                        String DB_USER = "root";
                        String DB_PASSWORD = "";

                        Connection conn = null;
                        Statement stmt = null;
                        ResultSet rs = null;

                        try {
                            // Load MySQL JDBC driver
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

                            // SQL query to show reviews where product matches product_name in products table
                            String sql = "SELECT r.userEmail, r.id, r.product, r.rating, r.comment, r.sentiment "
                                    + "FROM reviews r "
                                    + "JOIN products p ON r.product = p.product_name";
                            stmt = conn.createStatement();
                            rs = stmt.executeQuery(sql);

                            // Process result set
                            while (rs.next()) {
                                String reviewEmail = rs.getString("userEmail");
                                int id = rs.getInt("id");
                                String product = rs.getString("product");
                                int rating = rs.getInt("rating");
                                String comment = rs.getString("comment");
                                String sentiment = rs.getString("sentiment");
                    %>
                    <tr>
                        <td><%= reviewEmail%></td>
                        <td><%= id%></td>
                        <td><%= product%></td>
                        <td><%= rating%></td>
                        <td><%= comment%></td>
                        <td><%= sentiment%></td>
                    </tr>
                    <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            // Clean up resources
                            try {
                                if (rs != null) {
                                    rs.close();
                                }
                                if (stmt != null) {
                                    stmt.close();
                                }
                                if (conn != null) {
                                    conn.close();
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        }
                    %>
                </tbody>
            </table>
        </div>

        <div class="login-link">
            <p>Back <a href="userDashboard.jsp">User Dashboard</a></p>
        </div>

    </body>
</html>

<%@ page import="java.sql.Connection,java.sql.DriverManager,java.sql.ResultSet,java.sql.Statement" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>User Reviews</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 0;
            }
            .container {
                margin: 20px auto;
                padding: 20px;
                width: 90%;
                max-width: 1200px;
                background-color: rgba(255, 255, 255, 0.9);
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }
            h1 {
                color: #333;
                text-align: center;
                margin-bottom: 20px;
            }
            table {
                width: 100%;
                border-collapse: collapse;
            }
            table, th, td {
                border: 1px solid rgba(0, 0, 0, 0.1);
            }
            th, td {
                padding: 12px;
                text-align: left;
                background-color: rgba(255, 255, 255, 0.8);
            }
            th {
                background-color: rgba(0, 128, 0, 0.1);
                color: #333;
            }
            tr:nth-child(even) td {
                background-color: rgba(0, 128, 0, 0.05);
            }
            tr:hover td {
                background-color: rgba(0, 128, 0, 0.1);
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
        <div class="container">
            <h1>User Details</h1>
            <table>
                <thead>
                    <tr>
                        <th>Email</th>
                        <th>Product Id</th>
                        <th>Product Name</th>
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

                            // Execute SQL query
                            String sql = "SELECT userEmail, id , product , rating , comment , sentiment FROM reviews";
                            stmt = conn.createStatement();
                            rs = stmt.executeQuery(sql);

                            // Process result set
                            while (rs.next()) {
                                String userEmail = rs.getString("userEmail");
                                int id = rs.getInt("id");
                                String product = rs.getString("product");
                                String rating = rs.getString("rating");
                                String comment = rs.getString("comment");
                                String sentiment = rs.getString("sentiment");
                    %>
                    <tr>
                        <td><%= userEmail%></td>
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
            <p>Back <a href="adminDashboard.jsp">Admin Dashboard</a></p>
        </div>
    </body>
</html>

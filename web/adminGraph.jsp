<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.google.gson.Gson" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Product Ratings Pie Chart</title>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4; /* Light background for the page */
                margin: 0;
                padding: 20px;
            }

            h2 {
                text-align: center;
                color: #333; /* Dark text color */
            }

            /* Container for the chart and ratings */
            .container {
                display: flex; /* Use flexbox for layout */
                justify-content: center;
                align-items: flex-start;
                margin-top: 20px;
            }

            /* Define the size for the chart container */
            #chart-container {
                width: 500px;
                height: 500px;
                margin-right: 20px; /* Space between chart and ratings */
                border: 2px solid #ddd; /* Border around the chart */
                border-radius: 8px; /* Rounded corners */
                background-color: #fff; /* White background for the chart */
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* Subtle shadow */
            }

            /* Style for the ratings display */
            #ratingText {
                text-align: left; /* Align text to the left */
                width: 300px; /* Fixed width for ratings */
                background-color: #fff; /* White background */
                padding: 10px;
                border: 2px solid #ddd; /* Border around ratings */
                border-radius: 8px; /* Rounded corners */
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* Subtle shadow */
            }

            /* Style for each product rating entry */
            .rating-entry {
                margin: 5px 0; /* Spacing between entries */
                padding: 5px;
                border: 1px solid #ddd; /* Border around each entry */
                border-radius: 5px; /* Rounded corners */
                background-color: #f9f9f9; /* Light background */
            }

            /* Style for stars */
            .stars {
                color: red; /* Gold color for stars */
            }

            .login-link {
                text-align: center;
                margin-top: 1rem;
            }
            .login-link a {
                color: blue;
                text-decoration: none;
                font-weight: bold;
            }
            .login-link a:hover {
                text-decoration: underline;
            }

        </style>
    </head>
    <body>
        <h2>Product Ratings Distribution</h2>
        <div class="container">
            <div id="chart-container">
                <canvas id="ratingsChart"></canvas>
            </div>
            <div id="ratingText"></div> <!-- Ratings display container -->
        </div>

        <%
            // Initialize variables for products and ratings
            List<String> products = new ArrayList<>();
            List<Integer> ratings = new ArrayList<>();

            // Database connection and query
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
                // Load the JDBC driver for your database (e.g., MySQL)
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/papr", "root", "");

                // SQL query to fetch product and rating data
                String query = "SELECT product, rating FROM reviews";
                stmt = conn.createStatement();
                rs = stmt.executeQuery(query);

                // Process the result set and populate lists
                while (rs.next()) {
                    products.add(rs.getString("product"));
                    ratings.add(rs.getInt("rating"));
                }

                // Convert Java lists to JSON format using Gson
                Gson gson = new Gson();
                String jsonProducts = gson.toJson(products);   // Declare and initialize jsonProducts
                String jsonRatings = gson.toJson(ratings);     // Declare and initialize jsonRatings

        %>
        <script>
            // Pass Java data to JavaScript variables
            var productsData = <%= jsonProducts%>;  // Use the correct variable jsonProducts
            var ratingsData = <%= jsonRatings%>;    // Use the correct variable jsonRatings

            // Create the pie chart using Chart.js
            var ctx = document.getElementById('ratingsChart').getContext('2d');
            var ratingsChart = new Chart(ctx, {
                type: 'pie',
                data: {
                    labels: productsData, // Set the product names as labels
                    datasets: [{
                            label: 'Ratings Distribution',
                            data: ratingsData, // Set the ratings data
                            backgroundColor: [
                                'rgba(255, 99, 132, 0.2)',
                                'rgba(54, 162, 235, 0.2)',
                                'rgba(255, 206, 86, 0.2)',
                                'rgba(75, 192, 192, 0.2)',
                                'rgba(153, 102, 255, 0.2)',
                                'rgba(255, 159, 64, 0.2)',
                                'rgba(100, 192, 132, 0.2)',
                                'rgba(201, 203, 207, 0.2)'
                            ],
                            borderColor: [
                                'rgba(255, 99, 132, 1)',
                                'rgba(54, 162, 235, 1)',
                                'rgba(255, 206, 86, 1)',
                                'rgba(75, 192, 192, 1)',
                                'rgba(153, 102, 255, 1)',
                                'rgba(255, 159, 64, 1)',
                                'rgba(100, 192, 132, 1)',
                                'rgba(201, 203, 207, 1)'
                            ],
                            borderWidth: 1
                        }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false
                }
            });

            // Display product ratings as text below the chart
            var ratingText = document.getElementById('ratingText'); // Get the ratings container
            productsData.forEach(function (product, index) {
                ratingText.innerHTML += '<div class="rating-entry">' + product + ': <span class="stars">' + ratingsData[index] + '</span></div>';
            });
        </script>
        <%
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) try {
                    rs.close();
                } catch (SQLException ignored) {
                }
                if (stmt != null) try {
                    stmt.close();
                } catch (SQLException ignored) {
                }
                if (conn != null) try {
                    conn.close();
                } catch (SQLException ignored) {
                }
            }
        %>

        <div class="login-link">
            <p>Back <a href="adminDashboard.jsp">Admin Dashboard</a></p>
        </div>

    </body>
</html>

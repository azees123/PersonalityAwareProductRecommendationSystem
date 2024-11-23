<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>User Dashboard</title>
        <style>
            body {
                background: url('icon/download.jpg') no-repeat center center fixed;
                background-size: cover;
                color: #fff;
                font-family: Arial, sans-serif;
                margin: 0;
                height: 100vh; /* Full viewport height */
                display: flex;
                flex-direction: column;
            }

            header {
                background-color: rgba(44, 62, 80, 1);
                padding: 20px;
                text-align: center;
            }

            .navbar {
                display: flex;
                justify-content: center;
                margin-bottom: 20px;
            }

            .nav-links {
                list-style: none;
                display: flex;
                padding: 0;
            }

            .nav-links li {
                margin: 0 15px;
            }

            .nav-links a {
                text-decoration: none;
                color: #fff;
                font-size: 1.2em;
                transition: color 0.3s ease;
            }

            .nav-links a:hover {
                color: black;
            }

            main {
                padding: 20px;
                background: rgba(0, 0, 0, 0.6);
                margin: 20px;
                border-radius: 8px; /* Optional: rounded corners for main */
                flex: 1; /* Allow main content to take available space */
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
            }

            h2 {
                font-size: 2em;
                margin-bottom: 15px;
                text-align: center;
            }

            p {
                font-size: 1.2em;
                text-align: center;
            }

            footer {
                background-color: rgba(44, 62, 80, 1);
                text-align: center;
                padding: 10px;
            }
            
            footer p{
                color: white;
            }
        </style>
    </head>
    <body>
        <header>
            <h1>Personality-aware Product Recommendation System</h1>
            <nav class="navbar">
                <ul class="nav-links">
                    <li><a href="adminDashboard.jsp">Home</a></li>
                    <li><a href="addProduct.jsp">Add Product</a></li>
                    <li><a href="viewProduct.jsp">View Product</a></li>
                    <li><a href="userDetails.jsp">User Details</a></li>
                    <li><a href="userReview.jsp">User Review</a></li>
                    <li><a href="viewOrder.jsp">View Order</a></li>
                    <li><a href="adminGraph.jsp">Graph</a></li>
                    <li><a href="adminLogin.jsp">Logout</a></li>
                </ul>
            </nav>

        </header>
        <main>
            <section id="home">
                <h2>Welcome</h2>
                <p>Explore our system for tailored product recommendations based on user interests and personality analysis.</p>
            </section>
        </main>
        <footer>
            <p>&copy; 2024 Your Company</p>
        </footer>
    </body>
</html>

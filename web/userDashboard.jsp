<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
        
        footer p {
            color: white;
        }
    </style>
</head>
<body>
    <header>
        <h1>Personality-aware Product Recommendation System</h1>
        <nav class="navbar">
            <ul class="nav-links">
                <li><a href="userDashboard.jsp">Home</a></li>
                <li><a href="userProduct.jsp">Product</a></li>
                <li><a href="userRecommended.jsp">Recommended Product</a></li>
                <li><a href="userOrder.jsp">Your Order</a></li>
                <li><a href="userLogout.jsp">Logout</a></li>
            </ul>
        </nav>
    </header>
    <main>
        <section id="home">
            <h2>Welcome, 
                <%= session.getAttribute("userEmail") != null ? session.getAttribute("userEmail") : "Guest" %>
            </h2>
            <p>Explore our system for tailored product recommendations based on user interests and personality analysis.</p>
        </section>
    </main>
    <footer>
        <p>&copy; 2024 Your Company</p>
    </footer>
</body>
</html>

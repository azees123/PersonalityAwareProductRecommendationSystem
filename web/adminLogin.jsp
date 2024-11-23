<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin</title>
        <link rel="stylesheet" href="styles.css">
        <style>
            /* Basic styling for the login page */
            /* Basic styling for the login page */
            body {
                font-family: Arial, sans-serif;
                line-height: 1.6;
                background: #f0f8ff;
                color: #333;
                margin: 0;
                height: 100vh; /* Full viewport height */
                display: flex;
                justify-content: center;
                align-items: center;
            }

            .container {
                width: 80%;
                max-width: 400px;
                padding: 2rem;
                background: #fff;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                /* Optional: Add some margin for better spacing on smaller screens */
                margin: 2rem;
            }

            h1 {
                text-align: center;
                margin-bottom: 1rem;
            }

            form {
                display: flex;
                flex-direction: column;
            }

            label {
                margin-bottom: 0.5rem;
                font-weight: bold;
            }

            input[type="email"], input[type="password"], input[type="text"] {
                padding: 0.75rem;
                margin-bottom: 1rem;
                border: 1px solid #ddd;
                border-radius: 4px;
            }

            button {
                padding: 0.75rem;
                background: rgba(173, 216, 230, 0.7); /* Light blue with 70% opacity */
                border: none;
                color: black;
                border-radius: 4px;
                cursor: pointer;
                font-size: 1rem;
                transition: background 0.3s ease; /* Smooth transition for hover effect */
            }

            button:hover {
                background: rgba(173, 216, 230, 0.9); /* Slightly darker light blue on hover */
            }

            .register-link {
                text-align: center;
                margin-top: 1rem;
            }

            .register-link a {
                color: lightblue;
                text-decoration: none;
                font-weight: bold;
            }

            .register-link a:hover {
                text-decoration: underline;
            }
            
            p{
                text-align: center;
            }

        </style>
    </head>
    <body>
        <div class="container">
            <h1>Admin Login</h1>
            <form action="adminProcess" method="post">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>

                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>

                <button type="submit">Login</button>
            </form>
            
            <p><a href="index.html">Home Page</a><p>
        </div>
    </body>
</html>

<%@page import="java.net.URLEncoder"%>
<!DOCTYPE html>
<html>
<head>
    <title>Buy Now</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: rgba(240, 240, 240, 1);
            margin: 0;
            padding: 20px;
        }

        header {
            background-color: rgba(0, 123, 255, 0.8);
            color: white;
            padding: 15px;
            text-align: center;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .product-details {
            background-color: white;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            margin-top: 20px;
            transition: transform 0.2s;
        }

        .product-details:hover {
            transform: scale(1.02);
        }

        h2 {
            color: rgba(0, 0, 0, 0.8);
        }

        p {
            color: rgba(0, 0, 0, 0.6);
            line-height: 1.5;
        }

        button {
            background-color: rgba(0, 123, 255, 1);
            color: white;
            border: none;
            border-radius: 5px;
            padding: 10px 15px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: rgba(0, 105, 217, 1);
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
    <header>
        <h1>Buy Product</h1>
    </header>

    <div class="product-details">
        <%
            String productName = request.getParameter("product");
            String priceStr = request.getParameter("price");
            String brandName = request.getParameter("brand");
            String productDescription = request.getParameter("description");
            String productImage = request.getParameter("image"); // Get product image
            double price = 0.0;

            if (priceStr != null && !priceStr.isEmpty()) {
                try {
                    price = Double.parseDouble(priceStr);
                } catch (NumberFormatException e) {
                    price = 0.0; // Handle error case if needed
                }
            }
        %>
        <h2>Product: <%= productName %></h2>
        <img src="<%= productImage %>" alt="<%= productName %>" style="max-width: 300px; height: auto; border-radius: 8px; box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);"> <!-- Display product image -->
        <p>Brand: <%= brandName %></p>
        <p>Description: <%= productDescription %></p>
        <p>Price: $<%= price %></p>
        <form action="PurchaseHandlerServlet" method="post">
            <input type="hidden" name="image" value="<%= productImage %>"> <!-- Add hidden input for image -->
            <input type="hidden" name="product" value="<%= productName %>">
            <input type="hidden" name="price" value="<%= price %>">
            <input type="hidden" name="brand" value="<%= brandName %>">
            <input type="hidden" name="description" value="<%= productDescription %>">
            <button type="submit">Confirm Purchase</button>
        </form>
    </div>
    
    <div class="login-link">
        <p>Back <a href="userDashboard.jsp">User Dashboard</a></p>
    </div>
</body>
</html>

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package papr;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.SQLException;

/**
 *
 * @author LuckyCharm
 */
public class SearchServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final Logger LOGGER = Logger.getLogger(SearchServlet.class.getName());

    // Database connection settings (consider moving these to a config file or environment variables)
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/papr";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String query = request.getParameter("query");
        String category = request.getParameter("category");
        List<Product> products = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD)) {
                // Build SQL query based on parameters
                String sql = "SELECT * FROM products";
                List<String> conditions = new ArrayList<>();

                if (category != null && !category.equals("all")) {
                    conditions.add("category = ?");
                }
                if (query != null && !query.trim().isEmpty()) {
                    conditions.add("product_name LIKE ?");
                }

                if (!conditions.isEmpty()) {
                    sql += " WHERE " + String.join(" AND ", conditions);
                }

                try (PreparedStatement statement = connection.prepareStatement(sql)) {
                    int index = 1;
                    if (category != null && !category.equals("all")) {
                        statement.setString(index++, category);
                    }
                    if (query != null && !query.trim().isEmpty()) {
                        statement.setString(index++, "%" + query + "%");
                    }

                    try (ResultSet resultSet = statement.executeQuery()) {
                        while (resultSet.next()) {
                            String id = resultSet.getString("id");
                            String image = resultSet.getString("product_image");
                            String name = resultSet.getString("product_name");
                            double price = resultSet.getDouble("price");
                            String brandName = resultSet.getString("brand_name");
                            String productDescription = resultSet.getString("product_description");

                            // Add product to the list
                            products.add(new Product(id, image, price, name, brandName, productDescription));

                            // Insert into search history for each product found
                            insertSearchHistory(connection, query, resultSet.getInt("id")); // Ensure ID is correct type
                        }
                    }
                }

                // Fetch recommended products
                List<Product> recommendedProducts = getMostSearchedProducts(connection);
                request.setAttribute("recommendedProducts", recommendedProducts);
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error occurred while searching for products", e);
            throw new ServletException("Error occurred while searching for products", e);
        }

        request.setAttribute("products", products);
        request.getRequestDispatcher("userProduct.jsp").forward(request, response);
    }

    private void insertSearchHistory(Connection connection, String searchQuery, int productId) throws SQLException {
        String sql = "INSERT INTO search_history (search_query, product_id, search_time) VALUES (?, ?, CURRENT_TIMESTAMP)";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, searchQuery);
            statement.setInt(2, productId);
            statement.executeUpdate();
        }
    }

    private List<Product> getMostSearchedProducts(Connection connection) throws SQLException {
        List<Product> recommendedProducts = new ArrayList<>();
        String sql = """
            SELECT p.id, p.product_name, p.product_image, p.price, p.brand_name, p.product_description
            FROM search_history sh
            JOIN products p ON sh.product_id = p.id
            GROUP BY p.id
            ORDER BY COUNT(*) DESC
            LIMIT 10;
        """;

        try (PreparedStatement statement = connection.prepareStatement(sql); ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                String productId = resultSet.getString("id");
                String name = resultSet.getString("product_name");
                String image = resultSet.getString("product_image");
                double price = resultSet.getDouble("price");
                String brandName = resultSet.getString("brand_name");
                String productDescription = resultSet.getString("product_description");

                Product product = new Product(productId, image, name, price, brandName, productDescription);
                recommendedProducts.add(product);
            }
        }
        return recommendedProducts;
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

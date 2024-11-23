/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package papr;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author LuckyCharm
 */
public class ReviewHandlerServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
     private static final long serialVersionUID = 1L;

    // Database connection details
    private static final String DB_URL = "jdbc:mysql://localhost:3306/papr";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         String product = request.getParameter("product");
        double price = Double.parseDouble(request.getParameter("price"));
        String image = request.getParameter("image");
        String description = request.getParameter("description");
        String userEmail = request.getParameter("userEmail");
        int rating = Integer.parseInt(request.getParameter("rating"));
        String comment = request.getParameter("comment");

        // Sentiment analysis based on the comment
        String sentiment = analyzeSentiment(comment);

        // Connect to MySQL and store the review
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "INSERT INTO reviews (product, price, image, description, userEmail, rating, comment, sentiment) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, product);
                pstmt.setDouble(2, price);
                pstmt.setString(3, image);
                pstmt.setString(4, description);
                pstmt.setString(5, userEmail);
                pstmt.setInt(6, rating);
                pstmt.setString(7, comment);
                pstmt.setString(8, sentiment);

                pstmt.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle database errors (e.g., show an error page)
        }

        // Redirect or respond to the client
        response.sendRedirect("thankyou.jsp"); // Assuming you have a thank you page
    }

    private String analyzeSentiment(String comment) {
        comment = comment.toLowerCase();

        if (comment.contains("good") || comment.contains("great") || comment.contains("excellent")) {
            return "positive";
        } else if (comment.contains("bad") || comment.contains("poor") || comment.contains("terrible")) {
            return "negative";
        } else if (comment.contains("very bad") || comment.contains("awful")) {
            return "very negative";
        } else {
            return "neutral"; // In case the comment doesn't fit into the above categories
        }
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

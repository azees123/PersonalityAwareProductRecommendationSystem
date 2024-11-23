/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package papr;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

/**
 *
 * @author LuckyCharm
 */
@MultipartConfig
public class addProductServlet extends HttpServlet {

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

    // Directory where files will be uploaded
    private static final String UPLOAD_DIRECTORY = "uploads";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
         // Retrieve form parameters
        String productName = request.getParameter("product_name");
        String brandName = request.getParameter("brand_name");
        String productDescription = request.getParameter("product_description");
        String price = request.getParameter("price");
        String tag = request.getParameter("tag");
        String category = request.getParameter("category");

        // Handle file upload
        Part filePart = request.getPart("product_image");
        String fileName = filePart.getSubmittedFileName();
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }
        String filePath = uploadPath + File.separator + fileName;

        try (PrintWriter out = response.getWriter()) {
            // Write file to the upload directory
            filePart.write(filePath);

            // Database insertion
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                String sql = "INSERT INTO products (product_name, brand_name, product_description, price, tag, category, product_image) VALUES (?, ?, ?, ?, ?, ?, ?)";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setString(1, productName);
                    stmt.setString(2, brandName);
                    stmt.setString(3, productDescription);
                    stmt.setDouble(4, Double.parseDouble(price));
                    stmt.setString(5, tag);
                    stmt.setString(6, category);
                    stmt.setString(7, fileName);

                    int rowsInserted = stmt.executeUpdate();
                    if (rowsInserted > 0) {
                        out.println("<html><head>");
                        out.println("<style>");
                        out.println("body {");
                        out.println("  font-family: Arial, sans-serif;");
                        out.println("  margin: 0;");
                        out.println("  padding: 0;");
                        out.println("  display: flex;");
                        out.println("  justify-content: center;");
                        out.println("  align-items: center;");
                        out.println("  height: 100vh;");
                        out.println("  background-color: #f4f4f4;");
                        out.println("}");
                        out.println("div.container {");
                        out.println("  width: 80%;");
                        out.println("  max-width: 600px;");
                        out.println("  padding: 20px;");
                        out.println("  background-color: rgba(0, 128, 0, 0.1);");
                        out.println("  border-radius: 8px;");
                        out.println("  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);");
                        out.println("  text-align: center;");
                        out.println("}");
                        out.println("h2 { color: #4CAF50; }");
                        out.println("p { font-size: 16px; }");
                        out.println("a { color: #2196F3; text-decoration: none; }");
                        out.println("a:hover { text-decoration: underline; }");
                        out.println("</style>");
                        out.println("</head><body>");
                        out.println("<div class='container'>");
                        out.println("<h2>Product uploaded successfully!</h2>");
                        out.println("<p><a href='addProduct.jsp'>Add another product</a></p>");
                        out.println("</div>");
                        out.println("</body></html>");
                    } else {
                        out.println("<html><head>");
                        out.println("<style>");
                        out.println("body {");
                        out.println("  font-family: Arial, sans-serif;");
                        out.println("  margin: 0;");
                        out.println("  padding: 0;");
                        out.println("  display: flex;");
                        out.println("  justify-content: center;");
                        out.println("  align-items: center;");
                        out.println("  height: 100vh;");
                        out.println("  background-color: #f4f4f4;");
                        out.println("}");
                        out.println("div.container {");
                        out.println("  width: 80%;");
                        out.println("  max-width: 600px;");
                        out.println("  padding: 20px;");
                        out.println("  background-color: rgba(255, 0, 0, 0.1);");
                        out.println("  border-radius: 8px;");
                        out.println("  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);");
                        out.println("  text-align: center;");
                        out.println("}");
                        out.println("h3 { color: #F44336; }");
                        out.println("</style>");
                        out.println("</head><body>");
                        out.println("<div class='container'>");
                        out.println("<h3>Failed to upload product.</h3>");
                        out.println("</div>");
                        out.println("</body></html>");
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("<html><body><h3>Database error: " + e.getMessage() + "</h3></body></html>");
                }
            } catch (SQLException e) {
                e.printStackTrace();
                out.println("<html><body><h3>Database connection error: " + e.getMessage() + "</h3></body></html>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            try (PrintWriter out = response.getWriter()) {
                out.println("<html><body><h3>Error: " + e.getMessage() + "</h3></body></html>");
            }
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

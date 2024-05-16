<%-- 
    Document   : majClient
    Created on : 19 févr. 2024, 03:14:41
    Author     : Niclaudet
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%
    String numero = request.getParameter("numero");
    String nom = request.getParameter("nom");
    int solde = Integer.parseInt(request.getParameter("solde"));
    
    Connection con = null;
    PreparedStatement pst = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost/vueprojet", "root", "");

        String updateQuery = "UPDATE client SET nom=?, solde=? WHERE numCompte=?";
        pst = con.prepareStatement(updateQuery);
       // pst.setString(1, nom);
       // pst = con.prepareStatement(updateQuery);
        pst.setString(1, nom);
        pst.setInt(2, solde);
        pst.setString(3, numero);
        
int rowsAffected = pst.executeUpdate();
        if (rowsAffected > 0) {
            response.sendRedirect("afficheClient.jsp"); // Rediriger vers la page des étudiants après la mise à jour
        } else {
            out.println("La mise à jour a échoué.");
        }
    } catch (SQLException | ClassNotFoundException e) {
        out.println("Erreur : " + e.getMessage());
    } finally {
        try {
            if (pst != null) {
                pst.close();
            }
            if (con != null) {
                con.close();
            }
        } catch (SQLException ex) {
            out.println("Erreur lors de la fermeture des ressources : " + ex.getMessage());
        }
    }
    %>
<%-- 
    Document   : home
    Created on : 11 févr. 2024, 12:38:01
    Author     : USER
--%>

<%@page import="com.mysql.jdbc.Connection"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insertion de données</title>
</head>
<body>
    <h1>Insertion de données</h1>
    <form method="post" action="index.jsp">
       Numero: <input type="text" name="numCompte"><br>
        Nom: <input type="text" name="nom"><br>
       Solde: <input type="texte" name="solde"><br>
        <input type="submit" value="Insérer">
    </form>

    <% 
        String numCompte = request.getParameter("numCompte");
        String nom = request.getParameter("nom");
        String solde = request.getParameter("solde");
        
        // Code pour se connecter à la base de données et insérer les données
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = (Connection) DriverManager.getConnection("jdbc:mysql:"
                     + "//localhost:3306/vueprojet?useSSL=false","root","");
            PreparedStatement pst = con.prepareStatement("INSERT INTO client (numCompte, nom,solde) VALUES (?, ?,?)");
            pst.setString(1, numCompte);
            pst.setString(2, nom);
            pst.setString(3, solde);
            pst.executeUpdate();
            out.println("Données insérées avec succès !");
            con.close();
        } catch(Exception e) {
            out.println("Erreur : " + e.getMessage());
        }
    %>
</body>
</html>

<%-- 
    Document   : home
    Created on : 11 févr. 2024, 20:01:08
    Author     : USER
--%>

<%@page import="com.mysql.jdbc.Connection"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="style/css/style3.css">
         <link rel="stylesheet" href="style/css/bootstrap.min.css">
      
    </head>
    <body>
        
                <div className='w-30 rounded '  >
           <main class="table">
        <h1>Liste des clients</h1>
        <a><button class="nouveau">Ajouter client</button></a>
           <section class="table__body">
        <table class="table table-success table-striped">
            <tr>
                <th> Numero </th>
                <th> Nom </th>
                <th> Solde </th>
            </tr>
       
        
        
        
        
        <% 
        String numCompte = request.getParameter("numCompte");
        String nom = request.getParameter("nom");
        String solde = request.getParameter("solde");
        
        // Code pour se connecter à la base de données et insérer les données
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = (Connection) DriverManager.getConnection("jdbc:mysql:"
                     + "//localhost:3306/vueprojet?useSSL=false","root","");
            Statement stm = con.createStatement();
            ResultSet rs = stm.executeQuery("SELECT * from client");
           
            while (rs.next()){
              %>
    <tr>
        <td><%=rs.getString("numCompte")%></td>
        <td><%=rs.getString("nom")%></td>
        <td><%=rs.getString("solde")%></td>
    </tr>
    <%
            }
            
            rs.close();
            con.close();
            stm.close();
        } catch(Exception e) {
            out.println("Erreur : " + e.getMessage());
        }
    %>
     </table>
           </section> 
            </main>
     <div/>
    </body>
</html>

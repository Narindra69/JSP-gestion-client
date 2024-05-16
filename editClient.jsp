<%-- 
    Document   : editClient
    Created on : 13 févr. 2024, 17:57:42
    Author     : Niclaudet
--%>
<%@ page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
          <link rel="stylesheet" href="style/css/style3.css">
         <link rel="stylesheet" href="style/css/bootstrap.min.css">
        <title>Modifier</title>
    </head>
    <body>
        <section>
              <div class="form-box">
        <div class="form-value">
        <%
            String numero = request.getParameter("numero");
            Connection con = null;
            PreparedStatement pst = null;
            ResultSet rs = null;
            
            try {
                Class.forName("com.mysql.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost/vueprojet", "root", "");

                String selectQuery = "SELECT * FROM client WHERE numCompte=?";
                pst = con.prepareStatement(selectQuery);
                pst.setString(1, numero);
                
                rs = pst.executeQuery();
                if (rs.next()){
                    //Recuperation des données du client à modifier
                    String nom = rs.getString("nom");
                    int solde = rs.getInt("solde");
                
        %>
        
        <h1>Modifier le client </h1>
        <form action='majClient.jsp' method="POST"  class="form-value">
            <input type="hidden" name="numero" value='<%=numero%>'>
            


<label class="form-label">Nom</label>
                        <div class="inputbox">
                            <input type="text" name="nom" value="<%= nom %>" required ></input>
                           
                        </div>



<label class="form-label">Solde</label>
    <div class="inputbox">
              <input type="number"  name="solde" value="<%= solde %>" required>
    </div>
    <div class="divbtn">
            <input type="submit" id="submit" value='Enregistrer ' name='submit' class='menubtn'>
    </div>
        </form>
            
            <%
        } else {
            out.println("Client non trouvé.");
        }
    } catch (SQLException | ClassNotFoundException e) {
        out.println("Erreur : " + e.getMessage());
    } finally {
        // Fermeture des ressources (connexion, PreparedStatement, ResultSet)
        try {
            if (rs != null) {
                rs.close();
            }
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
    
        </div>
              </div>
    </section>
    </body>
</html>

<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<%
    if (request.getParameter("submit") != null) {
        String numero = request.getParameter("numero");
        String nom = request.getParameter("nom");
        int solde = Integer.parseInt(request.getParameter("solde"));
        
        Connection con = null;
        PreparedStatement pst = null;
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/vueprojet", "root", "");
            
            String insertQuery = "INSERT INTO client (numCompte, nom, solde) VALUES (?, ?, ?)";
            pst = con.prepareStatement(insertQuery);
            pst.setString(1, numero);
            pst.setString(2, nom);
            pst.setInt(3, solde);
            
            int rowsAffected = pst.executeUpdate();
            if (rowsAffected > 0) {
                out.println("Enregistrement réussi !");
                response.sendRedirect("afficheClient.jsp");
            } else {
                out.println("Enregistrement a échoué !");
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
            } catch (SQLException e) {
                out.println("Erreur lors de la fermeture de la connexion : " + e.getMessage());
            }
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="style/css/style3.css">
         <link rel="stylesheet" href="style/css/bootstrap.min.css">
    <title>Ajout d'un client</title>
</head>
<body>
      <section>
<div class="form-box">
        <div class="form-value">
        <h1>Ajout d'un client</h1>
        <form class="" method="post" class="form-value">
         
        <div class="inputbox">
            <input type="text" name="numero" placeholder="Numero du client" class="" >
        </div>
            <br>
         <div class="inputbox">
            <input type="text" name="nom" placeholder="Nom du client" class="">
         </div>
            <br>
         <div class="inputbox">
            <input type='number' name="solde" placeholder="Solde" class="">
         </div>
            </br>
            
            <div class="divbtn">
                <input type="submit" name="submit" value='Enregistrer' class="menubtn">
            </div>
        </form>
        
        <div class="divbtn">
            <a href="afficheClient.jsp"><button class="menubtn">Annuler</button></a>
        </div>
  </div>
              </div>
    </section>
</body>
</html>

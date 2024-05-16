<%@ page import="java.sql.*" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Supprimer Client</title>
    <script>
        function confirmSuppression() {
            // Afficher une boîte de dialogue de confirmation
            var result = confirm("Voulez-vous vraiment supprimer ce client ?");
            
            // Si l'utilisateur clique sur "OK", soumettre le formulaire
            if (result) {
                document.getElementById("supprimerForm").submit();
            }
        }
    </script>
</head>
<body>

<%
    String numero = request.getParameter("numero");
    Connection con = null;
    PreparedStatement pst = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost/vueprojet", "root", "");

        String deleteQuery = "DELETE FROM client WHERE numCompte=?";
        pst = con.prepareStatement(deleteQuery);
        pst.setString(1, numero);

        int rowsAffected = pst.executeUpdate();
        if (rowsAffected > 0) {
            response.sendRedirect("afficheClient.jsp"); // Rediriger vers la page des clients après la suppression
        } else {
            out.println("La suppression a échoué.");
        }
    } catch (SQLException | ClassNotFoundException e) {
        out.println("Erreur : " + e.getMessage());
    } finally {
        // Fermeture des ressources (connexion, PreparedStatement)
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

<form id="supprimerForm" action='supprimerClient.jsp' method="POST">
    <input type="hidden" name="numero" value='<%=numero%>'>
</form>

<script>
    // Appeler la fonction de confirmation au chargement de la page
    confirmSuppression();
</script>

</body>
</html>

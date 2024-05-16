<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
  
    

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
     <link rel="stylesheet" href="style/css/style3.css">
         <link rel="stylesheet" href="style/css/bootstrap.min.css">
       <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.7.0/chart.min.js"></script>

      


    <title>Liste des clients</title>
</head>
<body>
    
           <div className='w-30 rounded '  >
           <main class="table">
  
            <div class="liste-text">
                
                <div class="titre">
                       <h1 class="">CLIENT</h1>
                </div>
                <div class="butt">
                    <a href="ajoutClient.jsp">
                        <button class="btn1 ">
                            Ajouter 
                        </button>
                    </a>

      
                    <a href="histogramme.jsp">
                        <button class="btn1 ">
                            Diagramme 
                        </button>
                    </a>


            </div>
            </br>
                
            <div class="row">
                <div class="col mx-auto">
                 
                    <table class="table table-responsive table-bordered" cellpadding="0" width="100%">
                        <thead>
                            <tr>
                                <th>N°</th>
                                <th>Nom et prénoms</th>
                                <th>Solde</th>
                                <th>Observation</th>
                                <th colspan="2">Action</th>
                             
                            </tr>
                        </thead>
                        <tbody>
                            <%

                                String numCompte = request.getParameter("numCompte");
                                String nom = request.getParameter("nom");
                                String solde1 = request.getParameter("solde");
                          

                                try {

                                    Class.forName("com.mysql.jdbc.Driver");
                                    Connection con = (Connection) DriverManager.getConnection("jdbc:mysql:"
                                            + "//localhost:3306/vueprojet?useSSL=false", "root", "");
                                    Statement stm = con.createStatement();
                                    ResultSet rs = stm.executeQuery("SELECT * from client");
                                
                                    while (rs.next()) {
                                        int solde = rs.getInt("solde");
                                        String description;

                                        if (solde < 1000) {
                                            description = "insuffisant";
                                        } else if (solde >= 1000 && solde < 5000) {
                                            description = "moyen";
                                        } else {
                                            description = "élevé";
                                        }
                            %>
                            <tr>
                                            <td><%= rs.getString("numCompte")%></td>
                                            <td><%= rs.getString("nom")%></td>
                                            <td><%= solde %></td>
                                            <td><%= description %></td>
                                            <td><a href="editClient.jsp?numero=<%= rs.getString("numCompte")%>" class="btn btn-secondary btn-sm">
                                                <i class="fas fa-pencil-alt"></i> Modifier</a></td>
                                            <td><a href="deleteClient.jsp?numero=<%= rs.getString("numCompte")%>" class="btn btn-danger btn-sm" onclick="return confirm('Êtes-vous sûr de vouloir supprimer cet élément?');">
                                               <i class="fas fa-trash-alt"></i> Supprimer</a></td>
                                        </tr>
                                        
                                  
                            <%
                                    }

                                      rs.close();
            con.close();
            stm.close();
                                } catch (Exception e) {
                                    e.printStackTrace();
                                } 
                            %>
                        </tbody>
                    </table>
                        
                        <div>
                            
                            
                                <%

                                try {

                                    Class.forName("com.mysql.jdbc.Driver");
                                    Connection con = (Connection) DriverManager.getConnection("jdbc:mysql:"
                                            + "//localhost:3306/vueprojet?useSSL=false", "root", "");
                                    Statement stm = con.createStatement();
                                    ResultSet rs = stm.executeQuery("SELECT SUM(solde) AS total  , MAX(solde) AS max , MIN(solde) AS min FROM client  ");
                                     if (rs.next()){
                    //Recuperation des données du client à modifier
         
                    int total = rs.getInt("total");
                    int max = rs.getInt("max");
                    int min = rs.getInt("min");
                       %>
                       <label class="total">Total = <%= total%></label> <br>
                       <label class="form-label">Max = <%= max%></label><br>
                         <label class="form-label">Min = <%= min%></label>
                         
                  
                       
                         <%

                             }     
                                   rs.close();
            con.close();
            stm.close();
                                } catch (Exception e) {
                                    e.printStackTrace();
                                } 
                            %>
                                   
                     
                           
                        </div>      
                 
     
    </div>
                         
                                 </main>
     <div/>
</body>
</html>

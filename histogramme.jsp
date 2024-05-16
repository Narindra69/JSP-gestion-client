<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

  
    

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
     <link rel="stylesheet" href="style/css/style3.css">
         <link rel="stylesheet" href="style/css/bootstrap.min.css">
       <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.7.0/chart.min.js"></script>
<style>
* {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: sans-serif;
   }
   body 
   {
       min-height: 100vh;
      background: rgb(108,76,32);
background: linear-gradient(90deg, rgba(108,76,32,0) 13%, rgba(205,218,209,1) 43%, rgba(255,255,255,1) 100%);
       display: flex;
       justify-content: center;
       align-items: center;
   }
   .header
   {
       position: fixed;
       top: 0;
       left: 0;
       width: 100%;
       padding: 1.3rem 10%;
       background: rgba(0,0,0, .1);
       backdrop-filter: blur(50px);
       display: flex;
       justify-content: space-between;
       align-items: center;
       z-index: 100;
   }
   .logo
   {
       font-size: 2rem;
       color: #4D5656;
       text-decoration: none;
       font-weight: 700;
   }
   .navbar a
   {
       font-size: 1.15rem;
       color: #212F3C;
       text-decoration: none;
       font-weight: 500;
       margin-left: 2.5rem;
   }
   .navbar a:hover
   {
       color: #fff;
       font-size: 1.20rem;
   }
   .icons 
   {
       position: absolute;
       font-size: 2.8rem;
       right: 5%;
       color: #fff;
       cursor: pointer;
       display: none;
   }
   
   @media (max-width: 992px) {
       .header {
            padding: 1.3rem 5%;
       }
   }
   
   @media (max-width: 768px) {
       .icons {
            display: inline-flex;
       }
       
       .navbar {
            position: absolute;
            top: 100%;
            left: 0;
            width: 100%;
            height: 17.7rem;
            background: rgba(0,0,0, .1);
            backdrop-filter: blur(50px);
       }
       
       .navbar a {
            display: block;
            font-size: 1.1rem;
            margin: 1.5rem 0;
       }
   }
   em
   {
          color: #EBC473;
   }
   main.board
{
    width: 50vw;
    height: 70vh;
    background-color: #fff5;
    backdrop-filter: blur(7px);
    box-shadow: 0, .4rem, .8rem, #0005;
    border-radius: .8rem;
    overflow: hidden;
    margin-top: 5rem;
}

.canva{
    display: flex;
}

.histo{
    width: 70%;
    height: 70%;
   
}
</style>
      


    <title>Solde des clients</title>
</head>
<body>
    
           <nav class="navbar">
        
         
     </nav> 
            
            </br>
                
            <div class="row">
                <div class="col mx-auto">
                 
                
                        
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
                       <a href="afficheClient.jsp">Acceuil</a> <br>
                       <label class="form-label">Total = <%= total%></label> <br>
                       <label class="form-label">Max = <%= max%></label><br>
                         <label class="form-label">Min = <%= min%></label>
                         
                         <div class="canva">
                             <div class="histo">
         <canvas id="myChart"></canvas>
                             </div>
                             <div class="cam">
    <canvas id="pieChart"></canvas>
</div>

</div>
     <script>
    var ctx = document.getElementById('myChart').getContext('2d');
    var myChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: ['solde maximal', 'solde minimal', 'Total des soldes'],
            datasets: [{
                label: 'SOLDES',
                data: [<%= max %>, <%= min %>, <%= total %>],
                backgroundColor: [
                    'rgba(255, 99, 132, 0.2)',
                    'rgba(54, 162, 235, 0.2)',
                    'rgba(255, 206, 86, 0.2)'
                ],
                borderColor: [
                    'rgba(255, 99, 132, 1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(255, 206, 86, 1)'
                ],
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
</script>
<script>
    var ctxPie = document.getElementById('pieChart').getContext('2d');
    var pieChart = new Chart(ctxPie, {
        type: 'pie',
        data: {
            labels: ['Total des soldes', 'Solde maximal', 'Solde minimal'],
            datasets: [{
                label: 'Distribution des soldes',
                data: [<%= total %>, <%= max %>, <%= min %>],
                backgroundColor: [
                    'rgba(255, 99, 132, 0.5)',
                    'rgba(54, 162, 235, 0.5)',
                    'rgba(255, 206, 86, 0.5)',
                ],
                borderColor: [
                    'rgba(255, 99, 132, 1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(255, 206, 86, 1)',
                ],
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
        }
    });
</script>


                       
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

<%-- 
    Document   : horarios
    Created on : 30/01/2021, 10:31:48 PM
    Author     : dequi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Hospital DB - Horarios</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <script src="script.js"></script>
        <link rel="stylesheet" type="text/css" href="style.css">
    </head>
    <body>
        <h1>Horarios disponibles</h1>
        <%
            Connection conn = null;
            Statement st = null;
            ResultSet rs = null;

            String idMed = request.getParameter("id");
            String fecha = request.getParameter("fecha");
            String idPac = request.getParameter("idPac");
        %>
        <form method="post" class="col-xs-4 col-sm-4 col-md-4">
                        <input name="hora" list="horarios" id="patientsList" class="form-control"/>
                        <datalist id="horarios">
                        <% 
                            try {
                                Class.forName("com.mysql.jdbc.Driver");
                                conn = DriverManager.getConnection("jdbc:mysql://localhost/hospital-db?user=diquintero&password=MySQL2020&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC");
                                st = conn.createStatement();
                                rs = st.executeQuery("SELECT inic FROM `medico` WHERE id_med=" + idMed + ";");
                                // request.getRequestDispatcher("index.jsp").forward(request, response);
                                if (rs.next()) {
                                int inicio = Integer.parseInt(rs.getString(1).substring(0, 2));
                                for (int i = inicio; i<inicio+8; i++) {
                                    rs = st.executeQuery("SELECT hora_cita FROM `cita` WHERE id_med=" + idMed + " AND fecha_cita=" + fecha.replace("-", "") + " AND hora_cita=" + String.valueOf(i).format("%02d", i) + ";");
                                    if (!rs.next()) {
                                    %>
                                         <option value="<%= String.valueOf(i).format("%02d", i) + ":00" %>">
                                    <%
                                    }
         
                                }
                            }
                            } catch (Exception e) {
                                out.print(e);
                            }
                        %>
        </datalist>
        <button type="submit" name="agendar" class="btn btn-primary" style="margin-top: 20px;">Agendar</button>
                <%
                    if (request.getParameter("agendar") != null) {
                        int hora = Integer.parseInt(request.getParameter("hora").substring(0, 2));
                        try {
                            conn = DriverManager.getConnection("jdbc:mysql://localhost/hospital-db?user=diquintero&password=MySQL2020&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC");
                            st = conn.createStatement();
                            rs = st.executeQuery("SELECT MAX(id_cita) FROM cita");
                            int idCita=0;
                            if (rs.next())
                                idCita = Integer.parseInt(rs.getString(1))+1;
                            st.executeUpdate("INSERT INTO cita (id_cita, id_pac, id_med, fecha_cita, hora_cita) values ('"+idCita+"','"+idPac+"','"+idMed+"','"+fecha+"','"+hora+"');");
                            request.getRequestDispatcher("index.jsp").forward(request, response);
                        } catch (Exception e) {
                            out.print(e);
                        }
                    }
                %>  
                </form>
    </body>
</html>

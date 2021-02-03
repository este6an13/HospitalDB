<%-- 
    Document   : agendar
    Created on : 30/01/2021, 02:55:21 PM
    Author     : dequi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<!DOCTYPE html>
<html>
    <head>
        <title>HospitalDB - Agendamiento</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <script src="script.js"></script>
        <link rel="stylesheet" type="text/css" href="style.css">
    </head>
    <body>
        <h1>Agendamiento de Citas</h1>
        <%
            Connection conn = null;
            Statement st = null;
            ResultSet rs = null;
        %>
        <form class="col-xs-4 col-sm-4 col-md-4">
            <div class="form-group">
                <label for="patientsList">Paciente</label>
                <input list="patients" id="patientsList" class="form-control" name="patient"/>
                <datalist id="patients">
                <%
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost/hospital-db?user=diquintero&password=MySQL2020&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC");
                        st = conn.createStatement();
                        rs = st.executeQuery("SELECT id_pac, nombre_pac FROM `paciente`;");
                        while (rs.next()) {
                %>
                            <option value="<%= rs.getString(1) + " - "+ rs.getString(2)%>">
                <%
                        }
                    } catch (Exception e) {
                        out.print("error mysql " + e);
                    }
                %>  
                </datalist>
            </div>
            <div class="form-group">
                <label for="esp-selector">Especialidad</label>
                <select class="form-control" id="esp-selector" name="esp-selector" aria-describedby="esp-Help">
                        <option value="none" selected disabled hidden> 
                        Seleccione una opción 
                        <option>Medicina General</option>
                        <option>Neurología</option>
                        <option>Neurocirugía</option>
                        <option>Cirugía Plástica</option>
                        <option>Oftalmología</option>
                        <option>Otorrinolaringología</option>
                        <option>Odontología</option>
                        <option>Cardiología</option>
                        <option>Hepatología</option>
                        <option>Neumología</option>
                        <option>Gastroenterología</option>
                        <option>Urología</option>
                        <option>Ginecología</option>
                        <option>Pediatría</option>
                        <option>Psiquiatría</option>
                        <option>Oncología</option>
                  </select>
                  <small id="esp-Help" class="form-text text-muted">Seleccione la especialidad de la consulta.</small>
            </div>
            <div class="form-group">
                <label for="fecha-cita">Fecha</label>
                <input type=date class="form-control" id="fecha-cita" name="fecha-cita">
            </div>
            <button type="submit" name="buscar" class="btn btn-primary">Buscar</button>
        </form>
        <table class="table table-striped table-dark table-hover">
                    <thead>
                        <tr>
                            <th scope="col">Documento</th>
                            <th scope="col">Nombre</th>
                            <th scope="col">Especialidad</th>     
                            <th scope="col">Horarios Disponibles</th>     
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            if (request.getParameter("buscar") != null) {
                        
                                try {
                                    Class.forName("com.mysql.jdbc.Driver");
                                    conn = DriverManager.getConnection("jdbc:mysql://localhost/hospital-db?user=diquintero&password=MySQL2020&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC");
                                    st = conn.createStatement();
                                    rs = st.executeQuery("WITH r AS (SELECT id_med, nombre_med, esp FROM `medico` NATURAL JOIN `cita` WHERE esp='" + request.getParameter("esp-selector") + "' AND fecha_cita=" + request.getParameter("fecha-cita").replaceAll("-", "") + " GROUP BY id_med HAVING COUNT(id_med) < 7) SELECT * FROM r UNION ((SELECT id_med, nombre_med, esp FROM `medico` WHERE esp='" + request.getParameter("esp-selector") + "') EXCEPT (SELECT * FROM r));");
                                    while (rs.next()) {
                        %>
                        <tr>
                                        <th scope="row"><%= rs.getString(1)%></th>
                                        <td><%= rs.getString(2)%></td>
                                        <td><%= rs.getString(3)%></td>
                                        <td><a href="horarios.jsp?id=<%= rs.getString(1)%>&fecha=<%= request.getParameter("fecha-cita")%>&idPac=<%= request.getParameter("patient").split(" - ")[0]%>">Ver disponibilidad de horarios</a></td>
                                                                             
                        </tr>                                    
                        <%
                                    }
                                } catch (Exception e) {
                                    out.print("error mysql " + e);
                                }
                            }
                        %>  
                    </tbody>
                </table>           
    </body>
</html>

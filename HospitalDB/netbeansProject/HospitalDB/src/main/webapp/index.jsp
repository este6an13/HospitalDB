<%-- 
    Document   : index
    Created on : 29/01/2021, 01:39:08 PM
    Author     : dequi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<!DOCTYPE html>
<html>
    <head>
        <title>HospitalDB - Home</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <script src="script.js"></script>
        <link rel="stylesheet" type="text/css" href="style.css">
    </head>
    <body>
        
        <%
            Connection conn = null;
            Statement st = null;
            ResultSet rs = null;
        %>
        
        
        <h1>¡Bienvenido!</h1>
        
        <div class="tab">
            <button class="tablinks" onclick="openSection(event, 'medicos')">Médicos</button>
            <button class="tablinks" onclick="openSection(event, 'pacientes')">Pacientes</button>
            <button class="tablinks" onclick="openSection(event, 'citas')">Citas</button>
        </div>
        
        
        <div id="medicos" class="tabcontent"> 
            <h3>Médicos</h3>   
            
            <button onclick="displayForm('form-new-med');" style="background-color: Transparent; border-color: Transparent;"><img src="https://cdn0.iconfinder.com/data/icons/flat-security-icons/512/plus-blue.png" width="25px"></button>
            <form class="col-xs-4 col-sm-4 col-md-4" name="form-new-med" method="post";" id="form-new-med" style="display: none;">
                <div class="form-group">
                  <label for="id-med">Número de Documento</label>
                  <input class="form-control" id="id-med" name="id-med">
                </div>
                <div class="form-group">
                  <label for="tipo-id-med">Tipo de Documento</label>
                  <select class="form-control" id="tipo-id-selector" name="tipo-id-selector" aria-describedby="tipo-id-Help">
                        <option value="none" selected disabled hidden> 
                        Seleccione una opción 
                        <option value="CC">Cédula de Ciudadanía [CC]</option>
                        <option value="TI">Tarjeta de Identidad [TI]</option>
                        <option value="CE">Cédula de Extranjería [CE]</option>
                        <option value="PP">Pasaporte [PP]</option>
                  </select>
                  <small id="tipo-id-Help" class="form-text text-muted">Seleccione el tipo de documento del médico.</small>
                </div>
                <div class="form-group">
                  <label for="nombre-med">Nombres y Apellidos</label>
                  <input class="form-control" id="nombre-med" name="nombre-med">
                </div> 
                <div class="form-group">
                  <label for="tar">Número de Tarjeta Profesional</label>
                  <input class="form-control" id="tar" name="tar" >
                </div>
                <div class="form-group">
                  <label for="exp-med">Años de Experiencia</label>
                  <input type=number step=".1" min="0" class="form-control" id="exp-med" name="exp-med" aria-describedby="exp-Help">
                  <small id="exp-Help" class="form-text text-muted">Escriba el número de años de experiencia como un número decimal con una cifra significativa.</small>
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
                  <small id="esp-Help" class="form-text text-muted">Seleccione la especialidad del médico.</small>
                </div>
                <div class="form-group">
                  <label for="inic">Hora de Inicio de Atención</label>
                  <select class="form-control" id="inic-selector" name="inic-selector" aria-describedby="inic-Help">
                        <option value="none" selected disabled hidden> 
                        Seleccione una opción 
                        <option>07:00</option>
                        <option>08:00</option>
                        <option>09:00</option>
                        <option>10:00</option>
                        <option>11:00</option>
                  </select>
                  <small id="inic-Help" class="form-text text-muted">Seleccione la hora en la que el médico iniciará la atención.</small>
                </div>
                <button type="submit" name="addMed" class="btn btn-primary">Agregar</button>
                <%
                    if (request.getParameter("addMed") != null) {
                        String idMed = request.getParameter("id-med");
                        String tipoIdMed = request.getParameter("tipo-id-selector");
                        String nombreMed = request.getParameter("nombre-med");
                        String numTP = request.getParameter("tar");
                        Double expMed = Double.parseDouble(request.getParameter("exp-med"));
                        String espMed = request.getParameter("esp-selector");
                        int inic = Integer.parseInt(request.getParameter("inic-selector").substring(0, 2));
                        String inicMed = request.getParameter("inic-selector");
                        String finMed = String.valueOf(inic + 8).format("%02d", inic + 8) + ":00";
                        try {
                            conn = DriverManager.getConnection("jdbc:mysql://localhost/hospital-db?user=diquintero&password=MySQL2020&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC");
                            st = conn.createStatement();
                            st.executeUpdate("INSERT INTO medico (id_med, tipo_id_med, nombre_med, num_tp, exp, esp, inic, fin) values ('"+idMed+"','"+tipoIdMed+"','"+nombreMed+"','"+numTP+"','"+expMed+"','"+espMed+"','"+inicMed+"','"+finMed+"');");
                            request.getRequestDispatcher("index.jsp").forward(request, response);
                        } catch (Exception e) {
                            out.print(e);
                        }
                    }
                %>    
            </form>   
            <table class="table table-striped table-dark table-hover" style="margin-top: 20px;">
                <thead>
                    <tr>
                        <th scope="col">ID</th>
                        <th scope="col">Tipo de ID</th>
                        <th scope="col">Nombre</th>
                        <th scope="col">Tarjeta Profesional</th>
                        <th scope="col">Años de Experiencia</th>
                        <th scope="col">Especialidad</th>
                        <th scope="col">Inicio de Atención</th>
                        <th scope="col">Fin de Atención</th>
                        <th scope="col">Editar</th>
                        <th scope="col">Eliminar</th>                        
                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            conn = DriverManager.getConnection("jdbc:mysql://localhost/hospital-db?user=diquintero&password=MySQL2020&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC");
                            st = conn.createStatement();
                            rs = st.executeQuery("SELECT * FROM `medico`;");
                            while (rs.next()) {
                    %>
                    <tr>
                                <th scope="row"><%= rs.getString(1)%></th>
                                <td><%= rs.getString(2)%></td>
                                <td><%= rs.getString(3)%></td>
                                <td><%= rs.getString(4)%></td>
                                <td><%= rs.getString(5)%></td>
                                <td><%= rs.getString(6)%></td>
                                <td><%= rs.getString(7)%></td>
                                <td><%= rs.getString(8)%></td>
                                <td><a href="edit.jsp?id=<%= rs.getString(1)%>&tipo=<%= rs.getString(2)%>&nombre=<%= rs.getString(3)%>&tp=<%= rs.getString(4)%>&exp=<%= rs.getString(5)%>&esp=<%= rs.getString(6)%>&inic=<%= rs.getString(7)%>&fin=<%= rs.getString(8)%>">Editar</a></td>
                                <td><a href="delete.jsp?id=<%= rs.getString(1)%>&selector=medico">Eliminar</a></td>
                    </tr>                                    
                    <%
                            }
                        } catch (Exception e) {
                            out.print("error mysql " + e);
                        }
                    %>  
                </tbody>
            </table>           
        </div>
        
        <div id="pacientes" class="tabcontent"> 
            <h3>Pacientes</h3>
            <button onclick="displayForm('form-new-pac');" style="background-color: Transparent; border-color: Transparent;"><img src="https://cdn0.iconfinder.com/data/icons/flat-security-icons/512/plus-blue.png" width="25px"></button>
            <form class="col-xs-4 col-sm-4 col-md-4" name="form-new-pac" method="post";" id="form-new-pac" style="display: none;">
                <div class="form-group">
                  <label for="id-pac">Número de Documento</label>
                  <input class="form-control" id="id-pac" name="id-pac">
                </div>
                <div class="form-group">
                  <label for="tipo-id-pac">Tipo de Documento</label>
                  <select class="form-control" id="tipo-id-pac-selector" name="tipo-id-pac-selector" aria-describedby="tipo-id-pac-Help">
                        <option value="none" selected disabled hidden> 
                        Seleccione una opción 
                        <option value="CC">Cédula de Ciudadanía [CC]</option>
                        <option value="TI">Tarjeta de Identidad [TI]</option>
                        <option value="CE">Cédula de Extranjería [CE]</option>
                        <option value="PP">Pasaporte [PP]</option>
                  </select>
                  <small id="tipo-id-pac-Help" class="form-text text-muted">Seleccione el tipo de documento del paciente.</small>
                </div>
                <div class="form-group">
                  <label for="nombre-pac">Nombres y Apellidos</label>
                  <input class="form-control" id="nombre-pac" name="nombre-pac">
                </div> 
                <div class="form-group">
                  <label for="fdn-pac">Fecha de Nacimiento</label>
                  <input type=date class="form-control" id="fdn-pac" name="fdn-pac">
                </div> 
                <div class="form-group">
                  <label for="eps-pac">EPS</label>
                  <select class="form-control" id="eps-selector" name="eps-selector" aria-describedby="eps-Help">
                        <option value="none" selected disabled hidden> 
                        Seleccione una opción 
                        <option>Compensar</option>
                        <option>Sanitas</option>
                        <option>Famisanar</option>
                        <option>Salud Total</option>
                        <option>Sura</option>
                        <option>Nueva EPS</option>
                        <option>Coomeva</option>
                        <option>Cruz Blanca</option>
                        <option>Conenalco</option>
                        <option>EPS S.O.S.</option>
                        <option>Aliansalud</option>
                        <option>Medimás</option>
                  </select>
                  <small id="esp-Help" class="form-text text-muted">Seleccione la EPS a la que está afiliado el paciente.</small>
                </div>
                <div>
                    <label>Historia Clínica</label>
                    <textarea id="historia-pac" name="historia-pac" class="form-control"  rows="5"></textarea>
                </div>
                <button type="submit" name="addPac" class="btn btn-primary">Agregar</button>
                <%
                    if (request.getParameter("addPac") != null) {
                        String idPac = request.getParameter("id-pac");
                        String tipoIdPac = request.getParameter("tipo-id-pac-selector");
                        String nombrePac = request.getParameter("nombre-pac");
                        String fdnPac = request.getParameter("fdn-pac");
                        String epsPac = request.getParameter("eps-selector");
                        String histPac = request.getParameter("historia-pac"); 
                        try {
                            conn = DriverManager.getConnection("jdbc:mysql://localhost/hospital-db?user=diquintero&password=MySQL2020&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC");
                            st = conn.createStatement();
                            st.executeUpdate("INSERT INTO paciente (id_pac, tipo_id_pac, nombre_pac, fecha_nac, eps, historia) values ('"+idPac+"','"+tipoIdPac+"','"+nombrePac+"','"+fdnPac+"','"+epsPac+"','"+histPac+"');");
                            request.getRequestDispatcher("index.jsp").forward(request, response);
                        } catch (Exception e) {
                            out.print(e);
                        }
                    }
                %>    
            </form>   
            <table class="table table-striped table-dark table-hover" style="margin-top: 20px;">
                <thead>
                    <tr>
                        <th scope="col">ID</th>
                        <th scope="col">Tipo de ID</th>
                        <th scope="col">Nombre</th>
                        <th scope="col">Fecha de Nacimiento</th>
                        <th scope="col">EPS</th>
                        <th scope="col">Historia Clínica</th>
                        <th scope="col">Editar</th>
                        <th scope="col">Eliminar</th>        
                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            conn = DriverManager.getConnection("jdbc:mysql://localhost/hospital-db?user=diquintero&password=MySQL2020&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC");
                            st = conn.createStatement();
                            rs = st.executeQuery("SELECT * FROM `paciente`;");
                            while (rs.next()) {
                    %>
                    <tr>
                                <th scope="row"><%= rs.getString(1)%></th>
                                <td><%= rs.getString(2)%></td>
                                <td><%= rs.getString(3)%></td>
                                <td><%= rs.getString(4)%></td>
                                <td><%= rs.getString(5)%></td>
                                <td><%= rs.getString(6)%></td>
                                <td><a href="editPac.jsp?id=<%= rs.getString(1)%>&tipo=<%= rs.getString(2)%>&nombre=<%= rs.getString(3)%>&fdn=<%= rs.getString(4)%>&eps=<%= rs.getString(5)%>&hist=<%= rs.getString(6)%>">Editar</a></td>
                                <td><a href="delete.jsp?id=<%= rs.getString(1)%>&selector=paciente">Eliminar</a></td>
                    </tr>                                    
                    <%
                            }
                        } catch (Exception e) {
                            out.print("error mysql " + e);
                        }
                    %>  
                </tbody>
            </table>           
            
        </div>
        
        <div id="citas" class="tabcontent"> 
            <h3>Citas</h3>
            <a href="agendar.jsp"><em><strong>Agendar</strong></em></a>
            <table class="table table-striped table-dark table-hover" style="margin-top: 20px;">
                <thead>
                    <tr>
                        <th scope="col">ID Paciente</th>
                        <th scope="col">Paciente</th>
                        <th scope="col">Médico</th>
                        <th scope="col">Especialidad</th>
                        <th scope="col">Hora</th>
                        <th scope="col">Fecha</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            conn = DriverManager.getConnection("jdbc:mysql://localhost/hospital-db?user=diquintero&password=MySQL2020&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC");
                            st = conn.createStatement();
                            rs = st.executeQuery("SELECT id_pac, nombre_pac, nombre_med, esp, hora_cita, fecha_cita FROM `medico` NATURAL JOIN `cita` NATURAL JOIN `paciente`;");
                            while (rs.next()) {
                    %>
                    <tr>
                                <th scope="row"><%= rs.getString(1)%></th>
                                <td><%= rs.getString(2)%></td>
                                <td><%= rs.getString(3)%></td>
                                <td><%= rs.getString(4)%></td>
                                <td><%= String.valueOf(Integer.parseInt(rs.getString(5))).format("%02d", Integer.parseInt(rs.getString(5))) + ":00"%></td>
                                <td><%= rs.getString(6)%></td>
                    </tr>                                    
                    <%
                            }
                        } catch (Exception e) {
                            out.print("error mysql " + e);
                        }
                    %>  
                </tbody>
            </table>      
        </div>      
    </body>
</html>

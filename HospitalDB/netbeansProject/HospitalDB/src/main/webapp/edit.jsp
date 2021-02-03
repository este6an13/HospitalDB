<%-- 
    Document   : edit
    Created on : 30/01/2021, 10:39:35 AM
    Author     : dequi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<!DOCTYPE html>
<html>
    <head>
        <title>HospitalDB - Editar Médico</title>
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
            

            String idMed = request.getParameter("id");
            String tipoIdMed = request.getParameter("tipo");
            String nombreMed = request.getParameter("nombre");
            String numTP = request.getParameter("tp");
            String expMed = request.getParameter("exp");
            String espMed = request.getParameter("esp");
            String inicMed = request.getParameter("inic");
            String finMed = request.getParameter("fin");  
        %>
        
        <div class="section"> 
            <a href="index.jsp"">Regresar sin editar</a>
            <h3>Editar Médico</h3>
            <form name="form-edit-med" action="edit.jsp" method="get";">
                <div class="form-group">
                  <input type="hidden" class="form-control" id="id-med" name="id-med" value="<%= idMed %>">
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
                  <input class="form-control" id="nombre-med" name="nombre-med" value="<%= nombreMed %>">
                </div> 
                <div class="form-group">
                  <label for="tar">Número de Tarjeta Profesional</label>
                  <input class="form-control" id="tar" name="tar" value="<%= numTP %>">
                </div>
                <div class="form-group">
                  <label for="nombre-med">Años de Experiencia</label>
                  <input class="form-control" id="exp-med" name="exp-med" value="<%= expMed %>" aria-describedby="exp-Help">
                  <small id="exp-Help" class="form-text text-muted">Escriba el número de años de experiencia como un número decimal con una cifra significativa.</small>
                </div> 
                <div class="form-group">
                  <label for="esp-med">Especialidad</label>
                  <select class="form-control" id="esp-selector" name="esp-selector" value="<%= espMed %>" aria-describedby="esp-Help">
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
                  <select class="form-control" id="inic-selector" name="inic-selector" value="<%= inicMed %>" aria-describedby="inic-Help">
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
                <button type="submit" name="editMed" class="btn btn-primary">Guardar</button>
                <%
                    if (request.getParameter("editMed") != null) {
                        idMed = request.getParameter("id-med");
                        tipoIdMed = request.getParameter("tipo-id-selector");
                        nombreMed = request.getParameter("nombre-med");
                        numTP = request.getParameter("tar");
                        expMed = request.getParameter("exp-med");
                        espMed = request.getParameter("esp-selector");
                        int inic = Integer.parseInt(request.getParameter("inic-selector").substring(0, 2));
                        inicMed = request.getParameter("inic-selector");
                        finMed = String.valueOf(inic + 8).format("%02d", inic + 8) + ":00";
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            conn = DriverManager.getConnection("jdbc:mysql://localhost/hospital-db?user=diquintero&password=MySQL2020&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC");
                            st = conn.createStatement();
                            st.executeUpdate("UPDATE medico SET id_med='" + idMed + "',tipo_id_med='" + tipoIdMed + "',nombre_med='" + nombreMed + "',num_tp='" + numTP + "',exp='" + expMed + "',esp='" + espMed + "',inic='" + inicMed + "',fin='" + finMed + "' where id_med='" + idMed + "';");
                            request.getRequestDispatcher("index.jsp").forward(request, response);
                        } catch (Exception e) {
                            out.print(e);
                        }
                    }
                %>    
            </form>   
        </div>
    </body>
</html>
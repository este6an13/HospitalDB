<%-- 
    Document   : editPac
    Created on : 30/01/2021, 02:01:15 PM
    Author     : dequi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<!DOCTYPE html>
<html>
    <head>
        <title>HospitalDB - Editar Paciente</title>
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
            

            String idPac = request.getParameter("id");
            String tipoIdPac = request.getParameter("tipo");
            String nombrePac = request.getParameter("nombre");
            String fdnPac = request.getParameter("fdn");
            String epsPac = request.getParameter("eps");
            String histPac = request.getParameter("hist"); 
        %>
        
        <a href="index.jsp">Regresar sin editar</a>
        
        <div class="section"> 
            
            <h3>Editar Paciente</h3>
            <form name="form-edit-pac" action="editPac.jsp" method="get";">
                <div class="form-group">
                  <input type="hidden" class="form-control" id="id-pac" name="id-pac" value="<%= idPac %>">
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
                  <input class="form-control" id="nombre-pac" name="nombre-pac" value="<%= nombrePac %>">
                </div> 
                <div class="form-group">
                  <label for="fdn-pac">Fecha de Nacimiento</label>
                  <input type=date class="form-control" id="fdn-pac" name="fdn-pac" value="<%= fdnPac %>">
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
                    <textarea id="historia-pac" name="historia-pac" class="form-control"><%= histPac %></textarea>
                </div>
                <button type="submit" name="editPac" class="btn btn-primary">Guardar</button>
                <%
                    if (request.getParameter("editPac") != null) {
                        idPac = request.getParameter("id-pac");
                        tipoIdPac = request.getParameter("tipo-id-pac-selector");
                        nombrePac = request.getParameter("nombre-pac");
                        fdnPac = request.getParameter("fdn-pac");
                        epsPac = request.getParameter("eps-selector");
                        histPac = request.getParameter("historia-pac"); 
                        try {
                            conn = DriverManager.getConnection("jdbc:mysql://localhost/hospital-db?user=diquintero&password=MySQL2020&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC");
                            st = conn.createStatement();
                            st.executeUpdate("UPDATE paciente SET tipo_id_pac='" + tipoIdPac + "',nombre_pac='" + nombrePac + "',fecha_nac='" + fdnPac + "',eps='" + epsPac + "',historia='" + histPac + "' WHERE id_pac='" + idPac + "';");
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
<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- === bootstrap === -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
        <!-- === bootstrap cdn | font awesome === -->        
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <title>Editar empleado</title>        
    </head>
    <body>
        <% 
            // ===========================================================================
            // === recibir los valores (id, nombre, direccion, telefono) que vamos a colocar en el formulario ===
            // ===========================================================================
            
            // === capturar los datos ===
            String id = request.getParameter("id");
            String nombre = request.getParameter("nombre");
            String direccion = request.getParameter("direccion");
            String telefono = request.getParameter("telefono");
        %>
        <div class="container mt-5">
            <div class="row">
                <div class="col-sm">
                    <h3 class="mb-5">Editar empleado</h3>
                    <!-- === formulario | crear empleado === -->
                    <form action="editar.jsp" method="get">
                        <div class="form-group">
                            <label for="nombre">Nombre</label>
                            <input type="text" class="form-control" id="nombre" value="<% out.print(nombre); %>" name="nombre" placeholder="Nombre" required="required">                            
                        </div>
                        <div class="form-group">
                            <label for="direccion">Dirección</label>
                            <input type="text" class="form-control" id="direccion" value="<% out.print(direccion); %>" name="direccion" placeholder="Dirección" required="required">                            
                        </div>
                        <div class="form-group">
                            <label for="telefono">Teléfono</label>
                            <input type="text" class="form-control" id="telefono" value="<% out.print(telefono); %>" name="telefono" placeholder="Teléfono" required="required">                            
                        </div>
                        
                        <a href="index.jsp" class="btn btn-danger shadow">Cancelar<i class="fa-solid fa-ban" aria-hidden="true"></i></a>
                        
                        <button type="submit" class="btn btn-primary shadow" name="enviar">Guardar <i class="fa-solid fa-floppy-disk"></i></button>
                        
                        <!--  ===  guardar el ID, porque se envia, pero no se edita | input "hidden"  (no se muestran) === -->
                        <input type="hidden" name="id" value="<% out.print(id); %>" >
                        
                    </form>

                </div>
            </div>
        </div>

        <%
            // ==========================
            // === MODIFICAR | en la bbdd ===
            // ==========================

            // === validar si se hizo click en botón Guardar (enviar) ===
            if (request.getParameter("enviar") != null) {
                              
                
                // === conectar a la bbdd ===
                try {
                    // === declarar conector ===
                    Connection con = null;
                    // === declarar statement ===
                    Statement st = null;
                    // === decompilar mysql ===
                    Class.forName("com.mysql.jdbc.Driver");
                    // === inicializar conector ===
                    con = DriverManager.getConnection("jdbc:mysql://localhost/bd_jsp?user=root&password=");
                    // === inicializar statement ===
                    st = con.createStatement();
                    // === con el statement crear consulta ===
                    st.executeUpdate("UPDATE empleados SET nombre = ' "+nombre+" ', direccion = ' "+direccion+" ', telefono = ' "+telefono+" ' WHERE id = ' "+id+" '; ");
                    // === una vez insertados los datos | redireccionar a la página index.jsp ===
                    request.getRequestDispatcher("index.jsp").forward(request, response);
                    
                } catch (Exception e) {
                    // === en caso de error | imprimir el tipo de error ===
                    out.print(e);
                }
            }

        %>

    </body>
</html>


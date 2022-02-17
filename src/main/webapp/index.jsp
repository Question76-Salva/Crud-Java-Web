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
        <title>Lista de empleados</title>
    </head>
    <body>

        <!-- ================== -->
        <!-- === conectar bbdd  === -->
        <!-- ================== -->
        <%
            // === validar si el usuario está conectado ===
            HttpSession sesion = request.getSession();
            if (sesion.getAttribute("logueado") == null || sesion.getAttribute("logueado").equals("0")) {
                // === regresar a login.jsp | porque no puede estar aquí si no tiene usuario y contraseña ===
                response.sendRedirect("login.jsp");
            }

            // === variables de conexión a la bbdd ===
            Connection con = null;
            Statement st = null;
            ResultSet rs = null;
        %>

        <div class="container">

            <!-- === navbar | para datos del usuario logueado == -->
            <nav class="navbar navbar-light bg-light shadow">
                <a class="navbar-brand">Sistema Web Java JSP y MySQL | CRUD y Login</a>
                <form class="form-inline" action="logout.jsp">
                    <!-- === capturar el nombre del usuario logueado === -->
                    <a href="datosUsuario.jsp"><i class="fa-solid fa-circle-user mr-1"></i><% out.print(sesion.getAttribute("user")); %></a>                              
                    <button class="btn btn-outline-danger my-2 my-sm-0 ml-3" type="submit">Log out</button>
                </form>
            </nav>

            <div class="row mt-5">
                <div class="col-sm">      
                    <table class="table table-striped shadow">
                        <thead>
                            <tr>
                                <th scope="col" colspan="4"><h3>Empleados</h3></th>
                                <th scope="col">
                                    <a href="crear.jsp"><i class="fa-solid fa-user-plus"></i></a>
                                </th>
                            </tr>
                            <tr>
                                <th scope="col">ID</th>
                                <th scope="col">Nombre</th>
                                <th scope="col">Dirección</th>
                                <th scope="col">Teléfono</th>
                                <th scope="col">Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- ====================================== -->
                            <!-- === mostrar datos de la bbdd dinámicamente === -->
                            <!-- ====================================== -->
                            <%
                                try {
                                    Class.forName("com.mysql.jdbc.Driver");
                                    con = DriverManager.getConnection("jdbc:mysql://localhost/bd_jsp?user=root&password=");
                                    st = con.createStatement();
                                    rs = st.executeQuery("SELECT * FROM empleados");
                                    while (rs.next()) {
                            %>
                            <tr>
                                <th scope="row"><% out.print(rs.getString("id"));  %></th>
                                <td><% out.print(rs.getString("nombre"));  %></td>
                                <td><% out.print(rs.getString("direccion"));  %></td>
                                <td><% out.print(rs.getString("telefono"));  %></td>
                                <td>
                                    <a href="editar.jsp?id=<% out.print(rs.getString("id"));  %>&nombre=<% out.print(rs.getString("nombre"));  %>&direccion=<% out.print(rs.getString("direccion"));  %>&telefono=<% out.print(rs.getString("telefono"));  %>"><i class="fa-solid fa-pencil"></i></a>
                                    <a href="borrar.jsp?id=<% out.print(rs.getString("id"));  %>" class="ml-4"><i class="fa-solid fa-trash-can" aria-hidden="true"></i></a>
                                </td>                                
                            </tr>           
                            <%
                                    }
                                } catch (Exception e) {
                                    out.print("Error mysql " + e);
                                }

                            %>

                        </tbody>
                    </table>

                </div> 
            </div>

    </body>
</html>

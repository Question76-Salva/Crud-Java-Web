<%@page import="java.math.BigInteger"%>
<%@page import="java.security.MessageDigest"%>
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
        <title>Login</title>
    </head>
    <body>

        <div class="container mt-5">
            <div class="row">
                <div class="col-sm">
                    <h3 class="mb-5">Login de empleados</h3>
                    <!-- ==================== -->
                    <!-- === formulario | login === -->
                    <!-- ==================== -->                   
                    <form method="post" action="login.jsp">
                        <div class="form-group">
                            <label>Usuario</label>
                            <input type="text" class="form-control" name="user" placeholder="Introduzca usuario">
                        </div>
                        <div class="form-group">
                            <label>Password</label>
                            <input type="password" class="form-control" name="password" placeholder="Introduzca constraseña">
                        </div>
                        <button type="submit" class="btn btn-primary shadow" name="login">Login</button>
                    </form>

                    <%
                        // ======================================================================
                        // === LOGIN dinámico | de la bbdd | validar que el usuario y el password sean correctos ===
                        // ======================================================================

                        // === crear conexión a la bbdd ===
                        // === variables de conexión a la bbdd ===
                        Connection con = null;
                        Statement st = null;
                        ResultSet rs = null;

                        // === validar que se ha dado click al botón de "Login" ===
                        if (request.getParameter("login") != null) {
                            // === capturar los datos de los inputs del formulario ===
                            String user = request.getParameter("user");
                            String password = request.getParameter("password");
                            // === guardar la sesión ===
                            HttpSession sesion = request.getSession();

                            try {
                                // === conectar con la bbdd ===
                                Class.forName("com.mysql.jdbc.Driver");
                                con = DriverManager.getConnection("jdbc:mysql://localhost/bd_jsp?user=root&password=");
                                st = con.createStatement();
                                rs = st.executeQuery(" SELECT * FROM `user` WHERE user ='" + user + "'  AND password ='" + password + "';  ");
                                // === si encuentra al usuario ===
                                while (rs.next()) {
                                    // === guardar en la sesión ===
                                    sesion.setAttribute("logueado", "1");
                                    sesion.setAttribute("user", rs.getString("user"));
                                    sesion.setAttribute("id", rs.getString("id"));
                                    // === redireccionar ===
                                    response.sendRedirect("index.jsp");
                                }
                                // === si no se encuentra al usuario ===
                                out.print(" <div class=\"alert alert-danger mt-5 shadow\"  role=\"alert\">Usuario no válido</div>");

                            } catch (Exception e) {

                            }
                        }
                    %>

                </div>
            </div>
        </div>

    </body>
</html>


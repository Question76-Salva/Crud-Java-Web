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
        <title>Datos de sesión del usuario</title>
    </head>
    <body>
        <!-- ====================================== -->
        <!-- === modificar/actualizar los datos del usuario ===  -->
        <!-- ====================================== -->

        <%
            // == validar/comprobar que el usuario esté logueado ===            
            // === guardar la sesión ===
            HttpSession sesion = request.getSession();
            // === si el usuario no está logueado ===
            if (sesion.getAttribute("logueado") == null || sesion.getAttribute("logueado").equals("0")) {
                // === redireccionar a login.jsp | si no estás logueado vuelve a intentarlo ===
                response.sendRedirect("loguin.jsp");
            }

            // === conectar con la bbdd ===
            Connection con = null;
            Statement st = null;

        %>

        <div class="container mt-5">
            <div class="row">
                <div class="col-sm">
                    <h3 class="mb-5">Datos de sesión del usuario</h3>

                    <form action="datosUsuario.jsp" method="post">
                        <div class="form-group">
                            <label>User</label>
                            <input type="text" class="form-control" name="user" placeholder="Usuario" value="<% out.print(session.getAttribute("user"));%>">                
                        </div>
                        <div class="form-group">
                            <label>Password</label>
                            <input type="text" class="form-control" name="password1" placeholder="Password">                
                        </div>
                        <div class="form-group">
                            <label>Confirmar password</label>
                            <input type="text" class="form-control" name="password2" placeholder="Repita su password">                
                        </div>
                        <button type="submit" class="btn btn-primary shadow" name="guardar">Guardar</button>
                        <a href="index.jsp" class="btn btn-danger shadow">Cancelar</a>
                    </form>

                </div>
            </div>
        </div>

    </body>

    <%
        // =============================
        // === guardar los datos del usaurio ===
        // =============================

        // == comprobar si se le pulsó botón "guardar" ===
        if (request.getParameter("guardar") != null) {
            // === guardar datos del usuario ===
            String user = request.getParameter("user");
            String password1 = request.getParameter("password1");
            String password2 = request.getParameter("password2");
            // === comporobar si los dos passwords son iguales ===
            if (password1.equals(password2)) {
                // === realizar la conexión a la bbdd ===
                try {
                    // === decompilar mysql ===
                    Class.forName("com.mysql.jdbc.Driver");
                    // === inicializar conector ===
                    con = DriverManager.getConnection("jdbc:mysql://localhost/bd_jsp?user=root&password=");
                    // === inicializar statement ===
                    st = con.createStatement();
                    // === con el statement crear consulta ===
                    st.executeUpdate("UPDATE user SET user = ' " + user + " ', password = ' " + password1 + " '  WHERE id = ' " + sesion.getAttribute("id") + " '; ");
                    // === actualizar el usuario | guardar cambio en la sesión ===
                    sesion.setAttribute("user", user);
                    // === redireccionar ===
                    response.sendRedirect("index.jsp");
                    
                } catch (Exception e) {
                    // === si ha ocurrido algún error | imprimelo ===
                    out.print(e);
                }
                
            } else {
                // === si los passwords son diferentes ===                
                 out.print(" <div class=\"alert alert-danger mt-5 shadow\"  role=\"alert\">Los passwords no coinciden</div>");
            }

        }

    %>

</html>

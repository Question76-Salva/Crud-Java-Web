<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Log out</title>
    </head>
    <body>
        <%
            // ==================
            // === desloguearse ===
            // ==================
            
            // === captura la sesión ===
            HttpSession sesion = request.getSession();
            // === borra todo lo que hay en la sesión ===
            sesion.invalidate();
            // === redireccionar | hacia el login.jsp | para volvernos a loguear ===
            response.sendRedirect("login.jsp");
        %>
    </body>
</html>

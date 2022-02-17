<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Borrar empleado</title>
    </head>
    <body>
        <!-- ================== -->
        <!-- === conectar bbdd  === -->
        <!-- ================== -->
        <%
            Connection con = null;
            Statement st = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost/bd_jsp?user=root&password=");
                st = con.createStatement();
                st.executeUpdate("DELETE FROM empleados WHERE id = ' "+request.getParameter("id")+ " '; ");
                request.getRequestDispatcher("index.jsp").forward(request, response);
            } catch (Exception e) {
                out.print(e);
            }
        %>
    </body>
</html>

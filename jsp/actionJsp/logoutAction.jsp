<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.DriverManager" %> 
<%@ page import="java.sql.Connection" %> 

<%
    //로그아웃 기능을 수행해주는 Action형 jsp

    //db 연결
    request.setCharacterEncoding("UTF-8");
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/calendar","stageus","1234");

    //모든 세션 삭제
    session.invalidate();
%>

<html>
    <script>
        localStorage.clear()
        location.href = '../pageJsp/loginPage.jsp'
    </script>
</html>
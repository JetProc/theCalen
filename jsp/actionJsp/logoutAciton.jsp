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
        //login.jsp가 아닌 home.jsp로 보내는 이유는 home.jsp에서 세션 유무를 판단한 후 로그인 여부에 따라 다시 페이지를 이동시키기 때문
        location.href = '../pageJsp/homePage.jsp'
    </script>
</html>
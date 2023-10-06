<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.DriverManager" %> 
<%@ page import="java.sql.Connection" %> 
<%@ page import="java.sql.PreparedStatement" %> 

<%
    //계정 삭제 Action형 jsp

    //db 연결
    request.setCharacterEncoding("UTF-8");
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/calendar","stageus","1234");

    //세션 가져오기
    String userSessionIdx = (String)session.getAttribute("idx");

    String deleteAccountSQL = "DELETE FROM user WHERE idx=?;";

    PreparedStatement query4 = connect.prepareStatement(deleteAccountSQL);

    query4.setString(1, userSessionIdx);

    query4.executeUpdate();

    //세션 삭제
    session.invalidate();
%>

<html>
    <script>
        localStorage.clear()
        alert('성공적으로 탈퇴하었습니다.')
        location.href = "../pageJsp/homePage.jsp"
    </script>
</html>
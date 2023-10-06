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
    String sIdxInput = request.getParameter("sIdxValue");

    String deleteScheduleSQL = "DELETE FROM schedule WHERE idx=?;";

    PreparedStatement query = connect.prepareStatement(deleteScheduleSQL);

    query.setString(1, sIdxInput);

    query.executeUpdate();

%>

<html>
    <script>
        let currentYear = localStorage.getItem('currentYear')
        let currentMonth = localStorage.getItem('currentMonth')
        location.href = `../pageJsp/homePage.jsp?currentYear=` + currentYear + `&currentMonth=` + currentMonth    </script>
</html>
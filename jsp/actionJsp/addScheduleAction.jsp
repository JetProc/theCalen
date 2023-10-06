<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.DriverManager" %> 
<%@ page import="java.sql.Connection" %> 
<%@ page import="java.sql.PreparedStatement" %> 
<%@ page import="java.sql.ResultSet" %> 

<%
    //일정 추가 Aciton형 jsp

    //db 연결
    request.setCharacterEncoding("UTF-8");
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/calendar","stageus","1234");

    //세션 가져오기
    String userSessionIdx = (String)session.getAttribute("idx");

    //request 정보 받아오기
    String scheduleContentsInput = request.getParameter("scheduleContentsInput");
    String scheduleDateInput = request.getParameter("localStorageDate");
    String scheduleTimeInput = request.getParameter("scheduleTimeInput");
    String scheduleTimeStamp = scheduleDateInput+" "+scheduleTimeInput+":00";
    
    String insertScheduleInfoSQL = "INSERT INTO schedule (user_idx,date,content) VALUES(?,?,?)";
    PreparedStatement query = connect.prepareStatement(insertScheduleInfoSQL); 

    query.setString(1, userSessionIdx);
    query.setString(2, scheduleTimeStamp);
    query.setString(3, scheduleContentsInput);
    query.executeUpdate();
%>

<html>
    <script>
        let currentYear = localStorage.getItem('currentYear')
        let currentMonth = localStorage.getItem('currentMonth')
        location.href = `../pageJsp/homePage.jsp?currentYear=` + currentYear + `&currentMonth=` + currentMonth
    </script>
</html>
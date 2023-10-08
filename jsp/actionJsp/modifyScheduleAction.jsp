3<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.DriverManager" %> 
<%@ page import="java.sql.Connection" %> 
<%@ page import="java.sql.PreparedStatement" %> 
<%@ page import="java.sql.ResultSet" %> 

<%
    //일정 수정 Aciton형 jsp

    //db 연결
    request.setCharacterEncoding("UTF-8");
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/calendar","stageus","1234");

    boolean isSameIdx = true;
    //세션 가져오기
    String userSessionIdx = (String)session.getAttribute("idx");

    //request 정보 받아오기
    String scheduleContentsInput = request.getParameter("scheduleContentsInput");
    String scheduleDateInput = request.getParameter("localStorageDate");
    String scheduleTimeInput = request.getParameter("scheduleTimeInput");
    String sIdxInput = request.getParameter("sIdxValue");
    String scheduleTimeStamp = scheduleDateInput+" "+scheduleTimeInput+":00";
    String uIdxInput = request.getParameter("uIdxValue");
    
    if(uIdxInput.equals("0")){  //본인 일정이라면
        String insertScheduleInfoSQL = "UPDATE schedule SET user_idx=?, date=?, content=? WHERE idx=?";
        PreparedStatement query = connect.prepareStatement(insertScheduleInfoSQL); 

        query.setString(1, userSessionIdx);
        query.setString(2, scheduleTimeStamp);
        query.setString(3, scheduleContentsInput);
        query.setString(4, sIdxInput);
        query.executeUpdate();
    }else isSameIdx = false;

%>

<html>
    <script>
        if(!<%=isSameIdx%>){
            alert("본인의 일정만 수정할 수 있습니다.")
        }
        let currentYear = localStorage.getItem('currentYear')
        let currentMonth = localStorage.getItem('currentMonth')
        location.href = `../pageJsp/homePage.jsp?currentYear=` + currentYear + `&currentMonth=` + currentMonth
    </script>
</html>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.DriverManager" %> 
<%@ page import="java.sql.Connection" %> 
<%@ page import="java.sql.PreparedStatement" %> 

<%
    //일정 삭제 Action형 jsp

    //db 연결
    request.setCharacterEncoding("UTF-8");
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/calendar","stageus","1234");

    boolean isSameIdx = true;

    //세션 가져오기
    String userSessionIdx = (String)session.getAttribute("idx");
    String uIdxInput = request.getParameter("uIdxValue");
    String sIdxInput = request.getParameter("sIdxValue");

    if(uIdxInput.equals("0")){  //본인 일정이라면
        String deleteScheduleSQL = "DELETE FROM schedule WHERE idx=?;"; //AND 문으로 user_idx가 현재 로그인된 유저 idx와 같을 때에만 DELETE
        PreparedStatement query = connect.prepareStatement(deleteScheduleSQL);
        query.setString(1, sIdxInput);
        query.executeUpdate();
    }else isSameIdx = false;

 
%>

<html>
    <script>
        if(!<%=isSameIdx%>){
            alert("본인의 일정만 삭제할 수 있습니다.")
        }
        let currentYear = localStorage.getItem('currentYear')
        let currentMonth = localStorage.getItem('currentMonth')
        location.href = `../pageJsp/homePage.jsp?currentYear=` + currentYear + `&currentMonth=` + currentMonth
    </script>  
</html>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.DriverManager" %> 
<%@ page import="java.sql.Connection" %> 
<%@ page import="java.sql.PreparedStatement" %> 
<%@ page import="java.sql.ResultSet" %> 
<%@ page import="java.util.ArrayList" %>

<%
    //db 연결
    request.setCharacterEncoding("UTF-8");
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/calendar","stageus","1234");

    ArrayList showedMemberIdxList = new ArrayList<String>();
    
    if(request.getParameterValues("members")!=null){
        for(int i=0; i<request.getParameterValues("members").length; i++){
            showedMemberIdxList.add((String)request.getParameterValues("members")[i]);
        }
        session.setAttribute("showedMemberIdxList",showedMemberIdxList);
    }else{
        session.setAttribute("showedMemberIdxList","");
    }
%>

<html>
    <script>
        let currentYear = localStorage.getItem('currentYear')
        let currentMonth = localStorage.getItem('currentMonth')
        location.href = `../pageJsp/homePage.jsp?currentYear=` + currentYear + `&currentMonth=` + currentMonth
    </script>
</html>
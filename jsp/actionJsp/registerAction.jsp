<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.DriverManager" %> 
<%@ page import="java.sql.Connection" %> 
<%@ page import="java.sql.PreparedStatement" %> 
<%@ page import="java.sql.ResultSet" %> 

<%
    //회원가입 Action형 jsp

    //db 연결
    request.setCharacterEncoding("UTF-8");
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/calendar","stageus","1234");

    //request 정보 받아오기
    String idInput = request.getParameter("id");
    String pwInput = request.getParameter("pw");
    String nameInput = request.getParameter("name");
    String phonenumInput = request.getParameter("phonenum");
    String _teamInput = request.getParameter("team");
    String _positionInput = request.getParameter("position");

    //id 중복을 검사하기 위한 id 검색문
    String selectIdSQL = "SELECT * FROM user WHERE id=?";
    PreparedStatement query1 = connect.prepareStatement(selectIdSQL);
    query1.setString(1, idInput);
    ResultSet rs = query1.executeQuery();
    boolean isRegister = true;

    int temp = 10;

    if(rs.next()){  //중복 id가 있다면
        isRegister = false;
    }else {
      int teamInput = -1;
      if(_teamInput.equals("developTeam")) teamInput = 0;
      else if(_teamInput.equals("planningTeam")) teamInput = 1;
      else if (_teamInput.equals("designTeam")) teamInput = 2;

      int positionInput = -1;
      if (_positionInput.equals("teamLeader")) positionInput = 0;
      else if (_positionInput.equals("teamMember")) positionInput = 1;

      //새로 계정 생성하는 SQL문
      String insertUserInfoSQL = "INSERT INTO user (id,password,name,phonenum,team,position) VALUES(?,?,?,?,?,?);";
      PreparedStatement query2 = connect.prepareStatement(insertUserInfoSQL); 

      query2.setString(1, idInput);
      query2.setString(2, pwInput);
      query2.setString(3, nameInput);
      query2.setString(4, phonenumInput);
      query2.setInt(5, teamInput);
      query2.setInt(6, positionInput);

      query2.executeUpdate(); 
    }
%>

<html>
    <script>
        let isRegister = <%=isRegister%>
        if(isRegister){
            location.href="../pageJsp/loginPage.jsp"
        }else {
            alert('id가 중복입니다.')
            history.back()
        }
    </script>
</html>
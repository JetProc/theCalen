<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.DriverManager" %> 
<%@ page import="java.sql.Connection" %> 
<%@ page import="java.sql.PreparedStatement" %> 
<%@ page import="java.sql.ResultSet" %> 

<%
    //db 연결
    request.setCharacterEncoding("UTF-8");
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/calendar","stageus","1234");

    //세션 가져오기
    String userSessionIdx = (String)session.getAttribute("idx");

    //request 정보 받아오기
    String idInput = request.getParameter("id");
    String pwInput = request.getParameter("pw");
    String nameInput = request.getParameter("name");
    String phonenumInput = request.getParameter("phonenum");
    String _teamInput = request.getParameter("team");
    String _positionInput = request.getParameter("position");

    //id 중복을 검사하기 위한 id 검색문
    String selectIdSQL = "SELECT * FROM user WHERE id=? AND NOT idx=?";
    PreparedStatement query1 = connect.prepareStatement(selectIdSQL);
    query1.setString(1, idInput);
    query1.setString(2, userSessionIdx);
    ResultSet rs1 = query1.executeQuery();
    boolean isIdExist = false;

    //phonenum 중복을 검사하기 위한 phonenum 검색문
    String selectPhonenumSQL = "SELECT * FROM user WHERE phonenum=? AND NOT idx=?";
    PreparedStatement query2 = connect.prepareStatement(selectPhonenumSQL);
    query2.setString(1, phonenumInput);
    query2.setString(2, userSessionIdx);
    ResultSet rs2 = query2.executeQuery();
    boolean isPhonenumExist = false;

    if(rs1.next()){
        //중복 id가 있다면 실행
        isIdExist = true;
    }else if(rs2.next()){
        //중복 phonenum이 있다면 실행
        isPhonenumExist = true;
    }else {
        //수정 가능
    
        //문자열 _teamInput을 정수로 변환
        int teamInput = -1;
        if(_teamInput.equals("developTeam")) teamInput = 0;
        else if(_teamInput.equals("planningTeam")) teamInput = 1;
        else if (_teamInput.equals("designTeam")) teamInput = 2;


        //문자열 _positionInput을 정수로 변환
        int positionInput = -1;
        if (_positionInput.equals("teamLeader")) positionInput = 0;
        else if (_positionInput.equals("teamMember")) positionInput = 1;

        //유저 정보 업데이트하는 쿼리문
        String updateUserInfoSQL = "UPDATE user SET id=?, password=?, name=?, phonenum=?, team=?, position=? where idx=?";
        PreparedStatement query3 = connect.prepareStatement(updateUserInfoSQL); 

        query3.setString(1, idInput);
        query3.setString(2, pwInput);
        query3.setString(3, nameInput);
        query3.setString(4, phonenumInput);
        query3.setInt(5, teamInput);
        query3.setInt(6, positionInput);
        query3.setString(7, userSessionIdx);

        query3.executeUpdate(); 

        session.setAttribute("id", idInput);
        session.setAttribute("password", pwInput);
        session.setAttribute("name", nameInput);
        session.setAttribute("phonenum", phonenumInput);
        session.setAttribute("team", Integer.toString(teamInput));
        session.setAttribute("position", Integer.toString(positionInput));
    }
%>

<html>
    <script>
        let isIdExist = <%=isIdExist%>
        let isPhonenumExist = <%=isPhonenumExist%>

        if(isIdExist){
            alert('id가 중복입니다.')
            history.back()
        }else if(isPhonenumExist){
            alert('전화번호가 중복입니다.')
            history.back()
        }else{
            localStorage.setItem("name", "<%=nameInput%>")    //JS파일에서 단순히 유저 이름을 가져오기 위해 일방적으로 저장
            location.href = "../pageJsp/myPage.jsp"
            alert('변경사항이 저장되었습니다.')
        }
    </script>
</html>
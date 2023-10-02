<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.DriverManager" %> 
<%@ page import="java.sql.Connection" %> 
<%@ page import="java.sql.PreparedStatement" %> 
<%@ page import="java.sql.ResultSet" %>

<%
    //id, pw 찾는 Action형 jsp

    //db 연결
    request.setCharacterEncoding("UTF-8");
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/calendar","stageus","1234");

    //request 정보 받아오기
    String nameInput = request.getParameter("name");
    String phonenumInput = request.getParameter("phonenum");
    String idInput = request.getParameter("id");

    String findSQL = "";
    String userId = "";
    String userPw = "";
    ResultSet rs = null;
    PreparedStatement query = null;

    if(idInput == null){    //id 파라미터를 전달 받지 못한 경우 (=id찾기일 경우)
        findSQL = "SELECT id FROM user WHERE name=? AND phonenum=?";   //id 찾기 쿼리문
        query = connect.prepareStatement(findSQL);
        query.setString(1, nameInput);
        query.setString(2, phonenumInput);
        rs = query.executeQuery();

        if(rs.next()) userId = rs.getString(1);
        
    }else {     //pw 찾기
        findSQL = "SELECT password FROM user WHERE id=? AND name=? AND phonenum=?";  //pw 찾기 쿼리문
        query = connect.prepareStatement(findSQL);
        query.setString(1, idInput);
        query.setString(2, nameInput);
        query.setString(3, phonenumInput);
        rs = query.executeQuery();

        if(rs.next()) userPw = rs.getString(1);
    }
%>

<html>
   <script>
        let id = "<%=userId%>"
        let pw = "<%=userPw%>"
        if(!id && !pw) {    //id와 pw가 둘 다 없다면 (=계정 정보가 없다면)
            alert('입력하신 정보에 대한 정보가 존재하지 않습니다.')
            history.back()
        }else if(id){   //id만 있다면 (=id찾기)
            alert('찾으려는 id는 [ ' + id + ' ] 입니다.')
            history.back()
        }
        if(pw){ //pw가 있다면 (pw찾기)
            alert('찾으려는 비밀번호는 [ ' + pw + ' ] 입니다.')
            history.back()
        }
    </script>
</html>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.DriverManager" %> 
<%@ page import="java.sql.Connection" %> 
<%@ page import="java.sql.PreparedStatement" %> 
<%@ page import="java.sql.ResultSet" %> 

<%
    //로그인 과정을 수행하는 Aciton형 jsp

    //db 연결
    request.setCharacterEncoding("UTF-8");
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/calendar","stageus","1234");

    //request 정보 받아오기
    String idInput = request.getParameter("id");
    String pwInput = request.getParameter("pw");

    //id와 pw가 일치하는 계정이 있는지 찾는 쿼리문
    String selectIdAndPwSQL = "SELECT * FROM user WHERE id=? AND password=?";
    PreparedStatement query = connect.prepareStatement(selectIdAndPwSQL);
    query.setString(1, idInput);
    query.setString(2, pwInput);
    ResultSet rs = query.executeQuery();
    
    //밑의 Script tag 에서 사용하기 위해 전역변수로 선언
    String name = "";

    //rs에 값이 있다면 실행 (=일치하는 id,pw가 존재한다면 실행 = 로그인에 성공했다면)
    if(rs.next()){
        String idx = rs.getString(1);
        String id = rs.getString(2);
        String password = rs.getString(3);
        name = rs.getString(4);
        String phonenum = rs.getString(5);
        String team = rs.getString(6);
        String position = rs.getString(7);

        session.setAttribute("idx", idx);
        session.setAttribute("id", id);
        session.setAttribute("password", password);
        session.setAttribute("name", name);
        session.setAttribute("phonenum", phonenum);
        session.setAttribute("team", team);
        session.setAttribute("position", position);
    }
%>


<html>
    <body>
    hi
    </body>
    <script>
        let name = "<%=name%>"
        //name 변수가 비어있다면 (=일치하는 계정이 없다면)
        if(!name){
            alert('id나 비밀번호를 다시 확인해주세요.')
            history.back()
        }else {
            localStorage.setItem("currentPage", 'homePage')
            localStorage.setItem("name", name)  //HomaPage에서 id를 보여주기 위한 일방적인 저장
            localStorage.setItem('currentMonth', new Date().getMonth())
            localStorage.setItem('currentYear', new Date().getFullYear())
            location.href="../pageJsp/homePage.jsp"
        }
    </script>
</html>
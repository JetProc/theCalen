<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.DriverManager" %> 
<%@ page import="java.sql.Connection" %> 
<%@ page import="java.sql.PreparedStatement" %> 
<%@ page import="java.sql.ResultSet" %> 
<%@ page import="java.util.ArrayList" %>

<%
    //db 찾기
    request.setCharacterEncoding("UTF-8");
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/web","stageus","1234");
    
    //세션 가져오기
    String userSessionIdx = (String)session.getAttribute("idx");
    boolean isLogin = true;
    if(userSessionIdx==null) isLogin = false;
    else{

    }
%>

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>The Calen</title>
    <link rel="stylesheet" href="../../css/myPage.css" />
    <link rel="stylesheet" href="../../css/common.css" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(function () {
        $('#navBar').load('../../html/navBar.html')
        })
    </script>
</head>
<body>
    <nav id="navBar"></nav>
    <main id="mainContainer">
        <form action="" id="contentsContainer">
        <h3 id="mypageText">마이페이지</h3>
        <article id="inputContainer">
            <input type="text" placeholder="아이디" class="inputBox" name="id" required autofocus />
            <input type="password" placeholder="비밀번호" class="inputBox" name="pw" required />
            <input type="password" placeholder="비밀번호 확인" class="inputBox" name="confirmPw" required />
            <input type="text" placeholder="이름" class="inputBox" name="name" required />
            <input type="tel" placeholder="핸드폰 번호" class="inputBox" name="phonenum" required />
            <h4 id="teamText">부서</h4>
            <div id="teamInputContainer">
            <input
                type="radio"
                id="developTeam"
                class="teamInput"
                name="team"
                value="developTeam"
                required
                checked="checked"
            />
            <label for="developTeam" class="teamInputLabel">개발팀</label>
            <input type="radio" id="planningTeam" class="teamInput" name="team" value="planningTeam" required />
            <label for="planningTeam" class="teamInputLabel">기획팀</label>
            <input type="radio" id="designTeam" class="teamInput" name="team" value="designTeam" required />
            <label for="designTeam" class="teamInputLabel">디자인팀</label>
            </div>
            <h4 id="positionText">직급</h4>
            <div id="positionInputContainer">
            <input type="radio" id="teamLeader" class="positionInput" name="position" value="teamLeader" required />
            <label for="teamLeader" class="positionInputLabel">팀장</label>
            <input
                type="radio"
                id="teamMember"
                class="positionInput"
                name="position"
                value="teamMemeber"
                required
                checked="checked"
            />
            <label for="teamMember" class="positionInputLabel">팀원</label>
            </div>
        </article>
        <input type="submit" value="수정" id="modifyBtn" />
        <a href="./homePage.jsp" id="goBackBtn" class="additionalText">캘린더 페이지로 이동</a>
        </form>
    </main>
    <script>
        if(!<%=isLogin%>) location.href = "./loginPage.jsp"
    </script>
</body>

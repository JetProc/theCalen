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
    String userSessionId = "";
    String userSessionPw = "";
    String userSessionName = "";
    String userSessionPhonenum = "";
    String userSessionTeam = "";
    String userSessionPosition = "";

    boolean isLogin = true;
    if(userSessionIdx==null) isLogin = false;
    else{
        userSessionId = (String)session.getAttribute("id");
        userSessionPw = (String)session.getAttribute("password");
        userSessionName = (String)session.getAttribute("name");
        userSessionPhonenum = (String)session.getAttribute("phonenum");
        userSessionTeam = (String)session.getAttribute("team");
        userSessionPosition = (String)session.getAttribute("position");
    }
%>

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>The Calen</title>
    <link rel="stylesheet" href="../../css/common.css" />
    <link rel="stylesheet" href="../../css/myPage.css" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(function () {
           $('#navBar').load('../../html/navBar.html')
        })
        function checkDeleteAccountEvent() {
            if (confirm('정말로 탈퇴 하시겠습니까?')) location.href = '../actionJsp/deleteAccountAction.jsp'
        }
    </script>
</head>
<body onload="autoHypenOnloading()">
    <nav id="navBar"></nav>
    <main id="mainContainer">
        <form action="../actionJsp/modifyAccountAction.jsp" id="contentsContainer" onsubmit="return checkRegisterValidEvent(event)">
        <h3 id="mypageText">마이페이지</h3>
        <article id="inputContainer">
            <input type="text" placeholder="아이디 입력(4~12자)" class="inputBox" name="id" value=<%=userSessionId%> required />
            <input type="password" placeholder="비밀번호 입력(영문, 숫자, 특수문자를 포함한 6~20자)" class="inputBox" name="pw" required />
            <input type="password" placeholder="비밀번호 확인" class="inputBox" name="confirmPw" required />
            <input type="text" placeholder="이름" class="inputBox" name="name" value=<%=userSessionName%> required />
            <input type="tel" placeholder="핸드폰 번호('-' 없이 숫자만 입력)" maxlength="13" class="inputBox" id="phonenum" name="phonenum" oninput="autoHyphen(this)" value=<%=userSessionPhonenum%> required />
            <h4 id="teamText">부서</h4>
            <div id="teamInputContainer">
            <input
                type="radio"
                id="developTeam"
                class="teamInput"
                id="developTeam"
                name="team"
                value="developTeam"
                required
                checked="checked"
            />
            <label for="developTeam" class="teamInputLabel">개발팀</label>
            <input type="radio" id="planningTeam" class="teamInput" id="planningTeam" name="team" value="planningTeam" required />
            <label for="planningTeam" class="teamInputLabel">기획팀</label>
            <input type="radio" id="designTeam" class="teamInput" id="designTeam" name="team" value="designTeam" required />
            <label for="designTeam" class="teamInputLabel">디자인팀</label>
            </div>
            <h4 id="positionText">직급</h4>
            <div id="positionInputContainer">
            <input type="radio" id="teamLeader" class="positionInput" name="position" value="teamLeader" required />
            <label for="teamLeader" class="positionInputLabel">팀장</label>
            <input
                type="radio"
                class="positionInput"
                id="teamMember"
                name="position"
                value="teamMember"
                required
            />
            <label for="teamMember" class="positionInputLabel">팀원</label>
            </div>
        </article>
        <input type="submit" value="수정" id="modifyBtn" />
        <p onclick="checkDeleteAccountEvent()" id="deleteAccountBtn" class="additionalText">탈퇴하기</p>
        <p id="goBackBtn" class="additionalText" onclick="moveToCalendarEvent()">캘린더 페이지로 이동</p>
        </form>
    </main>
    <script src="../../js/checkValid.js"></script>
    <script>

        if(!<%=isLogin%>) {
            location.href = "./loginPage.jsp"
        }
        else{
            let userSessionTeam = "<%=userSessionTeam%>"
            let userSessionPosition = "<%=userSessionPosition%>"

            let team = document.getElementById('developTeam')   //기본값 개발팀
            if(userSessionTeam=="1") team = document.getElementById('planningTeam')
            else if(userSessionTeam=="2") team = document.getElementById('designTeam')
            team.checked = "checked"

            let position = document.getElementById('teamMember');   //기본값 팀원
            if(userSessionPosition=="0") position = document.getElementById('teamLeader')
            position.checked = "checked"
        }
    </script>
</body>

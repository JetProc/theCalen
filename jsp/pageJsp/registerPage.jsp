<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>


<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>The Calen</title>
  <link rel="stylesheet" href="../../css/registerPage.css" />
  <link rel="stylesheet" href="../../css/common.css" />
  <script src="../../js/checkValid.js"></script>
</head>
<body>
  <div id="introductionContainer">
    <h1 id="title">The<br />Calen</h1>
    <img src="../../src/pictures/loginPicture.svg" alt="The Calen Picture" id="picture" />
  </div>
  <main id="mainContainer">
    <form action="../actionJsp/registerAction.jsp" id="contentsContainer" onsubmit="return checkRegisterValidEvent(event)">
      <h3 id="registerText">회원가입</h3>
      <article id="inputContainer">
        <input type="text" placeholder="아이디 입력(4~12자)" class="inputBox" id="id" name="id" required autofocus />
        <input type="password" placeholder="비밀번호 입력(영문, 숫자, 특수문자를 포함한 6~20자)" class="inputBox" id="pw" name="pw" required />
        <input type="password" placeholder="비밀번호 확인" class="inputBox" id="confirmPw" name="confirmPw" required />
        <input type="text" placeholder="이름" class="inputBox" id="name" name="name" required />
        <input type="tel" placeholder="핸드폰 번호('-' 없이 숫자만 입력)" maxlength="13" class="inputBox" id="phonenum" name="phonenum" required oninput="autoHyphen(this)" />
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
      <input type="submit" value="회원가입" id="registerBtn" />
      <a href="./loginPage.jsp" id="goBackBtn" class="additionalText">뒤로가기</a>
    </form>
  </main>
</body>

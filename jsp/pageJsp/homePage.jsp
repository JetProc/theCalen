<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.DriverManager" %> 
<%@ page import="java.sql.Connection" %> 
<%@ page import="java.sql.PreparedStatement" %> 
<%@ page import="java.sql.ResultSet" %> 
<%@ page import="java.util.ArrayList" %>

<%
    //메인 화면 보여주는 page형 jsp
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
  <link rel="stylesheet" href="../../css/homePage.css" />
  <link rel="stylesheet" href="../../css/common.css" />
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script>
    // $(function () {
    //   $('#modalContainer').load('../../html/scheduleList.html')
    // })
    // $(function () {
    //   $('#modalContainer').load('../../html/scheduleInputModal.html')
    // })
    $(function () {
      $('#modalContainer').load('../../html/scheduleModifyModal.html')
    })
    $(function () {
      $('#navBar').load('../../html/navBar.html')
    })
  </script>
</head>
<body>
  <nav id="navBar"></nav>
  <main id="mainContainer">
    <section id="yearAndMonthContainer">
      <div id="goPrevMonthBtn" class="goOtherMonthBtn"></div>
      <p id="yearAndMonthText">2023년 9월</p>
      <div id="goNextMonthBtn" class="goOtherMonthBtn"></div>
    </section>
    <section id="calendarContainer">
        <section id="modalContainer"></section>
    </section>
  </main>
  <script src="../../js/calender.js"></script>
  <script>
    if(!<%=isLogin%>) location.href = "./loginPage.jsp"
  </script>
</body>

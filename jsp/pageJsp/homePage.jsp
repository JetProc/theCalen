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
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/calendar","stageus","1234");
    
    //세션 가져오기
    String userSessionIdx = (String)session.getAttribute("idx");

    String userSessionTeam = "";
    String userSessionPosition = "";

    boolean isLogin = true;
    if(userSessionIdx==null) isLogin = false;
    else{
        userSessionTeam = (String)session.getAttribute("team");
        userSessionPosition = (String)session.getAttribute("position");

        String selectSchedule = "SELECT date, content FROM schedule JOIN user ON user.idx=schedule.user_idx WHERE user.idx=?";
        PreparedStatement query = connect.prepareStatement(selectSchedule);
        query.setString(1, userSessionIdx);
        ResultSet rs = query.executeQuery();

        rs.next();

        if(userSessionPosition=="0"){        //만약 팀장이라면
        //쿼리문 하나 더 써서 팀원들 일정까지 싹 불러오기

        }else if(userSessionPosition=="1"){          //만약 팀원이라면
        

        }
    }
%>

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>The Calen</title>
  <link rel="stylesheet" href="../../css/common.css" />
  <link rel="stylesheet" href="../../css/homePage.css" />

  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script>
    $(function () {
      $('#navBar').load('../../html/navBar.html')
    })
  </script>
</head>
<body>
  <nav id="navBar"></nav>
  <section id="modalContainerBackground"></section>
  <main id="mainContainer">
    <section id="yearAndMonthContainer">
      <div id="goPrevMonthBtn" class="goOtherMonthBtn" onclick="goOtherMonthEvent(-1)"></div>
      <p id="yearAndMonthText">2023년 9월</p>
      <div id="goNextMonthBtn" class="goOtherMonthBtn" onclick="goOtherMonthEvent(1)"></div>
    </section>
    <section id="calendarContainer"></section>
  </main>
  <script src="../../js/modal.js"></script>
  <script>
    if(!<%=isLogin%>) location.href = "./loginPage.jsp"

    // 각 달의 마지막 날 구해서 리스트에 저장
    let currentYear = localStorage.getItem('currentYear')
    let currentMonth = localStorage.getItem('currentMonth')
    let lastDay = new Date(currentYear, currentMonth,0).getDate()
    
    let yearAndMonthText = document.getElementById('yearAndMonthText')
    yearAndMonthText.innerText = currentYear+'년 '+currentMonth+'월'

    function goOtherMonthEvent(num){
        let otherMonth = Number(currentMonth)+Number(num)
        if(otherMonth>12){
            otherMonth = 1
            currentYear = Number(currentYear)+Number(1)
        }
        if(otherMonth<1){
            otherMonth = 12
            currentYear = Number(currentYear)-Number(1)
        }
        localStorage.setItem('currentYear',currentYear)
        localStorage.setItem('currentMonth',otherMonth)
        location.reload()
    }









    //캘린더 그리는 함수
    function renderCalendar() {
    let calendarContainer = document.getElementById('calendarContainer')
    calendarContainer.innerHTML = ''
    for (let i = 0; i < 5; i++) {
        let week = document.createElement('div')
        week.className = 'week'

        for (let j = 1; j <= 7; j++) {
        let date = document.createElement('div')
        date.className = 'date'


        let dateNumber = document.createElement('div')
        dateNumber.className = 'dateNumber'
        dateNumber.innerText = 7 * i + j
        date.appendChild(dateNumber)

        let hiddenText = document.createElement('div')
        hiddenText.className = 'hiddenText'
        hiddenText.innerText = '눌러서 일정 추가'
        date.appendChild(hiddenText)

        for (let i = 0; i < 3; i++) {
            let scheduleContainer = document.createElement('div')
            scheduleContainer.className = 'scheduleContainer'
            let scheduleName = document.createElement('div')
            scheduleName.className = 'scheduleName'
            scheduleName.innerText = '강아지 밥 주기'
            scheduleContainer.appendChild(scheduleName)

            let scheduleTime = document.createElement('div')
            scheduleTime.className = 'scheduleTime'
            scheduleTime.innerText = '09:00'
            scheduleContainer.appendChild(scheduleTime)
            date.appendChild(scheduleContainer)
        }
        week.appendChild(date)
        if (7 * i + j >= lastDay) {
            calendarContainer.appendChild(week)
            return 0
        }
        }
        calendarContainer.appendChild(week)
    }
    }
    renderCalendar()
    $(document).ready(function () {
        $('.date').click(function (event) {
            event.stopPropagation();
            modalContainerBackground.style.display = 'flex'

            modalContainer1.style.display = 'none'
            modalContainer2.style.display = 'flex'
            modalContainer3.style.display = 'none'
        })
        $('.scheduleContainer').click(function (event) {
            event.stopPropagation();
            modalContainerBackground.style.display = 'flex'

            modalContainer1.style.display = 'none'
            modalContainer2.style.display = 'none'
            modalContainer3.style.display = 'flex'
        })
    })

  </script>
</body>

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

    String currentYear = request.getParameter("currentYear");
    String currentMonth = request.getParameter("currentMonth");

    String userSessionTeam = "";
    String userSessionPosition = "";

    ArrayList yearList = new ArrayList<String>();
    ArrayList monthList = new ArrayList<String>();
    ArrayList dayList = new ArrayList<String>();
    ArrayList timeHourList = new ArrayList<String>();
    ArrayList timeMinuteList = new ArrayList<String>();
    ArrayList contentList = new ArrayList<String>();

    ArrayList<ArrayList<String>> scheduleInfoList = new ArrayList<>();

    boolean isLogin = true;
    if(userSessionIdx==null) isLogin = false;
    else{
        userSessionTeam = (String)session.getAttribute("team");
        userSessionPosition = (String)session.getAttribute("position");

        String selectMySchedule = "SELECT date, content FROM schedule JOIN user ON user.idx=schedule.user_idx WHERE user.idx=? AND YEAR(date) in (?) AND MONTH(date) IN (?);";
        PreparedStatement query = connect.prepareStatement(selectMySchedule);
        query.setString(1, userSessionIdx);
        query.setString(2, currentYear);
        query.setString(3, currentMonth);
        ResultSet rs = query.executeQuery();

        if(rs.next()){
            do{
                String _date = "\""+rs.getString("date")+"\"";
                String content = "\""+rs.getString("content")+"\"";

                yearList.add(_date.substring(0,5)+"\"");
                monthList.add("\""+_date.substring(6,8)+"\"");
                dayList.add("\""+_date.substring(9,11)+"\"");
                timeHourList.add("\""+_date.substring(12,14)+"\"");
                timeMinuteList.add("\""+_date.substring(15,17)+"\"");
                contentList.add(content);
            }while(rs.next());
            scheduleInfoList.add(yearList);
            scheduleInfoList.add(monthList);
            scheduleInfoList.add(dayList);
            scheduleInfoList.add(timeHourList);
            scheduleInfoList.add(timeMinuteList);
            scheduleInfoList.add(contentList);
        }




        

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
      <p id="yearAndMonthText"></p>
      <div id="goNextMonthBtn" class="goOtherMonthBtn" onclick="goOtherMonthEvent(1)"></div>
    </section>
    <section id="calendarContainer"></section>
  </main>
  <script src="../../js/modal.js"></script>
  <script>
    if(!<%=isLogin%>) location.href = "./loginPage.jsp"
    
    //test

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
        localStorage.setItem('currentMonth',otherMonth.toString().length < 2 ? '0' + otherMonth : otherMonth)
        location.href=`../pageJsp/homePage.jsp?currentYear=`+currentYear+`&currentMonth=`+otherMonth
    }


    //캘린더 그리는 함수
    function renderCalendar() {

        let scheduleInfoList = <%=scheduleInfoList%>
        console.log(scheduleInfoList)

        let calendarContainer = document.getElementById('calendarContainer')
        calendarContainer.innerHTML = ''
        for (let i = 0; i < 5; i++) {
            let week = document.createElement('div')
            week.className = 'week'

            for (let j = 1; j <= 7; j++) {

                let loopDateNum = (7 * i + j)

                let date = document.createElement('div')
                date.classList.add('date', 'date'+loopDateNum)
                date.id = loopDateNum
                if (currentYear == new Date().getFullYear() && currentMonth == new Date().getMonth()+ 1 && 7*i+j == new Date().getDate()){
                    date.classList.add('currentDate')
                }

                let dateNumber = document.createElement('div')
                dateNumber.classList.add('dateNumber', 'date'+loopDateNum)
                dateNumber.innerText =loopDateNum
                date.appendChild(dateNumber)

                let hiddenText = document.createElement('div')
                hiddenText.classList.add('hiddenText', 'date'+loopDateNum)
                hiddenText.innerText = '눌러서 일정 추가'
                date.appendChild(hiddenText)

                if(scheduleInfoList.length>0){
                    for (let i = 0; i < scheduleInfoList[1].length; i++) {
                        if(scheduleInfoList[0][i]==currentYear 
                        && scheduleInfoList[1][i]==currentMonth 
                        && Number(scheduleInfoList[2][i])==date.id){
                            let scheduleContainer = document.createElement('div')
                            scheduleContainer.classList.add('scheduleContainer','date'+loopDateNum)
                            let scheduleName = document.createElement('div')
                            scheduleName.classList.add('scheduleName','date'+loopDateNum)
                            scheduleName.innerText = scheduleInfoList[5][i]
                            scheduleContainer.appendChild(scheduleName)

                            let scheduleTime = document.createElement('div')
                            scheduleTime.classList.add('scheduleTime','date'+loopDateNum)
                            scheduleTime.innerText = scheduleInfoList[3][i]+':'+scheduleInfoList[4][i]
                            scheduleContainer.appendChild(scheduleTime)
                            date.appendChild(scheduleContainer)
                        }
                    }
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
            let selectedDate = event.target.classList.item(1).substr(4)
            modalContainerBackground.style.display = 'flex'

            makeScheduleInputModal(selectedDate.length < 2 ? "0"+selectedDate : selectedDate)

        })
        $('.scheduleContainer').click(function (event) {
            event.stopPropagation();

            let selectedElementClassName = event.target.classList.item(0)
            let selectedDate = event.target.classList.item(1).substr(4)

            let contentValue=[]
            let dateValue=[]
            if(selectedElementClassName == 'scheduleContainer'){
                contentValue = event.target.firstChild.innerText
                dateValue = event.target.lastChild.innerText
            }else if(selectedElementClassName == 'scheduleTime'){
                contentValue = event.target.previousSibling.innerText
                dateValue = event.target.innerText
            }else if(selectedElementClassName == 'scheduleName'){
                contentValue = event.target.innerText
                dateValue = event.target.nextSibling.innerText
            }


            // let _contentList=document.getElementsByClassName('scheduleName '+event.target.classList.item(1))
            // let _dateList=document.getElementsByClassName('scheduleTime '+event.target.classList.item(1))



            // for(let i=0; i<_contentList.length; i++){
            //     contetnList.push(_contentList[i].innerText)
            //     dateList.push(_dateList[i].innerText)
            // }

            modalContainerBackground.style.display = 'flex'

            makeScheduleModifyModal(selectedDate.length < 2 ? "0"+selectedDate : selectedDate, contentValue, dateValue)
        })
    })

  </script>
</body>

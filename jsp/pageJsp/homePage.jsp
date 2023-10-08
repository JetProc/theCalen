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
            
    ArrayList teamMemberCheckedList = new ArrayList<String>();
    ArrayList teamMemberIdxList = new ArrayList<String>();
    ArrayList teamMemberNameList = new ArrayList<String>();


    ArrayList sIdxList = new ArrayList<String>();
    ArrayList yearList = new ArrayList<String>();
    ArrayList monthList = new ArrayList<String>();
    ArrayList dayList = new ArrayList<String>();
    ArrayList timeHourList = new ArrayList<String>();
    ArrayList timeMinuteList = new ArrayList<String>();
    ArrayList contentList = new ArrayList<String>();
    ArrayList nameList = new ArrayList<String>();
    ArrayList uIdxList = new ArrayList<String>();

    ArrayList<ArrayList<String>> scheduleInfoList = new ArrayList<>();

    String selectTeamMemberScheduleSQL = "";
    String selectTeamMemberSQL = "";
    String selectAllTeamMemberSQL = "";


    boolean isLogin = true;
    if(userSessionIdx==null) isLogin = false;
    else{
        userSessionTeam = (String)session.getAttribute("team");
        userSessionPosition = (String)session.getAttribute("position");

        String selectMyScheduleSQL = "SELECT schedule.idx, date, content FROM schedule JOIN user ON user.idx=schedule.user_idx WHERE user.idx=? AND YEAR(date) in (?) AND MONTH(date) IN (?) ORDER BY date, idx;";
        PreparedStatement query = connect.prepareStatement(selectMyScheduleSQL);
        query.setString(1, userSessionIdx);
        query.setString(2, currentYear);
        query.setString(3, currentMonth);
        ResultSet rs = query.executeQuery();

        if(rs.next()){
            do{
                String sIdx = "\""+rs.getString("idx")+"\"";
                String _date = "\""+rs.getString("date")+"\"";
                String content = "\""+rs.getString("content")+"\"";

                sIdxList.add(sIdx);

                yearList.add(_date.substring(0,5)+"\"");
                monthList.add("\""+_date.substring(6,8)+"\"");
                dayList.add("\""+_date.substring(9,11)+"\"");
                timeHourList.add("\""+_date.substring(12,14)+"\"");
                timeMinuteList.add("\""+_date.substring(15,17)+"\"");

                contentList.add(content);
                nameList.add("0");
                uIdxList.add("0");
            }while(rs.next());
        }

        if(userSessionPosition.equals("0")){        //만약 팀장이라면

            selectAllTeamMemberSQL = "SELECT idx, name from user WHERE team=? AND idx!=?;";
            PreparedStatement query2 = connect.prepareStatement(selectAllTeamMemberSQL);
            query2.setString(1,userSessionTeam);  
            query2.setString(2,userSessionIdx);  
            ResultSet rs2 = query2.executeQuery();

            while(rs2.next()){
                String uIdx = "\""+rs2.getString("idx")+"\"";
                String name = "\""+rs2.getString("name")+"\"";

                teamMemberIdxList.add(uIdx);
                teamMemberNameList.add(name);

            }

            
            if(session.getAttribute("showedMemberIdxList") != ""){
                teamMemberCheckedList = (ArrayList)session.getAttribute("showedMemberIdxList");
            }

            if(teamMemberCheckedList.size()>0){
                selectTeamMemberScheduleSQL = "SELECT schedule.idx, user.idx, name, content, date from schedule join user on user_idx = user.idx WHERE team=? AND user_idx IN (";

                for(int i=0; i < teamMemberCheckedList.size(); i++){
                    selectTeamMemberScheduleSQL += "?";
                    if(i<teamMemberCheckedList.size()-1) selectTeamMemberScheduleSQL += ",";
                }
                selectTeamMemberScheduleSQL += ");";

                PreparedStatement query1 = connect.prepareStatement(selectTeamMemberScheduleSQL);
                query1.setString(1, userSessionTeam);

                for (int i = 0; i < teamMemberCheckedList.size(); i++) {
                    query1.setString(i + 2, String.valueOf(teamMemberCheckedList.get(i)));
                }

                ResultSet rs1 = query1.executeQuery();

                while(rs1.next()){
                    String sIdx = "\""+rs1.getString("idx")+"\"";
                    String _date = "\""+rs1.getString("date")+"\"";
                    String content = "\""+rs1.getString("content")+"\"";
                    String name = "\""+rs1.getString("name")+"\"";
                    String uIdx = "\""+rs1.getString("user.idx")+"\"";

                    sIdxList.add(sIdx);

                    yearList.add(_date.substring(0,5)+"\"");
                    monthList.add("\""+_date.substring(6,8)+"\"");
                    dayList.add("\""+_date.substring(9,11)+"\"");
                    timeHourList.add("\""+_date.substring(12,14)+"\"");
                    timeMinuteList.add("\""+_date.substring(15,17)+"\"");

                    contentList.add(content);
                    nameList.add(name);
                    uIdxList.add(uIdx);
                }
                
            }

        }
        scheduleInfoList.add(yearList);
        scheduleInfoList.add(monthList);
        scheduleInfoList.add(dayList);
        scheduleInfoList.add(timeHourList);
        scheduleInfoList.add(timeMinuteList);
        scheduleInfoList.add(contentList);
        scheduleInfoList.add(sIdxList);
        scheduleInfoList.add(nameList);
        scheduleInfoList.add(uIdxList);
    }
%>

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>The Calen</title>
  <link rel="stylesheet" href="../../css/common.css" />
  <link rel="stylesheet" href="../../css/navBar.css" />
  <link rel="stylesheet" href="../../css/homePage.css" />
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
  <nav id="navBar">
    <section id="headerContainer">
        <img src="../../src/pictures/headerPicture.png" alt="headerPicture" id="headerPicture" />
        <h1 id="headerTitle">The Calen</h1>
    </section>
    <section id="profileContainer">
        <img src="../../src/icons/profileIcon.png" id="userProfileIcon" />
        <p id="welcomeText"></p>
        <a href="../actionJsp/logoutAction.jsp" id="logoutBtn" class="additionalText">로그아웃</a>
    </section>
    <section id="menuContainer">
        <div id="calendarMenuContainer" onclick="moveToCalendarEvent()">
            <img src="../../src/icons/calenderIcon.png" alt="calendarIcon" id="calendarIcon" class="menuIcon" />
            <h2>캘린더</h2>
        </div>
        <div id="mypageMenuContainer" onclick="moveToMypageEvent()">
            <img src="../../src/icons/profileIcon.png" alt="profileIcon" id="mypageIcon" class="menuIcon" />
            <h2>마이페이지</h2>
        </div>
    </section>
  </nav>
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
  <script src="../../js/navBar.js"></script>

  <script>
    if(!<%=isLogin%>) location.href = "./loginPage.jsp"
    
    let scheduleInfoList = <%=scheduleInfoList%>
 
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
                    let scheduleCnt = 0
                    for (let j = 0; j < scheduleInfoList[1].length; j++) {
                            if(scheduleInfoList[0][j]==currentYear&&scheduleInfoList[1][j]==currentMonth&& Number(scheduleInfoList[2][j])==date.id){
                                scheduleCnt++
                                if(scheduleCnt<=3){
                                    let scheduleContainer = document.createElement('div')
                                    scheduleContainer.classList.add('scheduleContainer','date'+loopDateNum, 'sIdx'+scheduleInfoList[6][j], 'uIdx'+scheduleInfoList[8][j])
                                    
                                    let scheduleName = document.createElement('div')
                                    scheduleName.classList.add('scheduleName','date'+loopDateNum, 'sIdx'+scheduleInfoList[6][j], 'uIdx'+scheduleInfoList[8][j])
                                    scheduleName.innerText = scheduleInfoList[5][j]
                                    scheduleContainer.appendChild(scheduleName)

                                    if(scheduleInfoList[7][j]!="0"){
                                        let scheduleMember = document.createElement('div')
                                        scheduleMember.classList.add('scheduleMember','date'+loopDateNum, 'sIdx'+scheduleInfoList[6][j], 'uIdx'+scheduleInfoList[8][j])
                                        scheduleMember.innerText = scheduleInfoList[7][j]
                                        scheduleContainer.appendChild(scheduleMember)
                                        date.appendChild(scheduleContainer)
                                    }
                                    let scheduleTime = document.createElement('div')
                                    scheduleTime.classList.add('scheduleTime','date'+loopDateNum, 'sIdx'+scheduleInfoList[6][j], 'uIdx'+scheduleInfoList[8][j])
                                    scheduleTime.innerText = scheduleInfoList[3][j]+':'+scheduleInfoList[4][j]
                                    scheduleContainer.appendChild(scheduleTime)
                                    date.appendChild(scheduleContainer)
                                }
                                else{
                                    let viewMoreBtn = document.createElement('a')
                                    viewMoreBtn.innerText = '일정 더보기...'
                                    viewMoreBtn.classList.add('viewMoreBtn', 'date'+loopDateNum)
                                    date.appendChild(viewMoreBtn)
                                    break
                                }
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
        let userSessionPosition = "<%=userSessionPosition%>"
        if(userSessionPosition==0){

            let navBar = document.getElementById('navBar')

            let teamMemberContainer = document.createElement('form')
            teamMemberContainer.action = "../actionJsp/changeShowedTeamMemberAction.jsp"
            teamMemberContainer.id = "teamMemberContainer"

            let teamMemberListText = document.createElement('p')
            teamMemberListText.id = "teamMemberListText"
            teamMemberListText.innerText = "팀원 목록"

            teamMemberContainer.append(teamMemberListText)

            let memberNameList = <%=teamMemberNameList%>
            let memberIdxList = <%=teamMemberIdxList%>
            let showedMemberIdxList = <%=teamMemberCheckedList%>

            for(let i=0; i<showedMemberIdxList.length; i++){
                showedMemberIdxList[i] = showedMemberIdxList[i].toString()
            }
            
            for(let i=0; i<memberIdxList.length; i++){

                let memberContainer = document.createElement('div')
                memberContainer.classList.add('memberContainer')

                let memberCheckbox = document.createElement('input')
                memberCheckbox.type = "checkbox"
                memberCheckbox.id = 'member'+memberIdxList[i]
                memberCheckbox.value = memberIdxList[i]
                memberCheckbox.name = "members"
                memberCheckbox.classList.add("members")

                if(showedMemberIdxList.includes(memberIdxList[i])){
                    memberCheckbox.checked = true
                }

                let memberCheckboxLabel = document.createElement('label')
                memberCheckboxLabel.htmlFor = 'member'+memberIdxList[i]
                memberCheckboxLabel.innerText = memberNameList[i]

                memberContainer.append(memberCheckbox,memberCheckboxLabel)
                teamMemberContainer.append(memberContainer)
            }
            navBar.append(teamMemberContainer)
        }


        $('.members').change(function(event){
            teamMemberContainer.submit()
        })

        $('.viewMoreBtn').click(function (event) {
            event.stopPropagation();
            let parentNode = event.target.parentNode.getElementsByClassName('scheduleContainer')

            let smList =[]
            for(let i=0; i<parentNode.length; i++){
                let sM = parentNode[i].getElementsByClassName('scheduleMember')[0]
                if(sM) smList.push(sM.innerText)
                else smList.push("0")
            }

            let selectedDate = event.target.classList.item(1).substr(4)
            modalContainerBackground.style.display = 'flex'

            let contentList = []
            let timeList = []
            let sIdxList = []

            for (let j = 0; j < scheduleInfoList[1].length; j++) {
                if(scheduleInfoList[0][j]==currentYear&&scheduleInfoList[1][j]==currentMonth&& Number(scheduleInfoList[2][j])==selectedDate){
                    contentList.push(scheduleInfoList[5][j])
                    timeList.push(scheduleInfoList[3][j]+":"+scheduleInfoList[4][j])
                    sIdxList.push(scheduleInfoList[6][j])
                }
            }

            makeScheduleListModal(selectedDate.length < 2 ? "0"+selectedDate : selectedDate, contentList, timeList, sIdxList, smList)
        })

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
            let sIdx = event.target.classList.item(2).substr(4)
            let uIdx = event.target.classList.item(3).substr(4)

            let contentValue=""
            let dateValue=""

            if(selectedElementClassName == 'scheduleContainer'){
                contentValue = event.target.firstChild.innerText
                dateValue = event.target.lastChild.innerText
            }

            if(uIdx=="0"){
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
            }else{
                if(selectedElementClassName == 'scheduleContainer'){
                    contentValue = event.target.firstChild.innerText
                    dateValue = event.target.lastChild.innerText
                }else if(selectedElementClassName == 'scheduleTime'){
                    contentValue = event.target.previousSibling.previousSibling.innerText
                    dateValue = event.target.innerText
                }else if(selectedElementClassName == 'scheduleName'){
                    contentValue = event.target.innerText
                    dateValue = event.target.nextSibling.nextSibling.innerText
                }else if(selectedElementClassName == 'scheduleMember'){
                    contentValue = event.target.previousSibling.innerText
                    dateValue = event.target.nextSibling.innerText
                }
            }

            modalContainerBackground.style.display = 'flex'

            makeScheduleModifyModal(selectedDate.length < 2 ? "0"+selectedDate : selectedDate, contentValue, dateValue, sIdx, uIdx)
        })
    })
  </script>
</body>

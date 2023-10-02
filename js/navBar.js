//페이지 이동 시에 navBar 관련 함수, 기능들
let calendarMenuContainer = document.getElementById('calendarMenuContainer')
let mypageMenuContainer = document.getElementById('mypageMenuContainer')

function moveToCalendarEvent() {
  console.log('hi')
  localStorage.setItem('currentPage', 'calendar')
  localStorage.setItem('currentMonth', new Date().getMonth())
  localStorage.setItem('currentYear', new Date().getFullYear())
  location.href = './homePage.jsp'
}
function moveToMypageEvent() {
  localStorage.setItem('currentPage', 'myPage')

  location.href = './myPage.jsp'
}
let currentPage = localStorage.getItem('currentPage')
switch (currentPage) {
  case 'myPage':
    calendarMenuContainer.classList.remove('currentPage')
    mypageMenuContainer.className += ' currentPage'
    break
  case 'calendar':
  default:
    mypageMenuContainer.classList.remove('currentPage')
    calendarMenuContainer.className += ' currentPage'
    break
}
//navBar의 이름을 localStorage 에서 받아 넣어주는 작업
let welcomeText = (document.getElementById('welcomeText').innerText = `${localStorage.getItem('name')} 님 환영합니다`)

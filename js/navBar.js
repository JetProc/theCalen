let calendarMenuContainer = document.getElementById('calendarMenuContainer')
let mypageMenuContainer = document.getElementById('mypageMenuContainer')

function moveToCalendarEvent() {
  localStorage.setItem('currentPage', 'calendar')
  location.href = './homePage.jsp'
}
function moveToMypageEvent() {
  localStorage.setItem('currentPage', 'myPage')
  location.href = './myPage.jsp'
}
let currentPage = localStorage.getItem('currentPage')
switch (currentPage) {
  case 'myPage':
    // boardsMenuContainer.classList.remove('currentPage')
    // writePostContainer.classList.remove('currentPage')
    // mypageMenuContainer.className += ' currentPage'
    break
  case 'calendar':
  default:
    // mypageMenuContainer.classList.remove('currentPage')
    // writePostContainer.classList.remove('currentPage')
    // boardsMenuContainer.className += ' currentPage'
    break
}

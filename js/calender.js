// 각 달의 마지막 날 구해서 리스트에 저장
let lastDayList = []
for (let i = 0; i < 12; i++) lastDayList.push(new Date(2023, i + 1, 0).getDate())

let currentMonth = 9
function renderCalendar() {
  let calendarContainer = document.getElementById('calendarContainer')
  document.createElement('div')
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
      console.log(7 * i + j, lastDayList[currentMonth])
      if (7 * i + j >= lastDayList[currentMonth - 1]) {
        calendarContainer.appendChild(week)
        return 0
      }
    }
    calendarContainer.appendChild(week)
  }
}

renderCalendar()

let lastDayList = []

for (let i = 0; i < 12; i++) {
  lastDayList.push(new Date(2023, i + 1, 0).getDate())
}
// console.log(lastDayList)
let calendarContainer = document.getElementById('calendarContainer')
let week

for (let i = 1; i <= 10; i++) {
  if (i % 7 == 1) {
    week = document.createElement('div')
  }
  let date = document.createElement('div')
  date.class = 'date'
  week.appendChild(date)
  let dateNumber = document.createElement('div')
  dateNumber.class = 'dateNumber'
  week.appendChild(dateNumber)
  let hiddenText = document.createElement('div')
  hiddenText.class = 'hiddenText'
  hiddenText.innerText = '눌러서 일정 추가'
  week.appendChild(hiddenText)
  //   for (let i = 0; i < 3; i++) {
  //     let scheduleContainer = document.createElement('div')
  //     scheduleContainer.class = 'scheduleContainer'
  //     let scheduleName = document.createElement('div')
  //     scheduleName.class = 'scheduleName'
  //     scheduleName.value = '강아지 밥 주기'
  //     scheduleContainer.appendChild(scheduleName)
  //     let scheduleTime = document.createElement('div')
  //     scheduleTime.class = 'scheduleTime'
  //     scheduleTime.value = '09:00'
  //     scheduleContainer.appendChild(scheduleTime)
  //     week.appendChild(scheduleContainer)
  //   }
  calendarContainer.appendChild(week)
}

function makeScheduleList() {
  let scheduleListsContainer = document.getElementById('scheduleListsContainer')
  for (let i = 0; i < 20; i++) {
    let scheduleListContainer = document.createElement('div')
    scheduleListContainer.className = 'scheduleListContainer'
    let scheduleListName = document.createElement('div')
    scheduleListName.className = 'scheduleListName'
    scheduleListName.innerText = '고슴도치 밥 주기'
    let scheduleListTime = document.createElement('div')
    scheduleListTime.className = 'scheduleListTime'
    scheduleListTime.innerText = '16:00'
    scheduleListContainer.append(scheduleListName, scheduleListTime)
    scheduleListsContainer.appendChild(scheduleListContainer)
  }
}
makeScheduleList()

//모달에서 공통으로 쓰이는 부분
let modalContainerBackground = document.getElementById('modalContainerBackground')

//스케줄 리스트를 보여주는 모달
function makeScheduleListModal(date, contentList, timeList, sIdxList) {
  let modalContainer1 = document.createElement('form')
  modalContainer1.id = 'modalContainer1'
  modalContainer1.className = 'modalContainer'

  let goBackBtn = document.createElement('img')
  goBackBtn.src = '../../src/icons/exitIcon.png'
  goBackBtn.classList.add('goBackBtn', 'additionalText')

  let dateText = document.createElement('div')
  dateText.id = 'dateText'
  dateText.innerText = currentYear + '년 ' + currentMonth + '월 ' + date + '일'

  let scheduleListsContainer = document.createElement('div')
  scheduleListsContainer.id = 'scheduleListsContainer'

  for (let i = 0; i < contentList.length; i++) {
    let scheduleListContainer = document.createElement('div')
    scheduleListContainer.classList.add('scheduleListContainer', 'sIdx' + sIdxList[i])

    let scheduleListName = document.createElement('div')
    scheduleListName.classList.add('scheduleListName', 'sIdx' + sIdxList[i])
    scheduleListName.innerText = contentList[i]

    let scheduleListTime = document.createElement('div')
    scheduleListTime.classList.add('scheduleListTime', 'sIdx' + sIdxList[i])
    scheduleListTime.innerText = timeList[i]

    scheduleListContainer.append(scheduleListName, scheduleListTime)
    scheduleListsContainer.appendChild(scheduleListContainer)
  }

  modalContainer1.append(goBackBtn, dateText, scheduleListsContainer)
  modalContainerBackground.appendChild(modalContainer1)

  $(document).ready(function () {
    $('.goBackBtn').click(function () {
      modalContainerBackground.style.display = 'none'
      modalContainer1.remove()
    })

    $('.scheduleListContainer').click(function (event) {
      modalContainer1.remove()

      let contentValue = ''
      let dateValue = ''
      let sIdx = event.target.classList.item(1).substr(4)

      let selectedElementClassName = event.target.classList.item(0)

      if (selectedElementClassName == 'scheduleListContainer') {
        contentValue = event.target.firstChild.innerText
        dateValue = event.target.lastChild.innerText
      } else if (selectedElementClassName == 'scheduleListTime') {
        contentValue = event.target.previousSibling.innerText
        dateValue = event.target.innerText
      } else if (selectedElementClassName == 'scheduleListName') {
        contentValue = event.target.innerText
        dateValue = event.target.nextSibling.innerText
      }

      makeScheduleModifyModal(date, contentValue, dateValue, sIdx)
    })
  })
}

//스케줄을 입력할 수 있는 모달
function makeScheduleInputModal(date) {
  let modalContainer2 = document.createElement('form')
  modalContainer2.id = 'modalContainer2'
  modalContainer2.className = 'modalContainer'

  let goBackBtn = document.createElement('img')
  goBackBtn.src = '../../src/icons/exitIcon.png'
  goBackBtn.classList.add('goBackBtn', 'additionalText')

  let yearAndDateText = document.createElement('p')
  yearAndDateText.innerText = currentYear + '년 ' + currentMonth + '월 ' + date + '일'
  yearAndDateText.className = 'yearAndDateText'

  let scheduleContentsInputLabel = document.createElement('label')
  scheduleContentsInputLabel.htmlFor = 'scheduleContentsInput'
  scheduleContentsInputLabel.className = 'inputLabel'
  scheduleContentsInputLabel.innerText = '일정 내용'

  let scheduleContentsInput = document.createElement('input')
  scheduleContentsInput.type = 'text'
  scheduleContentsInput.id = 'scheduleContentsInput'
  scheduleContentsInput.name = 'scheduleContentsInput'
  scheduleContentsInput.className = 'inputBox'
  scheduleContentsInput.placeholder = '일정 입력'
  scheduleContentsInput.required = true

  let scheduleTimeInputLabel = document.createElement('label')
  scheduleTimeInputLabel.htmlFor = 'scheduleTimeInput'
  scheduleTimeInputLabel.className = 'inputLabel'
  scheduleTimeInputLabel.innerText = '일정 시간'

  let scheduleTimeInput = document.createElement('input')
  scheduleTimeInput.type = 'time'
  scheduleTimeInput.id = 'scheduleTimeInput'
  scheduleTimeInput.name = 'scheduleTimeInput'
  scheduleTimeInput.className = 'inputBox'
  scheduleTimeInput.value = '09:00'
  scheduleTimeInput.required = true

  let addBtn = document.createElement('input')
  addBtn.type = 'submit'
  addBtn.formAction = '../actionJsp/addScheduleAction.jsp'
  addBtn.id = 'addBtn'
  addBtn.className = 'actionBtn'
  addBtn.value = '추가'

  let btnContainer = document.createElement('div')
  btnContainer.id = 'btnContainer'
  btnContainer.appendChild(addBtn)

  let localStorageDate = document.createElement('input')
  localStorageDate.type = 'hidden'
  localStorageDate.name = 'localStorageDate'
  localStorageDate.value = `${localStorage.getItem('currentYear')}-${localStorage.getItem('currentMonth')}-${date}`

  modalContainer2.append(
    goBackBtn,
    yearAndDateText,
    scheduleContentsInputLabel,
    scheduleContentsInput,
    scheduleTimeInputLabel,
    scheduleTimeInput,
    btnContainer,
    localStorageDate
  )
  modalContainerBackground.appendChild(modalContainer2)

  setTimeout(() => {
    scheduleContentsInput.focus()
  }, 50)

  $(document).ready(function () {
    $('.goBackBtn').click(function () {
      modalContainerBackground.style.display = 'none'
      modalContainer2.remove()
    })
  })
}

//스케줄을 확인, 수정, 삭제할 수 있는 모달
function makeScheduleModifyModal(date, contentValue, dateValue, sIdx) {
  let modalContainer3 = document.createElement('form')
  modalContainer3.id = 'modalContainer3'
  modalContainer3.className = 'modalContainer'

  let goBackBtn = document.createElement('img')
  goBackBtn.src = '../../src/icons/exitIcon.png'
  goBackBtn.classList.add('goBackBtn', 'additionalText')

  let yearAndDateText = document.createElement('p')
  yearAndDateText.className = 'yearAndDateText'
  yearAndDateText.innerText = currentYear + '년 ' + currentMonth + '월 ' + date + '일'

  let scheduleContentsInputLabel = document.createElement('label')
  scheduleContentsInputLabel.htmlFor = 'scheduleContentsInput'
  scheduleContentsInputLabel.className = 'inputLabel'
  scheduleContentsInputLabel.innerText = '일정 내용'

  let scheduleContentsInput = document.createElement('input')
  scheduleContentsInput.type = 'text'
  scheduleContentsInput.id = 'scheduleContentsInput'
  scheduleContentsInput.name = 'scheduleContentsInput'
  scheduleContentsInput.className = 'inputBox'
  scheduleContentsInput.placeholder = '일정 입력'
  scheduleContentsInput.required = true

  let scheduleTimeInputLabel = document.createElement('label')
  scheduleTimeInputLabel.htmlFor = 'scheduleTimeInput'
  scheduleTimeInputLabel.className = 'inputLabel'
  scheduleTimeInputLabel.innerText = '일정 시간'

  let scheduleTimeInput = document.createElement('input')
  scheduleTimeInput.type = 'time'
  scheduleTimeInput.id = 'scheduleTimeInput'
  scheduleTimeInput.name = 'scheduleTimeInput'
  scheduleTimeInput.className = 'inputBox'
  scheduleTimeInput.value = '09:00'
  scheduleTimeInput.required = true

  scheduleContentsInput.value = contentValue
  scheduleTimeInput.value = dateValue

  let deleteBtn = document.createElement('input')
  deleteBtn.type = 'submit'
  deleteBtn.formAction = '../actionJsp/deleteScheduleAction.jsp'
  deleteBtn.id = 'deleteBtn'
  deleteBtn.className = 'actionBtn'
  deleteBtn.value = '삭제'

  let modifyBtn = document.createElement('input')
  modifyBtn.type = 'submit'
  modifyBtn.formAction = '../actionJsp/modifyScheduleAction.jsp'
  modifyBtn.id = 'modifyBtn'
  modifyBtn.className = 'actionBtn'
  modifyBtn.value = '수정'

  let btnContainer = document.createElement('div')
  btnContainer.id = 'btnContainer'
  btnContainer.append(deleteBtn, modifyBtn)

  let localStorageDate = document.createElement('input')
  localStorageDate.type = 'hidden'
  localStorageDate.name = 'localStorageDate'
  localStorageDate.value = `${localStorage.getItem('currentYear')}-${localStorage.getItem('currentMonth')}-${date}`

  let sIdxValue = document.createElement('input')
  sIdxValue.type = 'hidden'
  sIdxValue.name = 'sIdxValue'
  sIdxValue.value = sIdx

  modalContainer3.append(
    goBackBtn,
    yearAndDateText,
    scheduleContentsInputLabel,
    scheduleContentsInput,
    scheduleTimeInputLabel,
    scheduleTimeInput,
    btnContainer,
    localStorageDate,
    sIdxValue
  )
  modalContainerBackground.appendChild(modalContainer3)

  $(document).ready(function () {
    $('.goBackBtn').click(function () {
      modalContainerBackground.style.display = 'none'
      modalContainer3.remove()
    })
  })
}

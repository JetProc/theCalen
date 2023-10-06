//모달에서 공통으로 쓰이는 부분
let modalContainerBackground = document.getElementById('modalContainerBackground')

function makeScheduleListModal() {
  let modalContainer1 = document.createElement('form')
  modalContainer1.id = 'modalContainer1'
  modalContainer1.className = 'modalContainer'

  let goBackBtn = document.createElement('img')
  goBackBtn.src = '../../src/icons/exitIcon.png'
  goBackBtn.classList.add('goBackBtn', 'additionalText')

  let dateText = document.createElement('div')
  dateText.id = 'dateText'
  dateText.innerText = '2023년 9월 12일'

  let scheduleListsContainer = document.createElement('div')
  scheduleListsContainer.id = 'scheduleListsContainer'

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

  modalContainer1.append(goBackBtn, dateText, scheduleListsContainer)
  modalContainerBackground.appendChild(modalContainer1)

  $(document).ready(function () {
    $('.goBackBtn').click(function () {
      modalContainerBackground.style.display = 'none'
      modalContainer1.remove()
    })
  })
}

function makeScheduleInputModal(date) {
  let modalContainer2 = document.createElement('form')
  modalContainer2.id = 'modalContainer2'
  modalContainer2.className = 'modalContainer'

  let localStorageDate = document.createElement('input')
  localStorageDate.type = 'hidden'
  localStorageDate.name = 'localStorageDate'
  localStorageDate.value = `${localStorage.getItem('currentYear')}-${localStorage.getItem('currentMonth')}-${date}`
  modalContainer2.appendChild(localStorageDate)

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

  modalContainer2.append(
    goBackBtn,
    yearAndDateText,
    scheduleContentsInputLabel,
    scheduleContentsInput,
    scheduleTimeInputLabel,
    scheduleTimeInput,
    btnContainer
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

function makeScheduleModifyModal(date, contentValue, dateValue) {
  let modalContainer3 = document.createElement('form')
  modalContainer3.id = 'modalContainer3'
  modalContainer3.className = 'modalContainer'

  let localStorageDate = document.createElement('input')
  localStorageDate.type = 'hidden'
  localStorageDate.name = 'localStorageDate'
  localStorageDate.value = `${localStorage.getItem('currentYear')}-${localStorage.getItem('currentMonth')}-${date}`
  modalContainer3.appendChild(localStorageDate)

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

  scheduleContentsInput.value = contentValue
  scheduleTimeInput.value = dateValue

  let deleteBtn = document.createElement('input')
  deleteBtn.type = 'submit'

  deleteBtn.formAction = ''

  deleteBtn.id = 'deleteBtn'
  deleteBtn.className = 'actionBtn'
  deleteBtn.value = '삭제'

  let modifyBtn = document.createElement('input')
  modifyBtn.type = 'submit'

  modifyBtn.formAction = ''

  modifyBtn.id = 'modifyBtn'
  modifyBtn.className = 'actionBtn'
  modifyBtn.value = '수정'

  let btnContainer = document.createElement('div')
  btnContainer.id = 'btnContainer'
  btnContainer.append(deleteBtn, modifyBtn)

  modalContainer3.append(
    goBackBtn,
    yearAndDateText,
    scheduleContentsInputLabel,
    scheduleContentsInput,
    scheduleTimeInputLabel,
    scheduleTimeInput,
    btnContainer
  )
  modalContainerBackground.appendChild(modalContainer3)

  $(document).ready(function () {
    $('.goBackBtn').click(function () {
      modalContainerBackground.style.display = 'none'
      modalContainer3.remove()
    })
  })
}

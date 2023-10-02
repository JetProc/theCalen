//모달에서 공통으로 쓰이는 부분
let modalContainer = document.getElementById('modalContainer')
modalContainer.id = 'modalContainer'

let goBackBtn = document.createElement('img')
goBackBtn.src = '../../src/icons/exitIcon.png'
goBackBtn.id = 'goBackBtn'
goBackBtn.className = 'additionalText'

let scheduleContentsInputLabel = document.createElement('label')
scheduleContentsInputLabel.htmlFor = 'scheduleContentsInput'
scheduleContentsInputLabel.className = 'inputLabel'
scheduleContentsInputLabel.innerText = '일정 내용'

let scheduleContentsInput = document.createElement('input')
scheduleContentsInput.type = 'text'
scheduleContentsInput.id = 'scheduleContentsInput'
scheduleContentsInput.className = 'inputBox'
scheduleContentsInput.placeholder = '일정 입력'
scheduleContentsInput.autofocus = true
scheduleContentsInput.required = true

let scheduleTimeInputLabel = document.createElement('label')
scheduleTimeInputLabel.htmlFor = 'scheduleTimeInput'
scheduleTimeInputLabel.className = 'inputLabel'
scheduleTimeInputLabel.innerText = '일정 시간'

let scheduleTimeInput = document.createElement('input')
scheduleTimeInput.type = 'time'
scheduleTimeInput.id = 'scheduleTimeInput'
scheduleTimeInput.className = 'inputBox'
scheduleTimeInput.value = '13:40'
scheduleTimeInput.required = true

let btnContainer = document.createElement('div')
btnContainer.id = 'btnContainer'

$(document).ready(function () {
  $('#goBackBtn').click(function () {
    modalContainer.style.display = 'none'
  })
})

function makeScheduleListModal() {
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

  modalContainer.append(goBackBtn, dateText, scheduleListsContainer)
}

function makeScheduleInputModal() {
  let addBtn = document.createElement('input')
  addBtn.type = 'button'
  addBtn.id = 'addBtn'
  addBtn.className = 'actionBtn'
  addBtn.value = '추가'

  btnContainer.appendChild(addBtn)

  modalContainer.append(
    goBackBtn,
    scheduleContentsInputLabel,
    scheduleContentsInput,
    scheduleTimeInputLabel,
    scheduleTimeInput,
    btnContainer
  )
}
function makeScheduleModifyModal() {
  scheduleContentsInput.value = '백엔드에서 받아와야하는 값'
  scheduleTimeInput.value = '09:44'

  scheduleContentsInput.autofocus = false

  let deleteBtn = document.createElement('input')
  deleteBtn.type = 'button'
  deleteBtn.id = 'deleteBtn'
  deleteBtn.className = 'actionBtn'
  deleteBtn.value = '삭제'

  let modifyBtn = document.createElement('input')
  modifyBtn.type = 'button'
  modifyBtn.id = 'modifyBtn'
  modifyBtn.className = 'actionBtn'
  modifyBtn.value = '수정'

  btnContainer.append(deleteBtn, modifyBtn)
  modalContainer.append(
    goBackBtn,
    scheduleContentsInputLabel,
    scheduleContentsInput,
    scheduleTimeInputLabel,
    scheduleTimeInput,
    btnContainer
  )
}
makeScheduleModifyModal()
//makeScheduleListModal()
//makeScheduleInputModal()

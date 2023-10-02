//모달에서 공통으로 쓰이는 부분
let modalContainerBackground = document.getElementById('modalContainerBackground')

let modalContainer1 = document.createElement('section')
modalContainer1.id = 'modalContainer1'
modalContainer1.className = 'modalContainer'

let modalContainer2 = document.createElement('section')
modalContainer2.id = 'modalContainer2'
modalContainer2.className = 'modalContainer'

let modalContainer3 = document.createElement('section')
modalContainer3.id = 'modalContainer3'
modalContainer3.className = 'modalContainer'

let goBackBtn = document.createElement('img')
goBackBtn.src = '../../src/icons/exitIcon.png'
goBackBtn.classList.add('goBackBtn', 'additionalText')

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

  modalContainer1.append(goBackBtn.cloneNode(false), dateText, scheduleListsContainer)
  modalContainerBackground.appendChild(modalContainer1)
}

function makeScheduleInputModal() {
  let addBtn = document.createElement('input')
  addBtn.type = 'button'
  addBtn.id = 'addBtn'
  addBtn.className = 'actionBtn'
  addBtn.value = '추가'

  let btnContainer1 = btnContainer.cloneNode(true)
  btnContainer1.appendChild(addBtn)

  modalContainer2.append(
    goBackBtn.cloneNode(true),
    scheduleContentsInputLabel.cloneNode(true),
    scheduleContentsInput.cloneNode(true),
    scheduleTimeInputLabel.cloneNode(true),
    scheduleTimeInput.cloneNode(true),
    btnContainer1
  )
  modalContainerBackground.appendChild(modalContainer2)
}
function makeScheduleModifyModal() {
  let scheduleContentsInput2 = scheduleContentsInput.cloneNode(true)
  scheduleContentsInput2.value = '백엔드에서 받아와야하는 값'
  let scheduleTimeInput2 = scheduleTimeInput.cloneNode(true)
  scheduleTimeInput2.value = '09:44'

  scheduleContentsInput2.autofocus = false

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

  let btnContainer2 = btnContainer.cloneNode(true)
  btnContainer2.append(deleteBtn, modifyBtn)
  modalContainer3.append(
    goBackBtn,
    scheduleContentsInputLabel.cloneNode(true),
    scheduleContentsInput2,
    scheduleTimeInputLabel.cloneNode(true),
    scheduleTimeInput2,
    btnContainer2
  )
  modalContainerBackground.appendChild(modalContainer3)
}
$(document).ready(function () {
  $('.goBackBtn').click(function () {
    modalContainerBackground.style.display = 'none'

    modalContainer1.style.display = 'none'
    modalContainer2.style.display = 'none'
    modalContainer3.style.display = 'none'
  })
})
makeScheduleListModal()
makeScheduleInputModal()
makeScheduleModifyModal()

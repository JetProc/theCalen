function checkIsIdValid() {
  const idRegex = /^[a-z]+[a-z0-9]{3,13}$/g
  let id = document.getElementById('id')
  //id 정규화 (영문 시작, 6~20자)
  if (!idRegex.test(id.value)) {
    alert('id는 영문으로 시작하는 영문자 또는 숫자 4~12자 이내로 입력해주세요.')
    id.focus()
    return false
  } else return true
}
function checkIsPwValid() {
  const passwordRegex = /^(?=.*[a-zA-Z])(?=.*[~!@#$%^&*+=_-])(?=.*[0-9]).{6,20}$/
  let pw = document.getElementById('pw')
  //pw 정규화 (영문,숫자,특수문자 포함, 6~20자)
  if (!passwordRegex.test(pw.value)) {
    alert('비밀번호는 영문, 숫자, 특수문자를 포함하여 6~20자 이내로 입력해주세요.')
    pw.focus()
    return false
  } else return true
}

function checkIsPwSame(event) {
  let pw = document.getElementById('pw')
  let confirmPw = document.getElementById('confirmPw')
  //pw 같은지 확인
  if (pw.value != confirmPw.value) {
    event.preventDefault()
    alert('비밀번호가 서로 다릅니다 !')
    pw.value = confirmPw.value = ''
    pw.focus()
    return false
  } else return true
}

function checkIsNameValid() {
  const nameRegex = /^[가-힣]{2,6}$/
  let name = document.getElementById('name')
  //이름 정규화 (2~6자)
  if (!nameRegex.test(name.value)) {
    alert('한글로 된 실명을 입력해주세요.')
    name.focus()
    return false
  } else return true
}

function checkIsPhoneNumberValid() {
  const phoneNumberRegex = /^010-[0-9]{4}-[0-9]{4}$/
  let phonenum = document.getElementById('phonenum')
  //핸드폰 번호 정규화
  if (!phoneNumberRegex.test(phonenum.value)) {
    alert('올바른 핸드폰 번호를 입력해주세요.')
    phonenum.focus()
    return false
  } else return true
}

function checkFindIdValidEvent(event) {
  return checkIsNameValid() && checkIsPhoneNumberValid()
}
function checkFindPwValidEvent(event) {
  return checkIsIdValid() && checkIsNameValid() && checkIsPhoneNumberValid()
}
function checkLoginValidEvent(event) {
  return checkIsIdValid() && checkIsPwValid()
}
function checkRegisterValidEvent(event) {
  return checkIsIdValid() && checkIsPwValid() && checkIsPwSame() && checkIsNameValid() && checkIsPhoneNumberValid()
}

//페이지 불러올 때 자동 하이픈
function autoHypenOnloading() {
  let phoneNum = document.getElementById('phoneNumber')
  phoneNum.value = phoneNum.value
    .replace(/[^0-9]/g, '')
    .replace(/^(\d{0,3})(\d{0,4})(\d{0,4})$/g, '$1-$2-$3')
    .replace(/(\-{1,2})$/g, '')
}

//숫자 입력할 때 실시간 자동 하이픈
const autoHyphen = target => {
  target.value = target.value
    .replace(/[^0-9]/g, '')
    .replace(/^(\d{0,3})(\d{0,4})(\d{0,4})$/g, '$1-$2-$3')
    .replace(/(\-{1,2})$/g, '')
}

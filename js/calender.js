let lastDayList = []

for (let i = 0; i < 12; i++) {
  lastDayList.push(new Date(2023, i + 1, 0).getDate())
}
console.log(lastDayList)

for (let i = 0; i < lastDayList[0]; i++) {}

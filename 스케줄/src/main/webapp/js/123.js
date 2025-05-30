const calendar = document.getElementById("calendar");
const selectedDateTitle = document.getElementById("selected-date-title");
const scheduleBody = document.getElementById("schedule-body");
const selectedData = [];

const baseHours = ["12:00", "13:00", "14:00", "15:00", "16:00", "17:00", "18:00", "19:00", "20:00"];
const trainers = ["김계란", "손흥민", "이강인", "기성용", "박지성"];

function pad(n) {
  return n < 10 ? '0' + n : n;
}

function renderCalendar(date = new Date()) {
  calendar.innerHTML = "";
  const year = date.getFullYear();
  const month = date.getMonth();
  const firstDay = new Date(year, month, 1).getDay();
  const lastDate = new Date(year, month + 1, 0).getDate();
  const today = new Date();

  const header = document.createElement("div");
  header.className = "calendar-header";

  const prev = document.createElement("span");
  prev.textContent = "<";
  prev.style.cursor = "pointer";
  prev.onclick = () => renderCalendar(new Date(year, month - 1, 1));

  const next = document.createElement("span");
  next.textContent = ">";
  next.style.cursor = "pointer";
  next.onclick = () => renderCalendar(new Date(year, month + 1, 1));

  const title = document.createElement("div");
  title.textContent = `${year}년 ${month + 1}월`;
  title.className = "calendar-title";

  header.appendChild(prev);
  header.appendChild(title);
  header.appendChild(next);
  calendar.appendChild(header);

  const grid = document.createElement("div");
  grid.className = "calendar-grid";

  const days = ["일", "월", "화", "수", "목", "금", "토"];
  days.forEach(day => {
    const dayCell = document.createElement("div");
    dayCell.className = "calendar-day";
    dayCell.textContent = day;
    grid.appendChild(dayCell);
  });

  for (let i = 0; i < firstDay; i++) grid.appendChild(document.createElement("div"));

  for (let d = 1; d <= lastDate; d++) {
    const cell = document.createElement("div");
    cell.className = "calendar-date";
    cell.textContent = d;
    const dateStr = `${year}-${pad(month + 1)}-${pad(d)}`;

    // 오늘 날짜 강조
    if (d === today.getDate() && year === today.getFullYear() && month === today.getMonth()) {
      cell.classList.add("today");
    }

    // 선택된 날짜 표시
    if (initialSelectedDate && initialSelectedDate === dateStr) {
      cell.classList.add("selected");
    }

    // 날짜 클릭 시 이동
    cell.addEventListener("click", () => {
      window.location.href = `schedule.jsp?date=${dateStr}`;
    });

    grid.appendChild(cell);
  }

  calendar.appendChild(grid);
}

function renderSchedule() {
  scheduleBody.innerHTML = "";
  baseHours.forEach(hour => {
    const [h, m] = hour.split(":");
    const baseTime = new Date(0, 0, 0, +h, +m);

    for (let i = 0; i < 2; i++) {
      const time = new Date(baseTime.getTime() + i * 30 * 60000);
      const nextTime = new Date(time.getTime() + 30 * 60000);
      const timeStr = time.toTimeString().substring(0, 5);
      const nextStr = nextTime.toTimeString().substring(0, 5);

      const tr = document.createElement("tr");

      if (i === 0) {
        const timeCell = document.createElement("td");
        timeCell.textContent = hour;
        timeCell.rowSpan = 2;
        timeCell.classList.add("time-cell");
        tr.appendChild(timeCell);
      }

      trainers.forEach(trainer => {
        const td = document.createElement("td");
        const wrapper = document.createElement("div");
        wrapper.className = "cell-wrapper";

        const checkbox = document.createElement("input");
        checkbox.type = "checkbox";
        checkbox.className = "cell-checkbox";
        checkbox.style.display = "none";

        const input = document.createElement("input");
        input.type = "text";
        input.className = "cell-input";
        input.placeholder = "";
        input.disabled = true;

        wrapper.addEventListener("click", () => {
          checkbox.checked = !checkbox.checked;
          td.classList.toggle("selected-time", checkbox.checked);
          input.disabled = !checkbox.checked;
          if (checkbox.checked) input.focus();
          else input.value = "";
        });

        input.addEventListener("click", e => {
          e.stopPropagation();
          wrapper.click();
        });

        checkbox.addEventListener("click", e => e.stopPropagation());

        wrapper.appendChild(checkbox);
        wrapper.appendChild(input);
        td.appendChild(wrapper);

        td.dataset.time = `${timeStr}~${nextStr}`;
        td.dataset.trainer = trainer;

        tr.appendChild(td);
      });

      scheduleBody.appendChild(tr);
    }
  });
}

function enableEditing() {
  document.querySelectorAll(".selected-time .cell-input").forEach(input => {
    input.disabled = false;
    input.focus();
  });
}

document.querySelector("form").addEventListener("submit", (e) => {
  const form = e.target;

  // 기존 hidden input 제거
  document.querySelectorAll(".dynamic-entry").forEach(el => el.remove());

  const cells = document.querySelectorAll(".selected-time");
  cells.forEach((cell, i) => {
    const trainer = cell.dataset.trainer;
    const time = cell.dataset.time;
    const memo = cell.querySelector("input[type='text']").value.trim();
    const checked = true;

    const createHiddenInput = (name, value) => {
      const input = document.createElement("input");
      input.type = "hidden";
      input.name = `entries[${i}].${name}`;
      input.value = value;
      input.classList.add("dynamic-entry");
      form.appendChild(input);
    };

    createHiddenInput("trainer", trainer);
    createHiddenInput("time", time);
    createHiddenInput("memo", memo);
    createHiddenInput("checked", checked);
  });

  const title = document.getElementById("selected-date-title").textContent;
  const date = title.split(" ")[0];
  document.getElementById("selected-date-value").value = date;
});

// 실행
renderCalendar();
if (typeof initialSelectedDate !== "undefined" && initialSelectedDate) {
  selectedDateTitle.textContent = `${initialSelectedDate} 예약 스케줄`;
  renderSchedule();
}

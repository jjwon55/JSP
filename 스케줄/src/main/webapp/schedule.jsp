<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.util.*" %>
<%
  String selectedDate = request.getParameter("date");
  if (selectedDate == null || selectedDate.trim().isEmpty()) {
    selectedDate = "";
  }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>트레이너 시간표 - 최종본</title>
  <link rel="stylesheet" href="css/123.css">
</head>
<body>
  <div class="header">
    <div class="logo">
      <img src="img/ChatGPT Image 2025년 5월 16일 오후 06_09_58.png" alt="할건해야짐" />
    </div>
    <ul class="nav">
      <li>회원관리</li>
      <li>기구현황</li>
      <li>매출현황</li>
      <li>문의사항</li>
      <li>로그아웃</li>
    </ul>
  </div>

  <div class="container">
    <div class="calendar" id="calendar"></div>
    <div class="schedule">
      <h3 id="selected-date-title">날짜를 선택하세요</h3>
      <form action="ScheduleSaveServlet" method="post">
        <input type="hidden" name="date" id="selected-date-value" value="<%= selectedDate %>">
        <div class="buttons">
          <button type="submit">저장</button>
          <button type="button" onclick="enableEditing()">수정</button>
        </div>
        <table>
          <thead>
            <tr>
              <th>시간</th>
              <th>김계란</th>
              <th>손흥민</th>
              <th>이강인</th>
              <th>기성용</th>
              <th>박지성</th>
            </tr>
          </thead>
          <tbody id="schedule-body"></tbody>
        </table>
      </form>
    </div>
  </div>

  <script src="js/123.js"></script>
  <script>
  function enableEditing() {
    document.querySelectorAll('input[type="text"]').forEach(input => input.disabled = false);
  }

  // 날짜 클릭 시 해당 날짜로 이동
  function selectDate(dateStr) {
    window.location.href = "schedule.jsp?date=" + dateStr;
  }

  // pad 함수 정의
  function pad(n) {
    return n < 10 ? '0' + n : n;
  }

  // 달력 렌더링
  const calendar = document.getElementById("calendar");
  const today = new Date();
  let year = today.getFullYear();
  let month = today.getMonth(); // 0 ~ 11

  function renderCalendar(y, m) {
    calendar.innerHTML = "";

    const header = document.createElement("div");
    header.className = "calendar-header";

    const prev = document.createElement("span");
    prev.textContent = "<";
    prev.onclick = () => renderCalendar(y, m - 1);

    const next = document.createElement("span");
    next.textContent = ">";
    next.onclick = () => renderCalendar(y, m + 1);

    const title = document.createElement("div");
    title.className = "calendar-title";
    title.textContent = y + "년 " + (m + 1) + "월";

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

    const firstDay = new Date(y, m, 1).getDay();
    const lastDate = new Date(y, m + 1, 0).getDate();

    for (let i = 0; i < firstDay; i++) grid.appendChild(document.createElement("div"));

    for (let d = 1; d <= lastDate; d++) {
      const cell = document.createElement("div");
      cell.className = "calendar-date";
      cell.textContent = d;

      const dateStr = y + "-" + pad(m + 1) + "-" + pad(d);

      cell.onclick = () => selectDate(dateStr);
      grid.appendChild(cell);
    }

    calendar.appendChild(grid);
  }
  
  document.querySelector("form").addEventListener("submit", () => {
	    const title = document.getElementById("selected-date-title").textContent;
	    const date = title.split(" ")[0]; // "2025-05-22 예약 스케줄"
	    document.getElementById("selected-date-value").value = date;
	  });

  renderCalendar(year, month);
</script>
  
</body>

<footer class="footer">
  <div class="footer-top">
    <img src="img/ChatGPT Image 2025년 5월 16일 오후 06_09_58.png" alt="할건해야짐" class="footer-logo" />
    <ul class="footer-menu">
      <li>회원관리</li>
      <li>기구현황</li>
      <li>매출관리</li>
      <li>문의사항</li>
    </ul>
  </div>
  <div class="footer-bottom">
    카피라이트 어쩌고
  </div>
</footer>
</html>

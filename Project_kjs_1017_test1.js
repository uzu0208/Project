// SVG 요소를 가져옵니다.
const rect = document.getElementById("인천");
const rect1 = document.getElementById("서울");
const rect2 = document.getElementById("경기");
const rect3 = document.getElementById("강원");
const rect4 = document.getElementById("충북");
const rect5 = document.getElementById("충남");
const rect6 = document.getElementById("대전");
const rect7 = document.getElementById("경북");
const rect8 = document.getElementById("경남");
const rect9 = document.getElementById("대구");
const rect10 = document.getElementById("울산");
const rect11 = document.getElementById("부산");
const rect12 = document.getElementById("전북");
const rect13 = document.getElementById("전남");
const rect14 = document.getElementById("광주");
const rect15 = document.getElementById("제주");
const rect16 = document.getElementById("세종");

// 마우스 오버 시 색상을 변경하는 함수
function changeColorOnMouseOver(element, color) {
  element.addEventListener("mouseover", () => {
    element.setAttribute("fill", color);
  });
}

// 마우스 아웃 시 원래 색상으로 변경하는 함수
function resetColorOnMouseOut(element, originalColor) {
  element.addEventListener("mouseout", () => {
    element.setAttribute("fill", originalColor);
  });
}

// 초기 색상을 저장합니다.
const originalColor = rect.getAttribute("fill");

// 마우스 오버 및 마우스 아웃 이벤트에 함수를 연결합니다.
changeColorOnMouseOver(rect, "red");
resetColorOnMouseOut(rect, originalColor);
changeColorOnMouseOver(rect1, "red");
resetColorOnMouseOut(rect1, originalColor);
changeColorOnMouseOver(rect2, "red");
resetColorOnMouseOut(rect2, originalColor);
changeColorOnMouseOver(rect3, "red");
resetColorOnMouseOut(rect3, originalColor);
changeColorOnMouseOver(rect4, "red");
resetColorOnMouseOut(rect4, originalColor);
changeColorOnMouseOver(rect5, "red");
resetColorOnMouseOut(rect5, originalColor);
changeColorOnMouseOver(rect6, "red");
resetColorOnMouseOut(rect6, originalColor);
changeColorOnMouseOver(rect7, "red");
resetColorOnMouseOut(rect7, originalColor);
changeColorOnMouseOver(rect8, "red");
resetColorOnMouseOut(rect8, originalColor);
changeColorOnMouseOver(rect9, "red");
resetColorOnMouseOut(rect9, originalColor);
changeColorOnMouseOver(rect10, "red");
resetColorOnMouseOut(rect10, originalColor);
changeColorOnMouseOver(rect11, "red");
resetColorOnMouseOut(rect11, originalColor);
changeColorOnMouseOver(rect12, "red");
resetColorOnMouseOut(rect12, originalColor);
changeColorOnMouseOver(rect13, "red");
resetColorOnMouseOut(rect13, originalColor);
changeColorOnMouseOver(rect14, "red");
resetColorOnMouseOut(rect14, originalColor);
changeColorOnMouseOver(rect15, "red");
resetColorOnMouseOut(rect15, originalColor);
changeColorOnMouseOver(rect16, "red");
resetColorOnMouseOut(rect16, originalColor);


// SVG 요소를 가져옵니다.
const svg = document.querySelector("#인천");

// 텍스트 요소를 생성합니다.
const text = document.createElementNS("http://www.w3.org/2000/svg", "text");
text.textContent = "마우스를 올려보세요"; // 원하는 텍스트 추가
text.setAttribute("x", "10"); // X 좌표
text.setAttribute("y", "180"); // Y 좌표
text.setAttribute("fill", "black"); // 텍스트 색상
text.style.display = "none"; // 초기에는 숨겨둡니다

// 텍스트를 SVG에 추가합니다.
svg.appendChild(text);

// 마우스 오버 이벤트에 대한 함수를 정의합니다.
function onMouseOver() {
  // 마우스 오버 시 텍스트를 표시합니다.
  text.style.display = "block";
}

// 마우스 아웃 이벤트에 대한 함수를 정의합니다.
function onMouseOut() {
  // 마우스 아웃 시 텍스트를 숨깁니다.
  text.style.display = "none";
}

// 마우스 오버 이벤트와 마우스 아웃 이벤트에 함수를 연결합니다.
rect.addEventListener("mouseover", onMouseOver);
rect.addEventListener("mouseout", onMouseOut);
// 상단 좌측 이미지영역 =====================
var mainImg;
var dots;
var dot;
var dotIdx;

// 이미지 변수 ==============================
var mainImg_str;
var mainImg_arr;

// 상단 우측 설명영역 ========================
var price;
var pdname;

// 설명 이미지 영역 ==========================
var explain_images;
// 설명 이미지 변수 ==========================
var explain_images_arr;

// 관심상품 아이콘 상태전환
var interestBtn;
let prjPath;

function mInit(mypath){
	prjPath = mypath + "/shopFrame";
	imgPath = prjPath + "/img";
    dotIdx = 0;
    // 엘리먼트 객체화 =====================
    mainImg = document.querySelector("#explain_top_mainImg > img"); // 상품 이미지
    dots = document.getElementById("explain_top_subImg"); // 상품 서브이미지
    price = document.getElementById("explain_price"); // 상품 가격
    pdname = document.getElementById("explain_name"); // 상품명
    interestBtn = document.getElementById("keep"); // 관심상품 아이콘
    navi = document.getElementById("explain_navi");
    
    explain_images = document.getElementById("explain_images");

    // 이미지 가져오기 =====================
    mainImg_str = document.getElementById("productImg").value; // 문자열 추출
    mainImg_arr = mainImg_str.substring( // DB에 저장된 문자열을 배열로 다시 변환
        mainImg_str.indexOf("[")+1, mainImg_str.lastIndexOf("]")
    ).split(",");

    // 좌측 상단 이미지 삽입
    mainImg.src = imgPath + mainImg_arr[dotIdx];

    // fade 적용
    mainImg.style.animation = "fade 1.5s ease";

    // 좌측 상단 서브 이미지(도트) 삽입
    dots.innerHTML = ""; // dots 엘리먼트 초기화
    for(let i = 0; i < mainImg_arr.length; i++){
        dots.innerHTML +=
        `<img src = "${imgPath + mainImg_arr[i]}" class = "explain_top_subImg_dots"
         onclick = selectDot(${i})>`;
    }
    
    // explain_images 영역 이미지 삽입
    explain_images.innerHTML = "";
    for(let i = 0; i < mainImg_arr.length; i++){
		explain_images.innerHTML +=
		`<img src = "${imgPath + mainImg_arr[i]}">`;
	}

    // 도트 선택 초기화
    dot = document.getElementsByClassName("explain_top_subImg_dots");
    for(let i = 0; i < dot.length; i++){
        dot[i].style.opacity = 0.4;
    }
    dot[dotIdx].style.opacity = 1;
    
    let pdPrice = document.getElementById("price").value;
    price.innerHTML =  parseInt(pdPrice).toLocaleString("ko-KR") +"원"; 
    pdname.innerHTML = document.getElementById("pdname").value;
}
/* 이전, 다음 버튼 =====================
*/
function prevNextBtn(n){
    dotIdx += n;
    if(dotIdx == mainImg_arr.length)
        dotIdx = 0;
    if(dotIdx < 0)
        dotIdx = mainImg_arr.length - 1;
    mainImg.src = imgPath + mainImg_arr[dotIdx];
    for(let i = 0; i < dot.length; i++){
        dot[i].style.opacity = 0.4;
    }
    dot[dotIdx].style.opacity = 1;
    animationReload();
}
/* 도트 이미지 선택 =======================
*/
function selectDot(idx){
    dotIdx = idx;
    mainImg.src = imgPath + mainImg_arr[dotIdx];
    for(let i = 0; i < dot.length; i++){
        dot[i].style.opacity = 0.4;
    }
    dot[dotIdx].style.opacity = 1;
    animationReload();
}

/* 애니메이션 리로드
*/
function animationReload(){ // 상품 이미지 애니메이션
    if(mainImg.style.animationName == "fade") mainImg.style.animation = "refade 1.5s ease";
    else mainImg.style.animation = "fade 1.5s ease";
}

/* 관심상품 상태
*/
function iState(interestState){
    if(interestState != 0){
        interestBtn.style.display = "inline";
    } else {
		interestBtn.style.display = "none";
	}
}

/* 관심상품 등록
*/
function manageInterest(contextPath, obj){
	prjPath = contextPath + "/CtrlPd.do?";
	
	let product_code = document.getElementById("product_code").value;
	prjPath += "product_code="+product_code;
	
	let product_name = document.getElementById("pdname").value;
	prjPath += "&product_name="+product_name;
	
	let product_img = document.getElementById("product_img");
	prjPath += "&product_img="+product_img;
	
	if(obj.value != 0){ // jsp의 interestState가 0이 아닐때 삭제 페이지 이동
		prjPath += "&page=proInterest_del";	
		//document.forms[1].submit();
	} else if(obj.value == 0) { // 0이면 관심상품 추가 페이지로 이동
		prjPath += "&page=proInterest";
	}
	
	let xhttp = new XMLHttpRequest();
	xhttp.onload = function() {
		if(this.responseText.search(/로그인/igm) != -1){
			location.href = contextPath + "/CtrlMember.do?page=pageLog&msg="+this.responseText;
			return;
		}
		alert(this.responseText);
	}
	
	xhttp.open("GET", prjPath);
	xhttp.send();
	
	history.go();
}


/* 구매 페이지 이동
*/
function goToBuyPage(){
	let selectOption = document.getElementById("product_list");
	if(selectOption.value == "no"){
		alert("사이즈를 선택하세요");
		return;
	}
	document.getElementById("pagePd").value = "pageBuy";
	document.forms[1].submit();
}

function countChk(obj){
	if(obj.value < 1){
		alert("최소 1개입니다");
		obj.value = 1;
	}
}
/* 장바구니 이동
*/
function putItemOnCart(){
	document.getElementById("pagePd").value = "proCart";
	document.forms[1].submit();
}
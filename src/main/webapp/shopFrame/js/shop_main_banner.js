var bannerImg;
var idx;

var bannerTimeout;
var pushState;

var dots;
var dot;

let prjPath;

const bannerImgArr = [
    ["/banner/main_banner1.webp", "shoe", ""],
    ["/banner/main_banner2.jpg", "shirt", "supreme"],
    ["/banner/main_banner3.webp", "phone", ""],
    ["/banner/main_banner4.webp", "shoe", "나이키"],
    ["/banner/main_banner5.webp", "watch", ""]
];

function bannerInit(path){
    prjPath = path;
    idx = 0; // 인덱스 초기화
    pushState = true; // 누름 상태 초기화
    // 엘리먼트 객체화
    bannerImg = document.querySelector("#main_banner > img");
    dots = document.getElementById("banner_dots");
    dots.innerHTML = "";
    for(let i = 0; i < bannerImgArr.length; i++)
        dots.innerHTML += `<span class = "banner_dot" onclick = "chooseIndex(${i})"></span>`;

    dot = dots.getElementsByClassName("banner_dot");
    bannerImg.src = prjPath + "/img" + bannerImgArr[idx][0];
    bannerImg.addEventListener("click", function() {
		bannerClick(idx);
	});
    dotInit();
    bannerSlide()
}

function dotInit(){ // 도트 초기화
    for(let i = 0; i < dot.length; i++)
        dot[i].style.backgroundColor = "white";
    dot[idx].style.backgroundColor = "gray";
}

function prevBtn(){
    clearTimeout(bannerTimeout);
    if(idx < 0)
        idx = bannerImgArr.length - 1;
    else idx--;
    pushState = true;
    bannerSlide();
}
function nextBtn(){
    clearTimeout(bannerTimeout);
    if(idx == bannerImgArr.length)
        idx = 0;
    else idx++;
    pushState = true;
    bannerSlide();
}

function chooseIndex(n){
    clearTimeout(bannerTimeout);
    idx = n;
    pushState = true;
    bannerSlide();
}

function bannerSlide(){
    if(pushState == false)
        idx++;
    if(idx == bannerImgArr.length)
        idx = 0;
    if(idx < 0)
        idx = bannerImgArr.length - 1;
    pushState = false;

    if(bannerImg.style.animationName == "fade") bannerImg.style.animation = "refade 1s ease";
    else bannerImg.style.animation = "fade 1s ease";

    bannerImg.src = prjPath + "/img" + bannerImgArr[idx][0];
    bannerImg.addEventListener("click", function() {
		bannerClick(idx);
	});
    dotInit();
    bannerTimeout = setTimeout(bannerSlide, 3000);
}

// 배너 클릭 이벤트
function bannerClick(idx) {
	document.getElementById("product_code").value = "0";
	document.getElementById("pagePd").value = "pageCategory";
	document.getElementById("category").value = bannerImgArr[idx][1];
	if(bannerImgArr[idx][2] == "")
		document.getElementById("brand").name = "";
	else {
		document.getElementById("brand").name = "brand";
		document.getElementById("brand").value = bannerImgArr[idx][2];
	}
	document.forms[1].submit();
}
/*let bogi;
let bogi1;
let bogiButton;
var chk=1;*/

var product_code;

//------------------------------------------------------------------------------------
/*
function thebogi(){
	bogi = document.getElementsByClassName("productNone");//두번재 상품줄 클래스객체
	bogi1 = document.getElementsByClassName("productNone1");//세번쨰 상품줄 클래스객체
	bogiButton = document.getElementsByClassName("thebogiButton");//더보기버튼 클래스 객체
	if(chk>1&&(bogi1[0].style.display= "none")){
		bogi1[0].style.display = "block";	
		bogiButton[0].style.display = "none";	
		chk=1;
	}
	
	else if(bogi[0].style.display = "none"){
		bogi[0].style.display = "block";	
		chk++;
	}
}*/

/* 브랜드 선택 시 브랜드에 맞는 상품만 출력
*/
function selectBrand(path, category, brand){
	let prjPath = path + "/CtrlPd.do?";
	location.href = prjPath + "page=pageCategory&category="+category+"&brand="+brand;
}
let main;
let img;
let name;
let size;


function headerInit(){
	main = document.getElementsByClassName("main");
	size = document.getElementById("size");
	img = document.getElementsByClassName("productImg");

	if(size != null)
		for(let i=0; i < size.value; i++){
			let imgAry = img[i].innerText.substring(img[i].innerText.indexOf("[")+1, img[i].innerText.lastIndexOf("]")).split(",");
			
			img[i].style.backgroundImage = "url("+imgAry+")";
			img[i].innerHTML = "";
		}
}

/* 상품 클릭 시 페이지 이동 ==============
*/
function goWithProductCode(path, pdcode){
	let prjPath = path + "/CtrlPd.do";
	document.forms[1].action = prjPath;
	product_code = document.getElementById("product_code");
	product_code.value = pdcode;
	alert(pdcode);
	document.forms[1].submit();
}
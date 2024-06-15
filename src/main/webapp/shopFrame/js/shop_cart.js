var sendImg;
var sendSize;
var sendCode;
var sendCount;
var sendName;

function mInit(){
	sendImg = document.getElementById("sendImg");
	sendSize = document.getElementById("sendSize");
	sendCode = document.getElementById("sendCode");
	sendCount = document.getElementById("sendCount");
	sendName = document.getElementById("sendName");
}
function buyNow(pdCode, idx, pdImg){
	sendImg.value = pdImg;
	sendSize.value = "270";
	sendCode.value = pdCode;
	sendCount.value = document.getElementsByClassName("items_name")[idx].innerHTML.split(/x/ig)[1].trim();
	sendName.value = document.getElementsByClassName("items_price")[idx].innerHTML;
	document.getElementById("pagePd").value = "pageBuy";
	//document.forms[1].action = "./shop_buy.jsp";
	document.forms[1].submit();
}
function goExplain(pdCode, msg){
	if(msg.search(/삭제/ig) >= 0){
		alert("삭제된 상품입니다.");
		return;
	}
	sendCode.value = pdCode;
	sendCount.value = 1;
	document.getElementById("pagePd").value = "pageExplain";
	//document.forms[1].action = "./shop_explain.jsp";
	document.forms[1].submit();
}
function deleteItem(pdCode){
	let path = document.forms[1].action;
	sendCode.value = pdCode;
	let xhttp = new XMLHttpRequest();
	xhttp.onload = function() {
		alert(this.responseText);
	}
	xhttp.open("GET", path+"?page=proCartDel&product_code="+pdCode);
	xhttp.send();
	history.go();
}
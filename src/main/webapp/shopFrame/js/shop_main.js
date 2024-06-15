var product_code;

function showMsg(msg){
	if(msg != "null" && msg.length != 0) {
		alert(msg);
	}
}


function goExplain(ctrlPath, pdCode){
	document.getElementById("pagePd").value = "pageExplain";
	product_code = document.getElementById("product_code");
	product_code.value = pdCode;
	//document.forms[1].action = ctrlPath + "/CtrlPd.do";
	document.forms[1].submit();
}
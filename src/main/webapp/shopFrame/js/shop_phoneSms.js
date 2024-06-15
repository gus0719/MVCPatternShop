function mInit() {
	document.getElementById("Log_phone").focus();
	if (document.getElementById("msg").value != null) {
		alert(document.getElementById("msg").value);
	}
}

function phoneFind() {
	document.getElementById("page").value = 'pageSms';
	alert(document.getElementById("page").value);
	alert(document.getElementById("user_cate").value);
	//폰번호값을 히든값에 저장
	document.getElementById("phone").value = document.getElementById("Log_phone").value;

	alert(document.getElementById("user_phone").value);

	document.forms[0].submit();
}

function controlSend(page) {
	document.getElementById("page").value = page;
	document.getElementsByTagName("form")[0].submit();
}
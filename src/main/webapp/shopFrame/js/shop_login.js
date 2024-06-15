function mInit(){
	document.getElementById("Log_Id").focus();
	if(document.getElementById("msg").value!=null){
		alert(document.getElementById("msg").value);
	}
}

function loginSend(){
	document.getElementById("user_id").value = document.getElementById("Log_Id").value;
	document.getElementById("user_pwd").value = document.getElementById("Log_Pwd").value;
	document.forms[0].submit();
}

function controlSend(page){
	document.getElementById("page").value = page;
	document.getElementsByTagName("form")[0].submit();
}
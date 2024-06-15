	function mInit(){
		document.getElementById("Log_phone").focus();
		if(document.getElementById("msg").value!=null){
			alert(document.getElementById("msg").value);
		}
	}

	function idFind(id){
		alert("ss");
		//아이디 찾기인지 비밀번호 찾기인지 카테고리히든값에 저장
		document.getElementById("user_cate").value = id;
		//page 카테고리 지정
		document.getElementById("page").value = 'pageSms';
		//폰번호값을 히든값에 저장
		document.getElementById("user_phone").value = document.getElementById("Log_phone").value;
		document.forms[0].submit();
	}
	function controlSend(page){
	document.getElementById("page").value = page;
	document.getElementsByTagName("form")[0].submit();
}
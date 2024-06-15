let txt;

function mInit(){
	txt =  document.getElementsByClassName("txt");
	
	if(document.getElementById("checkbox").value=="true"){
		document.getElementById("msgtrue").checked = true;
	}else{
		document.getElementById("msgfalse").checked = true;
	}
	document.getElementById("check").value
}

function mChange(n){
	if(txt[n-1].disabled){
		txt[n-1].disabled = false;
		txt[n-1].focus();
	}else{
		if(n==1){
			document.getElementById("column").value = "user_id";
		}else if(n==2){
			document.getElementById("column").value = "user_pwd";
		}else if(n==3){
			document.getElementById("column").value = "user_name";
		}else if(n==4){
			document.getElementById("column").value = "user_email";
		}else if(n==5){
			document.getElementById("column").value = "user_phone";
		}else if(n==6){
			document.getElementById("column").value = "user_addr";
		}
		document.getElementById("up_column").value = txt[n-1].value;
		document.getElementsByTagName("form")[0].submit();
	}
}

function userDel(){
	let del = confirm("정말 탈퇴하시겠습니까?");
	if(del){
		document.getElementById("userDel").value = "1";
		document.getElementsByTagName("form")[0].submit();
	}
}

function check(b){
	if(b=="true"){
		alert("광고에 동의 하셨습니다.")
		document.getElementById("check").value = true;
		document.getElementById("msgtrue").checked = true;
	}else{
		alert("광고에 비동의 하셨습니다.")
		document.getElementById("check").value = false;
		document.getElementById("msgfalse").checked = true;
	}
	document.getElementsByTagName("form")[0].submit();
}
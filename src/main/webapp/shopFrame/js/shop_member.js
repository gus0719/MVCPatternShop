let pwdchk = ["!","@","$","%","^","&","*","?"];
let b=true;

function mInit(){
	if(document.getElementById("phone").value=="null"){
	document.getElementById("page").value = 'pagePhoneSms';
	//document.forms[0].action =  "./shop_phoneSms.jsp";
	document.forms[0].submit();
	}
	document.getElementById("Log_Id").focus();
}

function mSend(){
	document.getElementById("Log_Id").value = document.getElementById("Id").value;
	document.getElementById("Log_Pwd").value = document.getElementById("Pwd").value;
	document.getElementById("Log_name").value = document.getElementById("name").value;
	document.getElementById("Log_email").value = document.getElementById("email").value;
	document.getElementById("Log_phone").value = document.getElementById("phone").value;
	document.getElementById("Log_addr").value = document.getElementById("addr").value;
	document.getElementById("Log_rank").value = document.getElementById("rank").value;
	
		if(document.getElementById("Log_Id").value.length > 8){
			b=false;
			alert("아이디는 8자 이내로만 적으세요.");
		}
		
		else if(document.getElementById("Log_Pwd").value.length < 8 || document.getElementById("Log_Pwd").value.length > 16){
			b=false;
			alert("비밀번호는 8자 이상 16자 미만으로 적으세요.");
		}
		
		else if(!(document.getElementById("Log_Pwd").value.length < 8 || document.getElementById("Log_Pwd").value.length > 16)){
			la:for(let i=0; i<pwdchk.length;i++){
				if(document.getElementById("Log_Pwd").value.indexOf(pwdchk[i]) == -1){
					b=true;
				}else {
					b=false;
					break la;
				}
			}
			if(b){
				alert("비밀번호에 특수 문자를 포함하여 적으세요.");
				b=false;
			}else b=true;
		}
		
		if(parseInt(document.getElementById("Log_email").value.indexOf("@"))== -1){
			b=false;
			alert("이메일에 @를 넣으세요.");
		}
		
		if(document.getElementById("Log_rank").value=="판매자" || document.getElementById("Log_rank").value=="구매자"){
		}else{
			b = false;
			alert("판매자 혹은 구매자만 적으세요.");
		}
		
		if(!document.getElementById("chkbox1").checked){
			alert("동의를 눌러야 다음으로 진행됩니다.")
			b = false;
		}
		
		if(b){
			document.getElementById("Log_rank").value += "1"+document.getElementById("chkbox2").checked;
			alert(document.getElementById("Log_rank").value)
			//document.forms[0].action =  "./shop_memberAccept.jsp";
				document.getElementById("page").value = 'proMember';
				alert(document.getElementById("page").value);
			document.forms[0].submit();
		}
		b=true;
}

function controlSend(page){
	document.getElementById("page").value = page;
	document.getElementsByTagName("form")[0].submit();
}
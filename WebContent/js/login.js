var code;
function createCode(){
    code = "";
    var codeLength = 4;
    var codeV = document.getElementById("code");
    var random = new Array(0,1,2,3,4,5,6,7,8,9,'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R', 'S','T','U','V','W','X','Y','Z');
    for(var i = 0; i < codeLength; i++){
        var index = Math.floor(Math.random()*36);
        code += random[index];
    }
    codeV.value = code;
}
function validate(){
    var oValue = document.getElementById("checkcode").value.toUpperCase();
    var icon =document.getElementById("checkicon");
    var val=document.getElementById("val");
    if(oValue == 0){
        icon.className="fa fa-close";
        icon.style.color="red";
        val.value="false";
    }else if(oValue != code){
        icon.className="fa fa-close";
        icon.style.color="red";
        val.value="false";
        oValue = "";
        createCode();
    }else{
        icon.className="fa fa-check";
        icon.style.color="green";
        val.value="true";
    }

}// JavaScript Document

function logined(i,s) {
	if(i==1)window.location.href="user_info.jsp?uid="+s;
}
function Init_fail(i) {
    if(i==1){
        obj = document.getElementById("user");
        obj.style.boxShadow="inset 0px 0px 10px red";
        obj.placeholder = "用户名已存在";
        obj.value = "";
        obj = document.getElementById("password");
        obj.style.boxShadow="inset 0px 0px 10px red";
        obj.placeholder = "";
        obj.value = "";
    }
}

function checkInput(i){
    var ObjUser=document.getElementById("user");
    var ObjPW=document.getElementById("password");
    var oValue = document.getElementById("checkcode").value.toUpperCase();
    var icon =document.getElementById("checkicon");
    if(ObjUser.value==""){
        ObjUser.style.boxShadow="inset 0px 0px 10px red";
        i.disabled="disabled";
    }
    if(ObjPW.value==""){
    	ObjPW.style.boxShadow="inset 0px 0px 10px red";
        i.disabled="disabled";
    }
    if(oValue != code){
    	 icon.className="fa fa-close";
         icon.style.color="red";
         val.value="false";
         i.disabled="disabled";
    }
}
function inputworry(flag){
    if(flag==0) {
        obj = document.getElementById("user");
        obj.style.boxShadow="inset 0px 0px 10px red";
        obj.placeholder = "用户名与密码不匹配";
        obj.value = "";
        obj = document.getElementById("password");
        obj.style.boxShadow="inset 0px 0px 10px red";
        obj.placeholder = "用户名与密码不匹配";
        obj.value = "";
    }
    else if(flag==1){
        document.getElementById("checkicon").className="fa fa-close"
    }
}
function inputin(i){
	var loginbtn=document.getElementById("button_left");
    var initbtn=document.getElementById("button_right");
    if(i==1){
        obj=document.getElementById("user");
        obj.style.boxShadow="inset 0px 0px 10px gray";
        obj.placeholder="用户名";
        if(obj.placeholder=="用户名与密码不匹配")obj.value="";
        loginbtn.disabled="";
        initbtn.disabled="";
    }
    else if(i==2){
        obj=document.getElementById("password");
        obj.style.boxShadow="inset 0px 0px 10px gray";
        obj.placeholder="密码";
        if(obj.placeholder=="用户名与密码不匹配")obj.value="";
        loginbtn.disabled="";
        initbtn.disabled="";
    }
    else {
    	 loginbtn.disabled="";
         initbtn.disabled="";
    }
}
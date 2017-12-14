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
function inputworry(flag){
    if(flag==0) {
        obj = document.getElementById("user");
        obj.style.background = "red";
        obj.placeholder = "用户名与密码不匹配";
        obj.value = "";
        obj = document.getElementById("password");
        obj.style.background = "red";
        obj.placeholder = "用户名与密码不匹配";
        obj.value = "";
    }
    else if(flag==1){
        document.getElementById("checkicon").className="fa fa-close"
    }
}
function inputin(i){
    if(i==1){
        obj=document.getElementById("user");
        obj.style.background="rgba(255,255,255,0.80)";
        obj.placeholder="用户名";
        if(obj.placeholder=="用户名与密码不匹配")obj.value="";
    }
    else{
        obj=document.getElementById("password");
        obj.style.background="rgba(255,255,255,0.80)";
        obj.placeholder="密码";
        if(obj.placeholder=="用户名与密码不匹配")obj.value="";
    }
}
function logined(i,s) {
	if(i==1)window.location.href="user_info.jsp?uid="+s;
}
function Init_fail(i) {
    if(i==1){
        obj = document.getElementById("user");
        obj.style.background = "red";
        obj.placeholder = "用户名已存在";
        obj.value = "";
        obj = document.getElementById("password");
        obj.style.background = "red";
        obj.placeholder = "";
        obj.value = "";
    }
}
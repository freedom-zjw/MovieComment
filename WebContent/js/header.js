function moveLogin(i){
    if(i!="Login"){
        document.getElementById("logins").style.paddingRight="100px";
        document.getElementById("logout").style.display="block";
    }
}
function outLogin(i){
    if(i!="Login"){
        document.getElementById("logins").style.paddingRight="30px";
        document.getElementById("logout").style.display="none";
    }
}
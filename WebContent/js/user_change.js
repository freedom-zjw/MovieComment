function checkInput(){
    Obj=document.getElementsByName("name");
    if(Obj[0].value==""){
        document.getElementById("hitInput").style.display="inline";
        Obj[0].style.boxShadow="inset 0px 0px 10px red";
        document.getElementById("save").disabled="disabled";
    }
}
function nameInput(){
    Obj=document.getElementsByName("name");
    document.getElementById("hitInput").style.display="none";
    Obj[0].style.boxShadow="inset 0px 0px 5px gray";
    document.getElementById("save").disabled="";
}
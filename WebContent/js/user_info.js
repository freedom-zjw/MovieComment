function onstart(cnt1,cnt2,cnt3,cnt4,cnt5,cnt6){
    obj=document.getElementsByClassName("info_item");
    if(cnt1==0){
        document.getElementById("info_pre").style.display="none";
        document.getElementById("info_tag").style.opacity="1";
    }	if(cnt3==0){
        document.getElementById("commit_pre").style.display="none";
        document.getElementById("commit_tag").style.opacity="1";
    }	if(cnt5==0){
        document.getElementById("like_pre").style.display="none";
        document.getElementById("like_tag").style.opacity="1";
    }  if(cnt2<3)document.getElementById("info_next").style.display="none";	if(cnt4<3)document.getElementById("commit_next").style.display="none";
    if(cnt6<3)document.getElementById("like_next").style.display="none";
    for(var i=cnt2;i<3;i++){
        obj[i].style.display="none";
    }
    for(var i=cnt4+3;i<6;i++){
        obj[i].style.display="none";
    }
    for(var i=cnt6+6;i<9;i++){
        obj[i].style.display="none";
    }
}
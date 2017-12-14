// JavaScript Document

function onmovestart(pos){
	obj = document.getElementsByName("real_star");
    for(var i=0;i<pos;i++){
       	obj[i].className="fa fa-star";
    }
	for(var i=pos;i<obj.length;i++){
        obj[i].className="fa fa-star-o";
    }
	obj1=document.getElementsByName("level");
	obj1[pos-1].checked="checked";	
}
function star_add(pos,cnt){
	var star_="<i class='fa fa-star'></i>"
	var out=" ";
	obj = document.getElementsByName("star_add");
	for(var i=0;i<cnt;i++){
		out=out+star_;
	}
	obj[pos].innerHTML=out;	
}
function onstart(cnt1,cnt2){
    obj=document.getElementsByName("list_item");
    if(cnt1==0)document.getElementById("pre_page").hidden="hidden";
    if(cnt2<5)document.getElementById("next_page").hidden="hidden";
    for(var i=cnt2;i<obj.length;i++){
        obj[i].hidden="hidden";
    }
}
function onmoveli(i) {
    var  obj = document.getElementsByName("show_li");
    obj[i].style.borderRadius="10px";
    obj[i].style.boxShadow="0px 0px 5px rgba(0,131,166,.4)";
}
function outmoveli(i) {
    var  obj = document.getElementsByName("show_li");
    obj[i].style.borderRadius="10px";
    obj[i].style.boxShadow="none";
}

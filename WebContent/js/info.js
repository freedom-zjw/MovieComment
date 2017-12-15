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
function openModal(imgsrc) {
    document.getElementById("display_outer").style.display = "block";
    document.getElementById("imgs").src=imgsrc;
}

function closeModal() {
    document.getElementById("display_outer").style.display = "none";
}

function setdisplayimg(src0,src1,src2,src3,src4) {
    var Obj=document.getElementsByClassName("openimg");
    if(src0!="")Obj[0].style.display="inline";
    if(src1!="")Obj[1].style.display="inline";
    if(src2!="")Obj[2].style.display="inline";
    if(src3!="")Obj[3].style.display="inline";
    if(src4!="")Obj[4].style.display="inline";

}

function setImagePreview() {
    var docObj=document.getElementById("file");
    var imgObjPreview=document.getElementById("imgs");
    var bkObj=document.getElementById("display_outer");
    if(docObj.files &&docObj.files[0])
    {
        imgObjPreview.src = window.URL.createObjectURL(docObj.files[0]);
        bkObj.style.display = "block";
    }

}
function photoDisplay(){
    document.getElementById("photo_outer").style.display = "block";
    var h=document.getElementById("photos").height/2;

    document.getElementById("prebtn").style.top=h+10+"px";
    document.getElementById("nextbtn").style.top=h+10+"px";
}
function photoclose(){
    document.getElementById("photo_outer").style.display = "none";
}
function movemainphoto(){
    document.getElementById("morephoto").style.display = "block";
}
function outmainphoto(){
    document.getElementById("morephoto").style.display = "none";

}
function nextPhoto() {
    if(photo_pos<photo_src.length-1){
        photo_pos=photo_pos+1;
        document.getElementById("photos").src=photo_src[photo_pos];
        var h=document.getElementById("photos").height/2;

        document.getElementById("prebtn").style.top=h+10+"px";
        document.getElementById("nextbtn").style.top=h+10+"px";
    }
}
function prePhoto() {
    if(photo_pos>0){
        photo_pos=photo_pos-1;
        document.getElementById("photos").src=photo_src[photo_pos];
        var h=document.getElementById("photos").height/2;

        document.getElementById("prebtn").style.top=h+10+"px";
        document.getElementById("nextbtn").style.top=h+10+"px";
    }
}
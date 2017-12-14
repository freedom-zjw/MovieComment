function setImagePreview() {
    var docObj=document.getElementById("file");
    var imgObjPreview=document.getElementById("preview");
    if(docObj.files &&docObj.files[0])
    {
        imgObjPreview.src = window.URL.createObjectURL(docObj.files[0]);
        imgObjPreview.style.opacity=1;
    }

}
function sexCheck(i) {
    var Obj=document.getElementsByName("sex");
    Obj[i].checked="checked";
}
function imgCheck(i) {
    if(i==1)document.getElementById("preview").style.opacity="1";
}
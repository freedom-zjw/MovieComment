var page_flag=0;
    function buttonOnclick(i){
        var Obj=document.getElementById("welcome");
        var UserInfo=document.getElementById("user_info");
        var MovieInfo=document.getElementById("movie_info");
        var Info=document.getElementById("info");
        var Page=document.getElementById("page");
        if(i==0){
            Obj.style.display="none";
            UserInfo.style.display="block";
            MovieInfo.style.display="none";
            Info.style.display="none";
            Page.style.display="block";
            page_flag=0;
        }
        else if(i==1){
            Obj.style.display="none";
            UserInfo.style.display="none";
            MovieInfo.style.display="block";
            Info.style.display="none";
            Page.style.display="block";
            page_flag=1;
        }
        else if(i==2){
            Obj.style.display="none";
            UserInfo.style.display="none";
            MovieInfo.style.display="none";
            Info.style.display="block";
            Page.style.display="block";
            page_flag=2;
        }
        else{
           
        }
    }
    function onStart(cnt1,cnt2,cnt3,flag){
        var Obj=document.getElementsByClassName("buttonsub");
        for(var i=cnt1*3;i<24;i++){
            Obj[i].disabled="disabled";
        }
        /*for(i=cnt2*2+24;i<40;i++){
            Obj[i].disabled="disabled";
        }
        for(i=cnt3*2+40;i<56;i++){
            Obj[i].disabled="disabled";
        }*/
        for(i=cnt2+24;i<32;i++){
            Obj[i].disabled="disabled";
        }
        for(i=cnt3*2+32;i<48;i++){
            Obj[i].disabled="disabled";
        }
        if(flag=="0"){
            buttonOnclick(0);
        }
        else if(flag=="1"){
            buttonOnclick(1);
        }
        else if(flag=="2"){
            buttonOnclick(2);
        }
    }
    
    function delMovie(pg1,pg2,pg3,mid){
    	if(confirm("即将删除电影")){
    		location.href="Console.jsp?info_pgno="+pg1+"&movie_pgno="+pg2+"&user_pgno="+pg3+"&flag=1&mid="+mid;
    	}
    }
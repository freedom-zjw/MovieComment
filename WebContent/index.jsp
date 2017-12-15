<%--
  Created by IntelliJ IDEA.
  User: Chonor
  Date: 2017/12/11
  Time: 22:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*,java.sql.*"%>
<%  request.setCharacterEncoding("utf-8");%> 
<jsp:useBean id="Userdb" class="com.group.bean.Userdb" scope="page"/> 
<%
    String user_id = (String)session.getAttribute("user_id");//用户id
    String Login="Login";//登陆后显示用户名
    String Login_src="login.jsp";
    if(user_id!=null){
    	Login = (String)session.getAttribute("account");
    	Login_src="user_info.jsp";
    }
	
    String Logout="";
    Logout=request.getParameter("logout");
    if(Logout.equals("true")){
    	///////退出
    }
    
    String display_src[]={"tmp.jpg","onesheet.jpg","tmp.jpg","onesheet.jpg"};//4个 16:9的图片
    String display_id[]={"1","2","3","4"};//上面4个对应的id
    String featured_img_src[]={"onesheet.jpg","onesheet.jpg","onesheet.jpg","onesheet.jpg"};//精选图片
    String featured_name[]={"name1","name2","name3","name4"};//精选电影名
    String featured_id[]={"1","2","3","4"};//精选点击后转跳,只需要填id


    String today="https://www.youtube.com/embed/vn9mMeWcgoM";//今日推荐
    String today_id="10";//今日推荐点击转跳
    String today_name=".....";//今日推荐名字
    String today_info="";//今日推荐的简介
    String today_src="";//今日推荐的图片
%>
<!DOCTYPE HTML>
<html  lang="zh-cn">
<head>
    <meta charset="utf-8">
    <title>GoodMovie</title>
    <link rel="stylesheet" type="text/css" href="css/font-awesome.css" />
    <link rel="stylesheet" type="text/css" href="css/index_.css" />
    <link rel="stylesheet" type="text/css" href="css/header.css">
    <script src="js/header.js"></script>
</head>
<body>
<div id="bk_outer">
    <img src="<%=display_src[0]%>" id="main_bk">
</div>

<div id="header_outer">
    <div id="header" class="wrapper">
        <p>GoodMovie</p>
        <a href="<%=Login_src%>" id="logins" onMouseMove="moveLogin('<%=Login%>')" onMouseOut="outLogin('<%=Login%>')"><i class="fa fa-user-circle-o"></i> <%=Login%></a>
        <a href="index.jsp?logout=true" id="logout" onMouseMove="moveLogin('<%=Login%>')" onMouseOut="outLogin('<%=Login%>')">退出</a>
    </div><!--header-->
</div> <!--header_outer-->

<div id="nav_outer">
    <div id="nav_in" class="wrapper">
        <div id="logo"><a href="index.jsp"></a></div>
        <div id="main_nav">
            <ul id="nav">
                <li><a href="search.jsp?types=movie">电影</a>
                    <ul class="subnav">
                        <li><a href="search.jsp?types=movie&sort=hot">时下流行</a></li>
                        <li><a href="search.jsp?types=movie&sort=data">新片上映</a></li>
                        <li><a href="search.jsp?types=movie&sort=score">最佳口碑</a></li>
                        <li><a href="search.jsp?types=movie&sort=max">热议影片</a></li>
                    </ul>
                </li>
                <li><a href="search.jsp?types=TV">电视</a>
                    <ul class="subnav">
                        <li><a href="search.jsp?types=TV&sort=hot">时下流行</a></li>
                        <li><a href="search.jsp?types=TV&sort=data">新片上映</a></li>
                        <li><a href="search.jsp?types=TV&sort=score">最佳口碑</a></li>
                        <li><a href="search.jsp?types=TV&sort=max">热议影片</a></li>
                    </ul>
                </li>
                <li><a href="search.jsp?sort=hot">热评影视剧</a></li>
                <li><a href="#">发现</a></li>
            </ul>
        </div>
        <div id="serach">
            <form  action="search.jsp" method="get">
                <input type="text"  name="content" id="content" autocomplete="off" value="">
                <input type="submit" id="submit" name="submit" value="">
                <i class="fa fa-search fa-1x"></i>
            </form>
        </div>
    </div>
</div>

<div id="display_outer">
    <div id="display_in">
        <div id="img_outer">
            <img id="main_img" src="<%=display_src[0]%>" onclick="image_click()">
        </div>
        <div id="display_select">
            <ul class="displaysub">
                <li><a ><i class="fa fa-chevron-circle-left" onclick="onclickpos(0)"></i></a></li>
                <li><a href="#"><i id="select1" class="fa fa-circle-o" onmousemove="mousemovein(1)" ></i></a></li>
                <li><a href="#"><i id="select2" class="fa fa-circle-o" onmousemove="mousemovein(2)" ></i></a></li>
                <li><a href="#"><i id="select3" class="fa fa-circle-o" onMouseMove="mousemovein(3)" ></i></a></li>
                <li><a href="#"><i id="select4" class="fa fa-circle-o" onMouseMove="mousemovein(4)"></i></a></li>
                <li><a><em class="fa fa-chevron-circle-right" onClick="onclickpos(1)"></em></a></li>
            </ul>
        </div>
    </div>
</div>

<div id="featured">
    <div id="featured_sub">
        <p>本周精选</p>
        <ul class="subshow">
            <li name="show_li" onclick="location.href='info.jsp?mid=<%=featured_id[0]%>'" onmousemove="onmoveli(0)" onmouseout="outmoveli(0)"><img src="<%=featured_img_src[0]%>"><a><%=featured_name[0]%></a></li>
            <li name="show_li" onclick="location.href='info.jsp?mid=<%=featured_id[1]%>'" onmousemove="onmoveli(1)" onmouseout="outmoveli(1)"><img src="<%=featured_img_src[1]%>"><a><%=featured_name[1]%></a></li>
            <li name="show_li" onclick="location.href='info.jsp?mid=<%=featured_id[2]%>'" onmousemove="onmoveli(2)" onmouseout="outmoveli(2)"><img src="<%=featured_img_src[2]%>"><a><%=featured_name[2]%></a></li>
            <li name="show_li" onclick="location.href='info.jsp?mid=<%=featured_id[3]%>'" onmousemove="onmoveli(3)" onmouseout="outmoveli(3)"><img src="<%=featured_img_src[3]%>"><a><%=featured_name[3]%></a></li>
        </ul>
    </div>
</div>

<div id="today_outer">
    <div id="today">
        <hr>
        <a href="info.jsp?mid=<%=today_id%>">今日推荐：<%=today_name%></a>
        <iframe width="800" height="400" src="<%=today%>" frameborder="0" gesture="media" allow="encrypted-media" allowfullscreen></iframe>
    </div>
</div>

<div id="footer_outer">
    <div id="footer">

    </div>
</div>
</body>
</html>
<script  type="text/javascript">
    var pos=1;
    document.getElementById("select1").className="fa fa-circle";
    var  obj = document.getElementsByName("show_li");
    function changeSrc(i) {
        if(i==1){
            document.getElementById("main_img").src="<%=display_src[0]%>";
            document.getElementById("main_bk").src="<%=display_src[0]%>";
        }
        else if(i==2){
            document.getElementById("main_img").src="<%=display_src[1]%>";
            document.getElementById("main_bk").src="<%=display_src[1]%>";
        }
        else if(i==3){
            document.getElementById("main_img").src="<%=display_src[2]%>";
            document.getElementById("main_bk").src="<%=display_src[2]%>";
        }
        else if(i==4){
            document.getElementById("main_img").src="<%=display_src[3]%>";
            document.getElementById("main_bk").src="<%=display_src[3]%>";
        }
    }
    function image_click() {
        if(pos==1)window.location.href="info.jsp?mid=<%=display_id[0]%>";
        else if(pos==2)window.location.href="info.jsp?mid=<%=display_id[1]%>";
        else if(pos==3)window.location.href="info.jsp?mid=<%=display_id[2]%>";
        else if(pos==4)window.location.href="info.jsp?mid=<%=display_id[3]%>";
    }
    function mousemovein(i) {
        if (i == 1) {
            document.getElementById("select1").className = "fa fa-circle";
            document.getElementById("select2").className = "fa fa-circle-o";
            document.getElementById("select3").className = "fa fa-circle-o";
            document.getElementById("select4").className = "fa fa-circle-o";
        }
        else if (i == 2) {
            document.getElementById("select1").className = "fa fa-circle-o";
            document.getElementById("select2").className = "fa fa-circle";
            document.getElementById("select3").className = "fa fa-circle-o";
            document.getElementById("select4").className = "fa fa-circle-o";
        }
        else if (i == 3) {
            document.getElementById("select1").className = "fa fa-circle-o";
            document.getElementById("select2").className = "fa fa-circle-o";
            document.getElementById("select3").className = "fa fa-circle";
            document.getElementById("select4").className = "fa fa-circle-o";
        }
        else {
            document.getElementById("select1").className = "fa fa-circle-o";
            document.getElementById("select2").className = "fa fa-circle-o";
            document.getElementById("select3").className = "fa fa-circle-o";
            document.getElementById("select4").className = "fa fa-circle";
        }
        pos = i;
        changeSrc(pos);

    }
    function changepos(){
        pos=pos+1;
        if(pos==5)pos=1;
        if(pos==1){
            document.getElementById("select1").className="fa fa-circle";
            document.getElementById("select4").className="fa fa-circle-o";
        }
        else if(pos==2){
            document.getElementById("select1").className="fa fa-circle-o";
            document.getElementById("select2").className="fa fa-circle";
        }
        else if(pos==3){
            document.getElementById("select3").className="fa fa-circle";
            document.getElementById("select2").className="fa fa-circle-o";
        }
        else {
            document.getElementById("select4").className="fa fa-circle";
            document.getElementById("select3").className="fa fa-circle-o";
        }
        changeSrc(pos);
    }

    function onclickpos(i){
        if(i==1)pos=pos+1;
        else pos=pos-1;
        if(pos==5)pos=1;
        if(pos==0)pos=4;
        mousemovein(pos);
    }
    function onmoveli(i) {
        obj[i].style.borderRadius="10px";
        obj[i].style.boxShadow="0px 0px 5px rgba(0,131,166,.4)";
    }
    function outmoveli(i) {
        obj[i].style.borderRadius="10px";
        obj[i].style.boxShadow="none";
    }
    var t1 = window.setInterval(changepos,10000);
</script>

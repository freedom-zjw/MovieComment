<%--
  Created by IntelliJ IDEA.
  User: Chonor
  Date: 2017/12/13
  Time: 23:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String user_id = (String)session.getAttribute("user_id");//用户id
    String Login="Login";//登陆后显示用户名
    String Login_src="login.jsp";
    if(user_id!=null)Login_src="user_info.jsp";

    /**
     * 提交之后获取
     */
    String name="",sex="",info="",hobby="",img_src="";



    Integer sex_int=2;
    if(sex.equals("man"))sex_int=0;
    else if(sex.equals("woman"))sex_int=1;
    Integer src_flag=0;
    if(img_src!="")src_flag=1;
%>

<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>用户信息</title>

    <link rel="stylesheet" type="text/css" href="css/font-awesome.css" />
    <link href="css/header.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" type="text/css" href="css/user_change.css" />
    <script src="js/face_preview.js"></script>
    <style>

    </style>
</head>

<body>
<div id="header_outer">
    <div id="header" class="wrapper">
        <p>网站名字啊</p>
        <a href="<%=Login_src%>"><i class="fa fa-user-circle-o"></i> <%=Login%></a>
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


<div id="form_outer">
    <form id="infor" action="" method="post" enctype="multipart/form-data">
        <p id="face">
            <label >头像：</label>
            <button disabled>点击上传头像</button>
            <input type="file" name="file" id="file"  onchange="setImagePreview()">
            <img id="preview" src="<%=img_src%>" style="opacity: 0">

        </p>
        <p id="name">
            <label>昵称：</label>
            <input name="name" type="text"  placeholder="新的昵称" value="<%=name%>">
        </p>
        <p id="info">
            <label>简介：</label>
            <textarea name="info" placeholder="修改简介" ><%=info%></textarea>
        </p>
        <p id="sex">
            <label>性别：</label>
            <input type="radio" name="sex" value="man"><i class="fa fa-mars"></i>
            <input type="radio" name="sex" value="woman"><i class="fa fa-venus"></i>
            <input type="radio" name="sex"  value="unkown" checked><i class="fa fa-transgender"></i>
        </p>
        <p id="hobby">
            <label>爱好：</label>
            <textarea name="info" placeholder="爱好"><%=hobby%></textarea>
        </p>
        <p id="btn"><input name="save" class="button" type="submit" value="保存">
            <button name="clear" class="button" type="reset">复位</button></p>


    </form>
    <div id="footer_outer">
        <div id="footer">

        </div>
    </div>
</div>
</body>
</html>
<script>sexCheck(<%=sex_int%>)</script>
<script>imgCheck(<%=src_flag%>)</script>


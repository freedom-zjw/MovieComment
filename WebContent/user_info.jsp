<%--
  Created by IntelliJ IDEA.
  User: Chonor
  Date: 2017/12/14
  Time: 13:41
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
    ResultSet rs = null;
    if(user_id!=null){
    	Login = (String)session.getAttribute("account");
    	Login_src="user_info.jsp";
    	rs = Userdb.queryByAccount(Login);
    	rs.next();
    }
    else{
    	response.sendRedirect("login.jsp");
    }

    /**
     * 个人信息类
     * 数据库拿到
     */
    String name,info,hobby,img_src="image/main_logo.png";//头像;
    name="名字";
    info="简介";
    hobby="爱好";
	if (user_id!=null){
		name = rs.getString("name");
		info = rs.getString("info");
		hobby = rs.getString("hobby");
		img_src = rs.getString("Image_src");
	}
    /**
     * 通知数据库
     *
     * 后面通知翻页
     */
    Integer info_cnt=3;//通知数量  0-3
    String info_name[]={"通知1","通知2","通知3"};
    String info_content[]={"内容1","内容2","内容3"};
    String info_date[]={"1111.11.11","1111.11.11","1111.11.11"};
    Integer info_pgno = 0; //当前通知页号
    String param1 = request.getParameter("info_pgno");
    if(param1 != null && !param1.isEmpty()){
        info_pgno = Integer.parseInt(param1);
    }
    int info_pre = (info_pgno>0)?info_pgno-1:0;
    int info_next = info_pgno+1;

    /**
     * 获取自己的评论信息
     * 评论翻页
     * 其中src为电影封面
     */
    Integer commit_cnt=3;//评论数量  0-3
    String commit_name[]={"评论1","评论2","评论3"};
    String commit_content[]={"内容1","内容2","内容3"};
    String commit_src[]={"图1","图2","图3"};
    String commit_mid[]={"","",""};
    Integer commit_pgno = 0; //当前评论页号
    String param2 = request.getParameter("commit_pgno");
    if(param2 != null && !param2.isEmpty()){
        commit_pgno = Integer.parseInt(param2);
    }
    int commit_pre = (commit_pgno>0)?commit_pgno-1:0;
    int commit_next = commit_pgno+1;

    /**
     * 收藏电影
     * src 为电影封面
     * 之后也是翻页
     */
    Integer like_cnt=3;//收藏数量  0-3
    String like_name[]={"收藏1","收藏2","收藏3"};
    String like_content[]={"内容1","内容2","内容3"};
    String like_src[]={"图1","图2","图3"};
    String like_mid[]={"","",""};
    Integer like_pgno = 0; //当前收藏页号
    String param3 = request.getParameter("like_pgno");
    if(param3 != null && !param3.isEmpty()){
        like_pgno = Integer.parseInt(param3);
    }
    int like_pre = (commit_pgno>0)?commit_pgno-1:0;
    int like_next = commit_pgno+1;
%>



<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>用户资料</title>

    <link rel="stylesheet" type="text/css" href="css/font-awesome.css" />
    <link rel="stylesheet" type="text/css" href="css/header.css" />
    <link rel="stylesheet" type="text/css" href="css/user_info.css" />
    <script src="js/user_info.js"></script>
    <script src="js/header.js"></script>
<body>

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

<div id="userInfo_outer">
    <div id="list">
        <div id="user_info">
            <img  id="user_img" src="<%=img_src%>">
            <p id="user_name"><%=name%></p>
            <div id="user_introduct" class="user_introduct">
                <h3 class="title3">个人简介</h3>
                <p><%=info%></p>
            </div>
            <div id="user_hobby" class="user_introduct">
                <h3 class="title3">个人爱好</h3>
                <p><%=hobby%></p>
            </div>
            <button id="change_info" class="botton" onclick="location.href='user_change.jsp'"> 修改个人信息</button>
        </div>
        <div id="list_item">
            <div class="item">
                <h3 class="list_title">我的通知</h3>
                <p class="tips" id="info_tag">还没有通知</p>
                <div class="info_item">
                    <p class="info_name"><%=info_name[0]%></p>
                    <p class="info_data"><%=info_date[0]%></p>
                    <p class="info_content"><%=info_content[0]%></p>
                </div>
                <div class="info_item">
                    <p class="info_name"><%=info_name[1]%></p>
                    <p class="info_data"><%=info_date[1]%></p>
                    <p class="info_content"><%=info_content[1]%></p>
                </div>
                <div class="info_item">
                    <p class="info_name"><%=info_name[2]%></p>
                    <p class="info_data"><%=info_date[2]%></p>
                    <p class="info_content"><%=info_content[2]%></p>
                </div>
                <div class="pages">
                    <a href="user_info.jsp?info_pgno=<%=info_pre%>&commit_pgno=<%=commit_pgno%>&like_pgno=<%=like_pgno%>" class="botton" id="info_pre">上一页</a>
                    <a href="user_info.jsp?info_pgno=<%=info_next%>&commit_pgno=<%=commit_pgno%>&like_pgno=<%=like_pgno%>"  class="botton" id="info_next">下一页</a>
                </div>
            </div>
            <div class="item">
                <h3 class="list_title">我的评论</h3>
                <p class="tips" id="commit_tag">还没有评论</p>
                <div class="info_item">
                    <img class="movie_img_content" src="<%=commit_src[0]%>">
                    <p class="movie_content"><%=commit_content[0]%></p>
                    <p class="movie_name"><%=commit_name[0]%></p>
                </div>
                <div class="info_item">
                    <img class="movie_img_content" src="<%=commit_src[1]%>">
                    <p class="movie_content"><%=commit_content[1]%></p>
                    <p class="movie_name"><%=commit_name[1]%></p>
                </div>
                <div class="info_item">
                    <img class="movie_img_content" src="<%=commit_src[2]%>">
                    <p class="movie_content"><%=commit_content[2]%></p>
                    <p class="movie_name"><%=commit_name[2]%></p>
                </div>
                <div class="pages">
                    <a href="user_info.jsp?info_pgno=<%=info_pgno%>&commit_pgno=<%=commit_pre%>&like_pgno=<%=like_pgno%>" class="botton" id="commit_pre">上一页</a>
                    <a href="user_info.jsp?info_pgno=<%=info_pgno%>&commit_pgno=<%=commit_next%>&like_pgno=<%=like_pgno%>" class="botton" id="commit_next">下一页</a>
                </div>
            </div>
            <div class="item">
                <h3 class="list_title">我的收藏</h3>
                <p class="tips" id="like_tag">还没有收藏</p>
                <div class="info_item">
                    <img class="movie_img_content" src="<%=like_src[0]%>">
                    <p class="movie_content"><%=like_content[0]%></p>
                    <p class="movie_name"><%=like_name[0]%></p>
                </div>
                <div class="info_item">
                    <img class="movie_img_content" src="<%=like_src[1]%>">
                    <p class="movie_content"><%=like_content[1]%></p>
                    <p class="movie_name"><%=like_name[1]%></p>
                </div>
                <div class="info_item">
                    <img class="movie_img_content" src="<%=like_src[2]%>">
                    <p class="movie_content"><%=like_content[2]%></p>
                    <p class="movie_name"><%=like_name[2]%></p>
                </div>
                <div class="pages">
                    <a href="user_info.jsp?info_pgno=<%=info_pgno%>&commit_pgno=<%=commit_pgno%>&like_pgno=<%=like_pre%>" class="botton" id="like_pre">上一页</a>
                    <a href="user_info.jsp?info_pgno=<%=info_pgno%>&commit_pgno=<%=commit_pgno%>&like_pgno=<%=like_next%>" class="botton" id="like_next">下一页</a>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="footer_outer">
    <div id="footer">

    </div>
</div>
</body>
</html>
<script>onstart(<%=info_pgno%>,<%=info_cnt%>,<%=commit_pgno%>,<%=commit_cnt%>,<%=like_pgno%>,<%=like_cnt%>)</script>

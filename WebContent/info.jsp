<%@ page
	language="java"
	contentType="text/html; UTF-8"
    pageEncoding="UTF-8"
%>
<%
	String user_id = (String)session.getAttribute("user_id");//用户id
    String Login="Login";//登陆后显示用户名
    Integer permissions=0;//用户权限 0普通1管理员
    String Login_src="login.jsp";
    if(user_id!=null)Login_src="user_info.jsp";
    /**
     * 发表评论
     * mid=1&content=&level=5&file=&submit=OK
     * mid   内容     评分    文件   提交
     */
    //写一下吧

    /**
     * deleted_id 删除的那条评论id
     */
    String deleted_id= request.getParameter("deleted");
    if(deleted_id!=null){
        String user_commit_id="";//那条评论的用户id
        if(user_commit_id.equals(user_id)||permissions==1){
            //删除评论
            //向通知表中插入title 你的评论被删除 info:被管理员删除/被自己删除  time 当前时间
        }
    }
    /**
     * 举报 评论id
     */
    String report_id=request.getParameter("report");
    if(report_id!=null){
        //uid先去查评论 用户id 向通知表中插入title 你的评论被举报 info: 你的评论被举报正在等待管理员审核 time 当前时间
    }


    /**
     * 检索电影
     */
    String mid = request.getParameter("mid");//电影id
    if(mid==null)mid="";

    //检索

	String title_call_to_movie,tagline,score,movie_src,movie_introduction,num_comment,movie_date,my_img=new String();
	title_call_to_movie="Men In Black Trilogy"; //电影名称
	tagline="NOW ON 4K ULTRA HD™"; //二级标题，tag一类的东西
	score="5.0"; //电影评分
	movie_src="onesheet.jpg"; //电影图片src
	movie_introduction="test test test"; //电影简介
	num_comment="4396"; //总评论数
	my_img="头像2.0.png"; //已登录用户的头像(就是准备发布评论的人的头像)
    movie_date="2017.12.11";//上映时间
    /**
     * 检索评论
     */

	//以下为其他用户评论的变量
	String[] user_name=new String[5];//用户名
	String[] user_img=new String[5];//用户头像
    String[] comment_id=new String[5];//评论id
	String[] user_comment=new String[5];//用户评论内容
    String[] comment_src=new String[5];//评论图片
	String[] floor_No=new String[5];//楼层编号
	String[] user_time=new String[5];//用户评论时间
	Integer[] user_star=new Integer[5];//该用户评星
	String[] photos=new String[]{"image/bk_login.png",""};//剧照
	
    //修改这些
    Integer pgno = 0; //当前页号翻页用
    String param = request.getParameter("pgno");
    if(param != null && !param.isEmpty()){
        pgno = Integer.parseInt(param);
    }
    int pgprev = (pgno>0)?pgno-1:0;
    int pgnext = pgno+1;
    //检索并且赋值
    Integer info_cnt=5; //当前界面信息数  最大为5 最小1  重要
    for(int i=0;i<info_cnt;i++){
        user_name[i]="用户"+(i+1);
        user_img[i]="头像2.0.png";
        comment_id[i]=""+i;
        user_comment[i]="用户"+(i+1)+"评论内容";
        comment_src[i]="image/bk_login.png";//没有显示为""
        floor_No[i]="#"+(i+1);
        user_time[i]="2017.12.11 20:00";
        user_star[i]=i+1;
    }
    /**
     * 检索推荐列表
     */
    //推荐部分变量
	String[] recommend_img=new String[4];//推荐电影的图片
	String[] recommend_name=new String[4];//推荐电影的名称
    Integer[] recommend_id=new Integer[4];//推荐电影的id
	for(int i=0;i<4;i++){ //初始化
	    recommend_img[i]="推荐.jpg";
	    recommend_name[i]="Men In Black";
	    recommend_id[i]=i;
	}



%>
<!DOCTYPE  html>
<html  lang="zh-cn">
<head>
    <meta charset="utf-8">
    <title>Movie_Info_<%=title_call_to_movie %></title>

    <link rel="stylesheet" type="text/css" href="css/font-awesome.css" />
    <link rel="stylesheet" type="text/css" href="css/info.css" />
    <link rel="stylesheet" type="text/css" href="css/header.css">
    <script src="js/info.js"></script>
    <script src="js/header.js"></script>
    <style>
    </style>
    <script>
	    var photo_pos=0;
	    var photo_src=new Array();
	    <%
	        for(int i=0;i<photos.length;i++){
	            out.print("photo_src["+String.valueOf(i)+"]=\""+photos[i]+"\";");
	        }
	    %>
    </script>
</head>
<body >
<div id="bk_outer" >

    <img src="<%=movie_src%>" id="main_bk">
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

<div id="photo_outer">
    <div id="photodisplay">
        <button onclick="photoclose()" id="closebtn0">&times;</button>
        <i onclick="prePhoto()" id="prebtn" class="fa fa-chevron-left btn"></i>
        <i onclick="nextPhoto()" id="nextbtn" class="fa fa-chevron-right btn"></i>
        <div id="photo_content">
            <img id="photos" src="<%=photos[0]%>">
        </div>
    </div>
</div>

<div id="info_main">
    <div id="info_inner">
        <h1><%=title_call_to_movie%></h1>
        <h3><%=tagline%></h3>
        <p id="score"><%=score%></p>
        <p id="dates">上映日期：<%=movie_date%></p>
        <img id="info_img" src="<%=movie_src%>" id="info_inner_img" onMouseMove="movemainphoto()" onMouseOut="outmainphoto()">
        <div id="info_text">
            <%=movie_introduction%>
        </div>
        <a id="morephoto" onClick="photoDisplay()" onMouseMove="movemainphoto()" onMouseOut="outmainphoto()">MORE</a>
    </div>
</div>

<div id="display_outer">
    <div id="imagedisplay">
        <button onclick="closeModal()" id="closebtn">&times;</button>
        <div id="img_content">
            <img id="imgs" src="">
        </div>
    </div>
</div>


<div id="comment_outer">
    <div id="comment">
        <p id="num_of_comments"><%=num_comment%>评论</p>
        <div id="user_comment">
            <img id="face_img" src="<%=my_img%>">
            <form action="info.jsp" method="get" id="comment_form">
                <input type="text" name="mid" hidden value="<%=mid%>">
                <textarea id="input_area"  name="content" rows="5" placeholder="请自觉遵守互联网相关的政策法规，严禁发布色情、暴力、反动的言论。"></textarea>
                <div id="rating" >
                    <p>
                        <input type="radio" name="level" value="1">
                        <input type="radio" name="level" value="2">
                        <input type="radio" name="level" value="3" checked>
                        <input type="radio" name="level" value="4">
                        <input type="radio" name="level" value="5">
                    </p>
                </div>
                <div id ="real_star">
                    <span><i name="real_star" class="fa fa-star"  onMouseMove="onmovestart(1)"></i></span>
                    <span><i name="real_star" class="fa fa-star" onMouseMove="onmovestart(2)"></i></span>
                    <span><i name="real_star" class="fa fa-star" onMouseMove="onmovestart(3)"></i></span>
                    <span><i name="real_star" class="fa fa-star-o" onMouseMove="onmovestart(4)"></i></span>
                    <span><i name="real_star" class="fa fa-star-o" onMouseMove="onmovestart(5)"></i></span>
                </div>
                <p id="upfile">点击上传图片<input type="file" name="file" id="file" onchange="setImagePreview()"></p>
                <button type="submit" id="comment_submit" name="submit" value="OK">发表评论</button>
            </form>
        </div>
        <div class="list_item" name="list_item">
            <div><img class="user_img" src="<%=user_img[0]%>"></div>
            <div class="list_content">
                <p class="user_name"><%=user_name[0]%></p>
                <p class="comment_content"><a class="openimg" onClick="openModal('<%=comment_src[0]%>')">评论图片</a><%=user_comment[0]%></p>
            </div>
            <div class="info">
                <div class="floot"><%=floor_No[0]%></div>
                <div class="comment_stat"><span name="star_add" ><script>star_add(0,<%=user_star[0]%>)</script></span></div>
                <div class="comment_time"> <%=user_time[0]%></div>
                <div class="comment_select"><a  href="info.jsp?pgno=<%=pgno%>&mid=<%=mid%>&report=<%=comment_id[0]%>">举报</a><a href="info.jsp?mid=<%=mid%>&deleted=<%=comment_id[0]%>">删除</a></div>
            </div>
        </div>
        <div class="list_item" name="list_item">
            <div><img class="user_img" src="<%=user_img[1]%>"></div>
            <div class="list_content">
                <p class="user_name"><%=user_name[1]%></p>
                <p class="comment_content"><a class="openimg" onClick="openModal('<%=comment_src[1]%>')">评论图片</a><%=user_comment[1]%></p>
            </div>
            <div class="info">
                <div class="floot"><%=floor_No[1]%></div>
                <div class="comment_stat"><span name="star_add" ><script>star_add(1,<%=user_star[1]%>)</script></span></div>
                <div class="comment_time"> <%=user_time[1]%></div>
                <div class="comment_select"><a  href="info.jsp?pgno=<%=pgno%>&mid=<%=mid%>&report=<%=comment_id[1]%>">举报</a><a  href="info.jsp?pgno=<%=pgno%>&mid=<%=mid%>&deleted=<%=comment_id[1]%>">删除</a></div>
            </div>
        </div>
        <div class="list_item" name="list_item">
            <div><img class="user_img" src="<%=user_img[2]%>"></div>
            <div class="list_content">
                <p class="user_name"><%=user_name[2]%></p>
                <p class="comment_content"><a class="openimg" onClick="openModal('<%=comment_src[2]%>')">评论图片</a><%=user_comment[2]%></p>
            </div>
            <div class="info">
                <div class="floot"><%=floor_No[2]%></div>
                <div class="comment_stat"><span name="star_add" ><script>star_add(2,<%=user_star[2]%>)</script></span></div>
                <div class="comment_time"> <%=user_time[2]%></div>
                <div class="comment_select"><a  href="info.jsp?pgno=<%=pgno%>&mid=<%=mid%>&report=<%=comment_id[2]%>">举报</a><a  href="info.jsp?pgno=<%=pgno%>&mid=<%=mid%>&deleted=<%=comment_id[2]%>">删除</a></div>
            </div>
        </div>
        <div class="list_item" name="list_item">
            <div><img class="user_img" src="<%=user_img[3]%>"></div>
            <div class="list_content">
                <p class="user_name"><%=user_name[3]%></p>
                <p class="comment_content"><a class="openimg" onClick="openModal('<%=comment_src[3]%>')">评论图片</a><%=user_comment[3]%></p>
            </div>
            <div class="info">
                <div class="floot"><%=floor_No[3]%></div>
                <div class="comment_stat"><span name="star_add"><script>star_add(3,<%=user_star[3]%>)</script></span></div>
                <div class="comment_time"> <%=user_time[3]%></div>
                <div class="comment_select"><a  href="info.jsp?pgno=<%=pgno%>&mid=<%=mid%>&report=<%=comment_id[3]%>">举报</a><a  href="info.jsp?pgno=<%=pgno%>&mid=<%=mid%>&deleted=<%=comment_id[3]%>">删除</a></div>
    </div>
        </div>
        <div class="list_item" name="list_item">
            <div><img class="user_img" src="<%=user_img[4]%>"></div>
            <div class="list_content">
                <p class="user_name"><%=user_name[4]%></p>
                <p class="comment_content"><a class="openimg" onClick="openModal('<%=comment_src[4]%>')">评论图片</a><%=user_comment[4]%></p>
            </div>
            <div class="info">
                <div class="floot"><%=floor_No[4]%></div>
                <div class="comment_stat"><span name="star_add" ><script>star_add(4,<%=user_star[4]%>)</script></span></div>
                <div class="comment_time"> <%=user_time[4]%></div>
                <div class="comment_select"><a  href="info.jsp?pgno=<%=pgno%>&mid=<%=mid%>&report=<%=comment_id[4]%>">举报</a><a href="info.jsp?pgno=<%=pgno%>&mid=<%=mid%>&deleted=<%=comment_id[4]%>">删除</a></div>
            </div>
        </div>
        <a href="info.jsp?pgno=<%=pgnext%>&mid=<%=mid%>" id="next_page"  class="page">下一页</a>
        <a href="info.jsp?pgno=<%=pgprev%>&mid=<%=mid%>" id="pre_page" class="page">上一页</a>
        <script>onstart(<%=pgno%>,<%=info_cnt%>)</script>
    </div>
</div>
<div id="featured">
    <div id="featured_sub">
        <p>猜你喜欢</p>
        <ul class="subshow">
            <li name="show_li" onclick="location.href='info.jsp?mid=<%=recommend_id[0]%>'" onmousemove="onmoveli(0)" onmouseout="outmoveli(0)"><img src="<%=recommend_img[0]%>"><a><%=recommend_name[0]%></a></li>
            <li name="show_li" onclick="location.href='info.jsp?mid=<%=recommend_id[1]%>'" onmousemove="onmoveli(1)" onmouseout="outmoveli(1)"><img src="<%=recommend_img[1]%>"><a><%=recommend_name[1]%></a></li>
            <li name="show_li" onclick="location.href='info.jsp?mid=<%=recommend_id[2]%>'" onmousemove="onmoveli(2)" onmouseout="outmoveli(2)"><img src="<%=recommend_img[2]%>"><a><%=recommend_name[2]%></a></li>
            <li name="show_li" onclick="location.href='info.jsp?mid=<%=recommend_id[3]%>'" onmousemove="onmoveli(3)" onmouseout="outmoveli(3)"><img src="<%=recommend_img[3]%>"><a><%=recommend_name[3]%></a></li>
        </ul>
    </div>
</div>
<div id="footer_outer">
    <div id="footer">

    </div>
</div>
</body>
</html>
<script>setdisplayimg("<%=comment_src[0]%>","<%=comment_src[1]%>","<%=comment_src[2]%>","<%=comment_src[3]%>","<%=comment_src[4]%>")</script>

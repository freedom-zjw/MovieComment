<%@ page
	language="java"
	contentType="text/html; UTF-8"
    pageEncoding="UTF-8"
%>
<%
	String user_id = (String)session.getAttribute("user_id");//用户id
    String Login="Loign";//登陆后显示用户名
    String Login_src="login.jsp";
    if(user_id!=null)Login_src="userinfo.jsp";

    String mid = request.getParameter("mid");//电影id
    if(mid==null)mid="";


	String title_call_to_movie,tagline,score,movie_src,movie_introduction,num_comment,my_img=new String();
	title_call_to_movie="Men In Black Trilogy"; //电影名称
	tagline="NOW ON 4K ULTRA HD™"; //二级标题，tag一类的东西
	score="5.0"; //电影评分
	movie_src="onesheet.jpg"; //电影图片src
	movie_introduction="test test test"; //电影简介
	num_comment="4396"; //总评论数
	my_img="头像2.0.png"; //已登录用户的头像(就是准备发布评论的人的头像)
	Integer info_cnt=5; //当前界面信息数  最大为5 最小1
	//以下为其他用户评论的变量
	String[] user_name=new String[5];//用户名
	String[] user_img=new String[5];//用户头像
	String[] user_comment=new String[5];//用户评论内容
	String[] floor_No=new String[5];//楼层编号
	String[] user_time=new String[5];//用户评论时间
	Integer[] user_star=new Integer[5];//该用户评星
	for(int i=0;i<info_cnt;i++){ //初始化
	    user_name[i]="用户"+(i+1);
	    user_img[i]="头像2.0.png";
	    user_comment[i]="用户"+(i+1)+"评论内容";
        floor_No[i]="#"+(i+1);
	    user_time[i]="2017.12.11 20:00";
	    user_star[i]=i+1;
	}
	
	//推荐部分变量
	String[] recommend_img=new String[4];//推荐电影的图片
	String[] recommend_name=new String[4];//推荐电影的名称
    Integer[] recommend_id=new Integer[4];//推荐电影的id
	for(int i=0;i<4;i++){ //初始化
	    recommend_img[i]="推荐.jpg";
	    recommend_name[i]="Men In Black";
	    recommend_id[i]=i;
	}

    Integer pgno = 0; //当前页号翻页用
    String param = request.getParameter("pgno");
    if(param != null && !param.isEmpty()){
        pgno = Integer.parseInt(param);
    }
    int pgprev = (pgno>0)?pgno-1:0;
    int pgnext = pgno+1;
%>
<!DOCTYPE  html>
<html  lang="zh-cn">
<head>
    <meta charset="utf-8">
    <title>Info</title>

    <link rel="stylesheet" type="text/css" href="css/font-awesome.css" />
    <link rel="stylesheet" type="text/css" href="css/info.css" />
    <link rel="stylesheet" type="text/css" href="css/header.css">
    <script src="js/info.js"></script>
    <style>
    </style>

</head>
<body >
<div id="bk_outer" >

    <img src="<%=movie_src%>" id="main_bk">
</div>

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


<div id="info_main">
    <div id="info_inner">
        <h1><%=title_call_to_movie%></h1>
        <h3><%=tagline%></h3>
        <p id="score"><%=score%></p>
        <img id="info_img" src="<%=movie_src%>" id="info_inner_img">
        <div id="info_text">
            <%=movie_introduction%>
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
                <p id="upfile">点击上传图片<input type="file" name="file"></p>
                <button type="submit" id="comment_submit" name="submit" value="OK">发表评论</button>
            </form>
        </div>
        <div class="list_item" name="list_item">
            <div><img class="user_img" src="<%=user_img[0]%>"></div>
            <div class="list_content">
                <p class="user_name"><%=user_name[0]%></p>
                <p class="comment_content"><%=user_comment[0]%></p>
            </div>
            <div class="info">
                <div class="floot"><%=floor_No[0]%></div>
                <div class="comment_stat"><span name="star_add" ><script>star_add(0,<%=user_star[0]%>)</script></span></div>
                <div class="comment_time"> <%=user_time[0]%></div>
                <div class="comment_select"><a href="#">加入黑名单</a><a  href="#">举报</a><a  href="#">删除</a></div>
            </div>
        </div>
        <div class="list_item" name="list_item">
            <div><img class="user_img" src="<%=user_img[1]%>"></div>
            <div class="list_content">
                <p class="user_name"><%=user_name[1]%></p>
                <p class="comment_content"><%=user_comment[1]%></p>
            </div>
            <div class="info">
                <div class="floot"><%=floor_No[1]%></div>
                <div class="comment_stat"><span name="star_add" ><script>star_add(1,<%=user_star[1]%>)</script></span></div>
                <div class="comment_time"> <%=user_time[1]%></div>
                <div class="comment_select"><a href="#">加入黑名单</a><a  href="#">举报</a><a  href="#">删除</a></div>
            </div>
        </div>
        <div class="list_item" name="list_item">
            <div><img class="user_img" src="<%=user_img[2]%>"></div>
            <div class="list_content">
                <p class="user_name"><%=user_name[2]%></p>
                <p class="comment_content"><%=user_comment[2]%></p>
            </div>
            <div class="info">
                <div class="floot"><%=floor_No[2]%></div>
                <div class="comment_stat"><span name="star_add" ><script>star_add(2,<%=user_star[2]%>)</script></span></div>
                <div class="comment_time"> <%=user_time[2]%></div>
                <div class="comment_select"><a href="#">加入黑名单</a><a  href="#">举报</a><a  href="#">删除</a></div>
            </div>
        </div>
        <div class="list_item" name="list_item">
            <div><img class="user_img" src="<%=user_img[3]%>"></div>
            <div class="list_content">
                <p class="user_name"><%=user_name[3]%></p>
                <p class="comment_content"><%=user_comment[3]%></p>
            </div>
            <div class="info">
                <div class="floot"><%=floor_No[3]%></div>
                <div class="comment_stat"><span name="star_add"><script>star_add(3,<%=user_star[3]%>)</script></span></div>
                <div class="comment_time"> <%=user_time[3]%></div>
                <div class="comment_select"><a href="#">加入黑名单</a><a  href="#">举报</a><a  href="#">删除</a></div>
            </div>
        </div>
        <div class="list_item" name="list_item">
            <div><img class="user_img" src="<%=user_img[4]%>"></div>
            <div class="list_content">
                <p class="user_name"><%=user_name[4]%></p>
                <p class="comment_content"><%=user_comment[4]%></p>
            </div>
            <div class="info">
                <div class="floot"><%=floor_No[4]%></div>
                <div class="comment_stat"><span name="star_add" ><script>star_add(4,<%=user_star[4]%>)</script></span></div>
                <div class="comment_time"> <%=user_time[4]%></div>
                <div class="comment_select"><a href="#">加入黑名单</a><a  href="#">举报</a><a  href="#">删除</a></div>
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

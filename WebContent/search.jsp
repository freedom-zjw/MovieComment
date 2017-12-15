<%--
  Created by IntelliJ IDEA.
  User: Chonor
  Date: 2017/12/11
  Time: 22:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String user_id = (String)session.getAttribute("user_id");//用户id
    String Login="Login";//登陆后的名字获取 id->名字 然后把这个改了

    ////////////////////不动
    String Login_src="login.jsp";
    if(user_id!=null)Login_src="user_info.jsp";
    /////////////////////
    /**
     * 从数据库中提出的信息存放
     *
     */
    String Name[]={"1","2","3","4","5"};//存放电影名
    String mid[]={"1","2","3","4","5"};//存放电影id
    String Info[]={"1","2","3","4","5"};//存放电影信息
    String Score[]={"9","9.5","6","7.5","8.5"};//存放分数
    String Date[]={"",",","","",""};//存放电影上映日期
    String Img_src[]={"","","","",""};//图片路径
    Integer Like[]={0,1,0,1,0};// 存当前用户是否收藏的，0没收藏，1收藏，如果没有用户登录那就全部设置0。
    Integer List_size=5; //搜到的数目 >5  就=5 因为只有5条

    /**
     * 没登录就无视
     * Like_mid 收藏变化的电影id
     * Like_change=1变为收藏 =0取消收藏
     * 之后更新数据库
     */
    String Like_mid=request.getParameter("likemid");
    if(Like_mid==null)Like_mid="";
    String Like_change=request.getParameter("like");
    if(Like_change==null)Like_change="";

    /**
     * 此处根据页号修改
     * 作为搜索条件之一
     */
    Integer pgno = 0; //当前页号
    String param = request.getParameter("pgno");
    if(param != null && !param.isEmpty()){
        pgno = Integer.parseInt(param);
    }
    int pgprev = (pgno>0)?pgno-1:0;
    int pgnext = pgno+1;

    String background_src="";//背景可能要改改 留着


    /**
     * 以下是可能的搜索条件
     */
    String Search_info;//搜索内容
    String Search_resule="结果如下";//搜索结果 没有的话改成提示没有相关内容
    /**
     * 类型
     * 电影 ：movie
     * 电视: TV
     */
    String types_=request.getParameter("types");
    if(types_==null)types_="";
    /**
     * 搜索框的内容
     */
    Search_info=request.getParameter("content");
    if(Search_info==null)Search_info="";
    //选择的排序方式
    /**
     * unselect 没有选 默认
     * date 最新
     * hot 最热
     * score 评分最高
     * max 评论最多
     */
    String Chooes = request.getParameter("sort"); //排序方式 这个有用
    if(Chooes==null) Chooes="unselect";
    String Chooess[]={"","","","",""};
    if(Chooes.equals("unselect")) Chooess[0]="selected";
    else Chooess[0]="";
    if(Chooes.equals("date")) Chooess[1]="selected";
    else Chooess[1]="";
    if(Chooes.equals("hot")) Chooess[2]="selected";
    else Chooess[2]="";
    if(Chooes.equals("score")) Chooess[3]="selected";
    else Chooess[3]="";
    if(Chooes.equals("max")) Chooess[4]="selected";
    else Chooess[4]="";

%>


<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="css/font-awesome.css" />
    <link rel="stylesheet" type="text/css" href="css/search_.css" />
    <link rel="stylesheet" type="text/css" href="css/header.css">
    <script src="js/header.js"></script>
    <title>Search</title>

    <style>
    </style>
</head>

<body onload="onstart(<%=pgno%>,<%=List_size%>)">
<div id="bk_outer">
    <img src="" id="main_bk">
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
                <input type="text"  name="content" id="content" autocomplete="off" value="<%=Search_info%>">
                <input type="submit" id="submit" name="submit" value="">
                <i class="fa fa-search fa-1x"></i>
            </form>
        </div>
    </div>
</div>


<div id="search_outer">
    <div id="search_contain">
        <form action="search.jsp" method="get" id="serach_form">
            <input type="text"  name="content" id="search1" value="<%=Search_info%>">
            <input type="submit" id="submit1"  name="submit" value="搜索" class="botton">
            <select id="sort" name="sort">
                <option value="unselect" <%=Chooess[0]%>>请选择</option>
                <option value="date" <%=Chooess[1]%>>最新</option>
                <option value="hot" <%=Chooess[2]%>>最热</option>
                <option value="score" <%=Chooess[3]%>>评分最高</option>
                <option value="max" <%=Chooess[4]%>>评论最多</option>
            </select>
        </form>
        <p id="search_result"><%=Search_resule%></p>
    </div>

</div>
<div id="searched_outer">
    <div id="searched">
        <ul id="searched_list">
            <li name="search_li">
                <img src="<%=Img_src[0]%>" class="search_img" onclick="location.href='info.jsp?mid=<%=mid[0]%>/'">
                <p class="search_name" onclick="location.href='info.jsp?mid=<%=mid[0]%>/'"><%=Name[0]%></p>
                <p class="search_info" onclick="location.href='info.jsp?mid=<%=mid[0]%>/'"><%=Info[0]%></p>
                <p class="search_date" onclick="location.href='info.jsp?mid=<%=mid[0]%>/'">上映日期：<%=Date[0]%></p>
                <p class="search_score" onclick="location.href='info.jsp?mid=<%=mid[0]%>/'"><%=Score[0]%></p>
                <hr class="search_hr">
                <i class="fa fa-heart-o" name="like" onclick="onmouseclick(0)"></i>

            </li>
            <li name="search_li" >
                <img src="<%=Img_src[1]%>" class="search_img" onclick="location.href='info.jsp?mid=<%=mid[1]%>/'">
                <p class="search_name" onclick="location.href='info.jsp?mid=<%=mid[1]%>/'"><%=Name[1]%></p>
                <p class="search_info" onclick="location.href='info.jsp?mid=<%=mid[1]%>/'"><%=Info[1]%></p>
                <p class="search_date" onclick="location.href='info.jsp?mid=<%=mid[0]%>/'">上映日期：<%=Date[1]%></p>
                <p class="search_score" onclick="location.href='info.jsp?mid=<%=mid[1]%>/'"><%=Score[1]%></p>
                <hr class="search_hr" >
                <i class="fa fa-heart-o" name="like" onclick="onmouseclick(1)"></i>
            </li>
            <li name="search_li" >
                <img src="<%=Img_src[2]%>" class="search_img" onclick="location.href='info.jsp?mid=<%=mid[2]%>/'">
                <p class="search_name" onclick="location.href='info.jsp?mid=<%=mid[2]%>/'"><%=Name[2]%></p>
                <p class="search_info" onclick="location.href='info.jsp?mid=<%=mid[2]%>/'"><%=Info[2]%></p>
                <p class="search_date" onclick="location.href='info.jsp?mid=<%=mid[0]%>/'">上映日期：<%=Date[2]%></p>
                <p class="search_score" onclick="location.href='info.jsp?mid=<%=mid[2]%>/'"><%=Score[2]%></p>
                <hr class="search_hr">
                <i class="fa fa-heart-o" name="like" onclick="onmouseclick(2)"></i>
            </li>
            <li name="search_li" >
                <img src="<%=Img_src[3]%>" class="search_img" onclick="location.href='info.jsp?mid=<%=mid[3]%>/'">
                <p class="search_name" onclick="location.href='info.jsp?mid=<%=mid[3]%>/'"> <%=Name[3]%></p>
                <p class="search_info" onclick="location.href='info.jsp?mid=<%=mid[3]%>/'"><%=Info[3]%></p>
                <p class="search_date" onclick="location.href='info.jsp?mid=<%=mid[0]%>/'">上映日期：<%=Date[3]%></p>
                <p class="search_score" onclick="location.href='info.jsp?mid=<%=mid[3]%>/'"><%=Score[3]%></p>
                <hr class="search_hr">
                <i class="fa fa-heart-o" name="like" onclick="onmouseclick(3)"></i>
            </li>
            <li name="search_li" >
                <img src="<%=Img_src[4]%>" class="search_img" onclick="location.href='info.jsp?mid=<%=mid[4]%>/'">
                <p class="search_name" onclick="location.href='info.jsp?mid=<%=mid[4]%>/'"><%=Name[4]%></p>
                <p class="search_info" onclick="location.href='info.jsp?mid=<%=mid[4]%>/'"><%=Info[4]%></p>
                <p class="search_date" onclick="location.href='info.jsp?mid=<%=mid[0]%>/'">上映日期：<%=Date[4]%></p>
                <p class="search_score" onclick="location.href='info.jsp?mid=<%=mid[4]%>/'"><%=Score[4]%></p>
                <hr class="search_hr">
                <i class="fa fa-heart-o" name="like" onclick="onmouseclick(4)"></i>
            </li>
        </ul>
        <a href="search.jsp?pgno=<%=pgprev%>&content=<%=Search_info%>&submit=搜索&sort=<%=Chooes%>&types=<%=types_%>" id="pre_page" class="page">上一页</a>
        <a href="search.jsp?pgno=<%=pgnext%>&content=<%=Search_info%>&submit=搜索&sort=<%=Chooes%>&types=<%=types_%>" id="next_page"  class="page" >下一页</a>
    </div>
</div>

<div id="footer_outer">
    <div id="footer">

    </div>
</div>

</body>
</html>
<script>
    var like0=<%=Like[0]%>;
    var like1=<%=Like[1]%>;
    var like2=<%=Like[2]%>;
    var like3=<%=Like[3]%>;
    var like4=<%=Like[4]%>;
    var list_size=<%=List_size%>;
    var like=document.getElementsByName("like");
    function onstart(cnt1,cnt2){
        if(cnt1==0)document.getElementById("pre_page").hidden="hidden";
        if(cnt2<5)document.getElementById("next_page").hidden="hidden";

        if(like0==1)like[0].className="fa fa-heart";
        else like[0].className="fa fa-heart-o";

        if(like1==1)like[1].className="fa fa-heart";
        else like[1].className="fa fa-heart-o";

        if(like2==1)like[2].className="fa fa-heart";
        else like[2].className="fa fa-heart-o";

        if(like3==1)like[3].className="fa fa-heart";
        else like[3].className="fa fa-heart-o";

        if(like4==1)like[4].className="fa fa-heart";
        else like[4].className="fa fa-heart-o";

        display_li();
    }
    function display_li(){
        obj = document.getElementsByName("search_li");
        for(var i=list_size;i<obj.length;i++){
            obj[i].style.display="none";
        }
    }
    function onmouseclick(i){
        if(i==0){
            if(like0==1){
                like0=0;
                like[0].className="fa fa-heart-o";
                <%Like[0]=0;%>
            }
            else{
                like0=1;
                like[0].className="fa fa-heart";
                <%Like[0]=1;%>
            }
        }
        else if(i==1){
            if(like1==1){
                like1=0;
                like[1].className="fa fa-heart-o";
                <%Like[1]=0;%>
            }
            else{
                like1=1;
                like[1].className="fa fa-heart";
                <%Like[1]=1;%>
            }
        }
        else if(i==2){
            if(like2==1){
                like2=0;
                like[2].className="fa fa-heart-o";
                <%Like[2]=0;%>
            }
            else{
                like2=1;
                like[2].className="fa fa-heart";
                <%Like[2]=1;%>
            }
        }
        else if(i==3){
            if(like3==1){
                like3=0;
                like[3].className="fa fa-heart-o";
                <%Like[3]=0;%>
            }
            else{
                like3=1;
                like[3].className="fa fa-heart";
                <%Like[3]=1;%>
            }
        }
        else if(i==4){
            if(like4==1){
                like4=0;
                like[4].className="fa fa-heart-o";
                <%Like[4]=0;%>
            }
            else{
                like4=1;
                like[4].className="fa fa-heart";
                <%Like[4]=1;%>
            }
        }
        if(i==0)location.href="search.jsp?pgno=<%=pgno%>&content=<%=Search_info%>&submit=搜索&sort=<%=Chooes%>&types=<%=types_%>&likemid=<%=mid[0]%>&like="+like0;
        else if(i==1)location.href="search.jsp?pgno=<%=pgno%>&content=<%=Search_info%>&submit=搜索&sort=<%=Chooes%>&types=<%=types_%>&likemid=<%=mid[1]%>&like="+like1;
        else if(i==2)location.href="search.jsp?pgno=<%=pgno%>&content=<%=Search_info%>&submit=搜索&sort=<%=Chooes%>&types=<%=types_%>&likemid=<%=mid[2]%>&like="+like2;
        else if(i==3)location.href="search.jsp?pgno=<%=pgno%>&content=<%=Search_info%>&submit=搜索&sort=<%=Chooes%>&types=<%=types_%>&likemid=<%=mid[3]%>&like="+like3;
        else if(i==4)location.href="search.jsp?pgno=<%=pgno%>&content=<%=Search_info%>&submit=搜索&sort=<%=Chooes%>&types=<%=types_%>&likemid=<%=mid[4]%>&like="+like4;
    }
</script>

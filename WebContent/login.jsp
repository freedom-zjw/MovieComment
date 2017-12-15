<%--
  Created by IntelliJ IDEA.
  User: Chonor
  Date: 2017/12/13
  Time: 22:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*,java.sql.*"%>
<%  request.setCharacterEncoding("utf-8");%> 
<jsp:useBean id="Userdb" class="com.group.bean.Userdb" scope="page"/> 
<%
    String user_id = (String)session.getAttribute("user_id");//用户id
    Integer flag=0; //已经登录自动转跳
    if(user_id!=null)flag=1;
    /**
     * 表单中有的信息
     * user 用户名
     * passwd 密码
     * val 验证码结果 true or false
     */
    String user,passwd,val,login,init;
    String sql = null;
    ResultSet rs = null;

    user=request.getParameter("user");
    passwd=request.getParameter("password");
    val=request.getParameter("val");
    login=request.getParameter("login");
    init=request.getParameter("init");
    
    Integer login_flag=-1,Init_fail=0;
    if(login==null&&init!=null){
        //注册 转到用户信息界面要求用户填详细信息  记得给session 赋值
        if (user==null || user!=null&&user.trim()=="" || passwd==null || passwd!=null&&passwd.trim()==""){
        	out.print("<script>alert('用户名或密码不能为空！'); </script>");
        }
        else if(val.equals("false"))login_flag=1;//验证码不正确
        else {
    		rs = Userdb.queryByAccount(user);
    		if (rs.next())Init_fail=1; //如果用户已经存在则保留在原网页
    		else{ //成功注册
    			sql = "insert into User (account, password, permission) values ('" +
    				  user + "','" + passwd + "', 0)";
    			Userdb.insert(sql);
    			rs = Userdb.queryByAccount(user);
    			rs.next();
    			user_id = String.valueOf(rs.getInt("uid"));
    			session.setAttribute("user_id",  user_id);
    			session.setAttribute("account",  user);
    			session.setAttribute("sex",  rs.getString("sex"));
    			flag = 1;
    			out.print("<script>alert('成功注册！');</script>");
    			response.sendRedirect("user_change.jsp");
    		}
        }
    }
    else if(login!=null&&init==null){
        //登录 数据库判断 记得给session 赋值
    	if (user==null || user!=null&&user.trim()=="" || passwd==null || passwd!=null&&passwd.trim()==""){
        	out.print("<script>alert('用户名或密码不能为空！'); </script>");
        }
    	else if(val.equals("false"))login_flag=1;//验证码不正确
    	else{
			rs = Userdb.queryByAccount(user);
			if (rs.next()){
				String real_passwd = rs.getString("password");
        		if (real_passwd.equals(passwd)){
        			login_flag=2;       //用户存在且密码匹配
        			user_id = String.valueOf(rs.getInt("uid"));
        			session.setAttribute("user_id", user_id);
        			session.setAttribute("account",  user);
        			session.setAttribute("sex",  rs.getString("sex"));
        			flag = 1;
        			out.print("<script>alert('成功登陆！');</script>");
        		}
        		else login_flag=0;
			}
        	else login_flag=0;
    	}
    }
%>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>用户登录界面</title>
    <link  rel="stylesheet" type="text/css" href="css/header.css">
    <link rel="stylesheet" type="text/css" href="css/font-awesome.css" />
    <link href="css/load.css" rel="stylesheet" type="text/css">
    <script src="js/login.js"></script>
    <script src="js/header.js"></script>
    <style>
    </style>
</head>
<body>
<div id="bk_outer">
    <img src="image/bk_login.png" id="main_bk">
</div>

<div id="header_outer">
    <div id="header" class="wrapper">
        <p>GoodMovie</p>
        <a href="login.jsp"><i class="fa fa-user-circle-o"></i> Login</a>
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


<div id="outer_background">
    <div id="background">
        <form id="load_info" action="login.jsp" method="get">
            <p><input type="text" class="input_12" id="user" name="user" placeholder="用户名" onClick="inputin(1)"></p>
            <p><input type="text" class="input_12" id="password" name="password"  placeholder="密码" onClick="inputin(2)"></p>
            <p><input type="button" id="code" onclick="createCode()">
                <input type="text" id="checkcode"  onBlur="validate()">
                <i id="checkicon" class="fa fa-check"></i></p>
            <input type="text" name="val"  id="val" value="false" hidden="hidden">
            <input type="submit" name="login" class="input_34" id="button_left" value="登录" >
            <input type="submit" name="init" class="input_34" value="注册" id="button_right">
        </form>
    </div>
</div>

<div id="footer_outer">
    <div id="footer">

    </div>
</div>

<script>createCode();</script>
<script>logined(<%=flag%>,<%=user_id%>)</script>
<script>Init_fail(<%=Init_fail%>)</script>
<script>inputworry(<%=login_flag%>)</script>
</body>
</html>
<script>

</script>
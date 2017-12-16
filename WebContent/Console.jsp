<%--
  Created by IntelliJ IDEA.
  User: Chonor
  Date: 2017/12/16
  Time: 14:58
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
   


    String[] account={"","","","","","","",""};
    String[] name={"","","","","","","",""};
    String[] movie_name={"","","","","","","",""};
    String[] mid={"","","","","","","",""};
    String[] uid={"","","","","","","",""};
    String[] title={"","","","","","","",""};
	Integer user_size=8,movie_size=8,info_size=8;
	
	
	
    Integer user_pgno = 0; //当前用户页号
    String param1 = request.getParameter("user_pgno");
    if(param1 != null && !param1.isEmpty()){
        user_pgno = Integer.parseInt(param1);
    }
    int user_pre = (user_pgno>0)?user_pgno-1:0;
    int user_next = user_pgno+1;
	//只需要账户和名字
	
    Integer movie_pgno = 0; //当前电影页号
    String param2 = request.getParameter("movie_pgno");
    if(param2 != null && !param2.isEmpty()){
        movie_pgno = Integer.parseInt(param2);
    }
    int movie_pre = (movie_pgno>0)?movie_pgno-1:0;
    int movie_next = movie_pgno+1;
	//只需要mid 和名字
	
    Integer info_pgno = 0; //当前通知页号
    String param3 = request.getParameter("info_pgno");
    if(param3 != null && !param3.isEmpty()){
        info_pgno = Integer.parseInt(param3);
    }
    int info_pre = (info_pgno>0)?info_pgno-1:0;
    int info_next = info_pgno+1;
	//只需要id和标题


    String flag=request.getParameter("flag");
    if(flag==null)flag="";
    if(flag.equals("0")){
        String premiss=request.getParameter("premiss");
        String account_=request.getParameter("account");
        if(premiss!=null&&account_!=null){
			//修改用户权限
        }
    }
    else if(flag.equals("1")){
        String mid_=request.getParameter("mid");
        if(mid_!=null){
			//删除
        }
    }
    else if(flag.equals("2")){
        String uid_=request.getParameter("uid");
        String premiss=request.getParameter("premiss");
        if(uid_!=null&&premiss!=null){
			//一样改了
        }
    }

%>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="css/header.css" />
    <link rel="stylesheet" type="text/css" href="css/font-awesome.css" />
    <link rel="stylesheet" type="text/css" href="css/Console.css" />
    <script src="js/console.js"></script>
    <script src="js/header.js"></script>
    <title>Console</title>
</head>

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

<div id="main_outer">
    <div id="main_inner">
        <div id="menu">
            <button class="button" id="user_list" onClick="buttonOnclick(0)">用户列表</button>
            <button class="button" id="movie_list" onClick="buttonOnclick(1)">影片列表</button>
            <button class="button" id="info_list" onClick="buttonOnclick(2)">通知列表</button>

        </div>
        <div id="welcome" class="info" disabled><button>欢迎使用管理系统</button></div>
        <div id="user_info" class="info">
            <table>
                <tbody>
                <tr>
                    <th><a id="first" class="titles">用户账户</a></th>
                    <th><a id="sec" class="titles">用户名</a></th>
                    <th><a id="thr" class="titles">操作</a></th>
                </tr>
                <tr>
                    <td> <%=account[0]%></td>
                    <td> <%=name[0]%></td>
                    <td>
                        <button class="buttonsub" onclick="location.href='Console.jsp?info_pgno=<%=info_pgno%>&movie_pgno=<%=movie_pgno%>&user_pgno=<%=user_pgno%>&flag=0&premiss=1&account=<%=account[0]%>'">赋予管理员权限</button>
                        <button class="buttonsub" onclick="location.href='Console.jsp?info_pgno=<%=info_pgno%>&movie_pgno=<%=movie_pgno%>&user_pgno=<%=user_pgno%>&flag=0&premiss=-1&account=<%=account[0]%>'">封禁账号</button>
                        <button class="buttonsub" onclick="location.href='Console.jsp?info_pgno=<%=info_pgno%>&movie_pgno=<%=movie_pgno%>&user_pgno=<%=user_pgno%>&flag=0&premiss=0&account=<%=account[0]%>'">解除封禁</button></td>
                </tr>
                <tr>
                    <td> <%=account[1]%></td>
                    <td> <%=name[1]%></td>
                    <td>
                    <button class="buttonsub" onclick="location.href='Console.jsp?info_pgno=<%=info_pgno%>&movie_pgno=<%=movie_pgno%>&user_pgno=<%=user_pgno%>&flag=0&premiss=1&account=<%=account[1]%>'">赋予管理员权限</button>
                    <button class="buttonsub" onclick="location.href='Console.jsp?info_pgno=<%=info_pgno%>&movie_pgno=<%=movie_pgno%>&user_pgno=<%=user_pgno%>&flag=0&premiss=-1&account=<%=account[1]%>'">封禁账号</button>
                    <button class="buttonsub" onclick="location.href='Console.jsp?info_pgno=<%=info_pgno%>&movie_pgno=<%=movie_pgno%>&user_pgno=<%=user_pgno%>&flag=0&premiss=0&account=<%=account[1]%>'">解除封禁</button>
                    </td>
                </tr>
                <tr>
                    <td> <%=account[2]%></td>
                    <td> <%=name[2]%></td>
                    <td>
                    <button class="buttonsub" onclick="location.href='Console.jsp?info_pgno=<%=info_pgno%>&movie_pgno=<%=movie_pgno%>&user_pgno=<%=user_pgno%>&flag=0&premiss=1&account=<%=account[2]%>'">赋予管理员权限</button>
                    <button class="buttonsub" onclick="location.href='Console.jsp?info_pgno=<%=info_pgno%>&movie_pgno=<%=movie_pgno%>&user_pgno=<%=user_pgno%>&flag=0&premiss=-1&account=<%=account[2]%>'">封禁账号</button>
                    <button class="buttonsub" onclick="location.href='Console.jsp?info_pgno=<%=info_pgno%>&movie_pgno=<%=movie_pgno%>&user_pgno=<%=user_pgno%>&flag=0&premiss=0&account=<%=account[2]%>'">解除封禁</button>
                    </td>
                </tr>
                <tr>
                    <td> <%=account[3]%></td>
                    <td> <%=name[3]%></td>
                    <td>
                    <button class="buttonsub" onclick="location.href='Console.jsp?info_pgno=<%=info_pgno%>&movie_pgno=<%=movie_pgno%>&user_pgno=<%=user_pgno%>&flag=0&premiss=1&account=<%=account[3]%>'">赋予管理员权限</button>
                    <button class="buttonsub" onclick="location.href='Console.jsp?info_pgno=<%=info_pgno%>&movie_pgno=<%=movie_pgno%>&user_pgno=<%=user_pgno%>&flag=0&premiss=-1&account=<%=account[3]%>'">封禁账号</button>
                    <button class="buttonsub" onclick="location.href='Console.jsp?info_pgno=<%=info_pgno%>&movie_pgno=<%=movie_pgno%>&user_pgno=<%=user_pgno%>&flag=0&premiss=0&account=<%=account[3]%>'">解除封禁</button>
                    </td>
                </tr>
                <tr>
                    <td> <%=account[4]%></td>
                    <td> <%=name[4]%></td>
                    <td>
                    <button class="buttonsub" onclick="location.href='Console.jsp?info_pgno=<%=info_pgno%>&movie_pgno=<%=movie_pgno%>&user_pgno=<%=user_pgno%>&flag=0&premiss=1&account=<%=account[4]%>'">赋予管理员权限</button>
                    <button class="buttonsub" onclick="location.href='Console.jsp?info_pgno=<%=info_pgno%>&movie_pgno=<%=movie_pgno%>&user_pgno=<%=user_pgno%>&flag=0&premiss=-1&account=<%=account[4]%>'">封禁账号</button>
                    <button class="buttonsub" onclick="location.href='Console.jsp?info_pgno=<%=info_pgno%>&movie_pgno=<%=movie_pgno%>&user_pgno=<%=user_pgno%>&flag=0&premiss=0&account=<%=account[4]%>'">解除封禁</button>
                    </td>
                </tr>
                <tr>
                    <td> <%=account[5]%></td>
                    <td> <%=name[5]%></td>
                    <td>
                    <button class="buttonsub" onclick="location.href='Console.jsp?info_pgno=<%=info_pgno%>&movie_pgno=<%=movie_pgno%>&user_pgno=<%=user_pgno%>&flag=0&premiss=1&account=<%=account[5]%>'">赋予管理员权限</button>
                    <button class="buttonsub" onclick="location.href='Console.jsp?info_pgno=<%=info_pgno%>&movie_pgno=<%=movie_pgno%>&user_pgno=<%=user_pgno%>&flag=0&premiss=-1&account=<%=account[5]%>'">封禁账号</button>
                    <button class="buttonsub" onclick="location.href='Console.jsp?info_pgno=<%=info_pgno%>&movie_pgno=<%=movie_pgno%>&user_pgno=<%=user_pgno%>&flag=0&premiss=0&account=<%=account[5]%>'">解除封禁</button>
                    </td>
                </tr>
                <tr>
                    <td> <%=account[6]%></td>
                    <td> <%=name[6]%></td>
                    <td>
                    <button class="buttonsub" onclick="location.href='Console.jsp?info_pgno=<%=info_pgno%>&movie_pgno=<%=movie_pgno%>&user_pgno=<%=user_pgno%>&flag=0&premiss=1&account=<%=account[6]%>'">赋予管理员权限</button>
                    <button class="buttonsub" onclick="location.href='Console.jsp?info_pgno=<%=info_pgno%>&movie_pgno=<%=movie_pgno%>&user_pgno=<%=user_pgno%>&flag=0&premiss=-1&account=<%=account[6]%>'">封禁账号</button>
                    <button class="buttonsub" onclick="location.href='Console.jsp?info_pgno=<%=info_pgno%>&movie_pgno=<%=movie_pgno%>&user_pgno=<%=user_pgno%>&flag=0&premiss=0&account=<%=account[6]%>'">解除封禁</button>
                    </td>
                </tr>
                <tr>
                    <td> <%=account[7]%></td>
                    <td> <%=name[7]%></td>
                    <td>
                    <button class="buttonsub" onclick="location.href='Console.jsp?info_pgno=<%=info_pgno%>&movie_pgno=<%=movie_pgno%>&user_pgno=<%=user_pgno%>&flag=0&premiss=1&account=<%=account[7]%>'">赋予管理员权限</button>
                    <button class="buttonsub" onclick="location.href='Console.jsp?info_pgno=<%=info_pgno%>&movie_pgno=<%=movie_pgno%>&user_pgno=<%=user_pgno%>&flag=0&premiss=-1&account=<%=account[7]%>'">封禁账号</button>
                    <button class="buttonsub" onclick="location.href='Console.jsp?info_pgno=<%=info_pgno%>&movie_pgno=<%=movie_pgno%>&user_pgno=<%=user_pgno%>&flag=0&premiss=0&account=<%=account[7]%>'">解除封禁</button>
                    </td>
                </tr>
                </tbody>
            </table>

        </div>
        <div id="movie_info" class="info">
            <table border="0">
                <tbody>
                <tr>
                    <th><a class="titles" style="width: 450px">电影标题</a></th>
                    <th><a class="titles" style="width: 200px">操作</a></th>
                </tr>
                <tr>
                    <td> <%=movie_name[0]%></td>
                    <td>
                        <button class="buttonsub" onclick="delMovie('<%=info_pgno%>','<%=movie_pgno%>','<%=user_pgno%>','<%=mid[0]%>')">删除</button>
                    </td>
                </tr>
                <tr>
                    <td> <%=movie_name[1]%></td>
                    <td>
                        <button class="buttonsub" onclick="delMovie('<%=info_pgno%>','<%=movie_pgno%>','<%=user_pgno%>','<%=mid[1]%>')">删除</button>
                    </td>
                </tr>
                <tr>
                    <td> <%=movie_name[2]%></td>
                    <td>
                        <button class="buttonsub" onclick="delMovie('<%=info_pgno%>','<%=movie_pgno%>','<%=user_pgno%>','<%=mid[2]%>')">删除</button>
                    </td>
                </tr>
                <tr>
                    <td> <%=movie_name[3]%></td>
                    <td>
                        <button class="buttonsub" onclick="delMovie('<%=info_pgno%>','<%=movie_pgno%>','<%=user_pgno%>','<%=mid[3]%>')">删除</button>
                    </td>
                </tr>
                <tr>
                    <td> <%=movie_name[4]%></td>
                    <td>
                        <button class="buttonsub" onclick="delMovie('<%=info_pgno%>','<%=movie_pgno%>','<%=user_pgno%>','<%=mid[4]%>')">删除</button>
                    </td>
                </td>
                </tr>
                <tr>
                    <td> <%=movie_name[5]%></td>
                    <td>
                        <button class="buttonsub" onclick="delMovie('<%=info_pgno%>','<%=movie_pgno%>','<%=user_pgno%>','<%=mid[5]%>')">删除</button>
                    </td>
                </tr>
                <tr>
                    <td> <%=movie_name[6]%></td>
                    <td>
                        <button class="buttonsub" onclick="delMovie('<%=info_pgno%>','<%=movie_pgno%>','<%=user_pgno%>','<%=mid[6]%>')">删除</button>
                    </td>
                </tr>
                <tr>
                    <td> <%=movie_name[7]%></td>
                    <td>
                        <button class="buttonsub" onclick="delMovie('<%=info_pgno%>','<%=movie_pgno%>','<%=user_pgno%>','<%=mid[7]%>')">删除</button>
                    </td>
                </tr>
                </tbody>
            </table>

        </div>
        <div id="info" class="info">
            <table width="200" border="0">
                <tbody>
                <tr>
                    <th><a style="width: 150px" class="titles">用户ID</a></th>
                    <th><a style="width: 300px" class="titles">通知标题</a></th>
                    <th><a style="width: 200px" class="titles">操作</a></th>
                </tr>
                <tr>
                    <td> <%=uid[0]%></td>
                    <td> <%=title[0]%></td>
                    <td>
                        <button class="buttonsub" onclick="location.href='Console.jsp?info_pgno=<%=info_pgno%>&movie_pgno=<%=movie_pgno%>&user_pgno=<%=user_pgno%>&flag=2&premiss=-1&uid=<%=uid[0]%>'">封禁账号</button>
                        <button class="buttonsub" onclick="location.href='Console.jsp?info_pgno=<%=info_pgno%>&movie_pgno=<%=movie_pgno%>&user_pgno=<%=user_pgno%>&flag=2&premiss=0&uid=<%=uid[0]%>'">解除封禁</button>
                    </td>
                </tr>
                <tr>
                    <td> <%=uid[1]%></td>
                    <td> <%=title[1]%></td>
                    <td>
                        <button class="buttonsub" onclick="location.href='Console.jsp?info_pgno=<%=info_pgno%>&movie_pgno=<%=movie_pgno%>&user_pgno=<%=user_pgno%>&flag=2&premiss=-1&uid=<%=uid[1]%>'">封禁账号</button>
                        <button class="buttonsub" onclick="location.href='Console.jsp?info_pgno=<%=info_pgno%>&movie_pgno=<%=movie_pgno%>&user_pgno=<%=user_pgno%>&flag=2&premiss=0&uid=<%=uid[1]%>'">解除封禁</button>
                    </td>
                </tr>
                <tr>
                    <td> <%=uid[2]%></td>
                    <td> <%=title[2]%></td>
                    <td>
                        <button class="buttonsub" onclick="location.href='Console.jsp?info_pgno=<%=info_pgno%>&movie_pgno=<%=movie_pgno%>&user_pgno=<%=user_pgno%>&flag=2&premiss=-1&uid=<%=uid[2]%>'">封禁账号</button>
                        <button class="buttonsub" onclick="location.href='Console.jsp?info_pgno=<%=info_pgno%>&movie_pgno=<%=movie_pgno%>&user_pgno=<%=user_pgno%>&flag=2&premiss=0&uid=<%=uid[2]%>'">解除封禁</button>
                    </td>
                </tr>
                <tr>
                    <td> <%=uid[3]%></td>
                    <td> <%=title[3]%></td>
                    <td>
                        <button class="buttonsub" onclick="location.href='Console.jsp?info_pgno=<%=info_pgno%>&movie_pgno=<%=movie_pgno%>&user_pgno=<%=user_pgno%>&flag=2&premiss=-1&uid=<%=uid[3]%>'">封禁账号</button>
                        <button class="buttonsub" onclick="location.href='Console.jsp?info_pgno=<%=info_pgno%>&movie_pgno=<%=movie_pgno%>&user_pgno=<%=user_pgno%>&flag=2&premiss=0&uid=<%=uid[3]%>'">解除封禁</button>
                    </td>
                </tr>
                <tr>
                    <td> <%=uid[4]%></td>
                    <td> <%=title[4]%></td>
                    <td>
                        <button class="buttonsub" onclick="location.href='Console.jsp?info_pgno=<%=info_pgno%>&movie_pgno=<%=movie_pgno%>&user_pgno=<%=user_pgno%>&flag=2&premiss=-1&uid=<%=uid[4]%>'">封禁账号</button>
                        <button class="buttonsub" onclick="location.href='Console.jsp?info_pgno=<%=info_pgno%>&movie_pgno=<%=movie_pgno%>&user_pgno=<%=user_pgno%>&flag=2&premiss=0&uid=<%=uid[4]%>'">解除封禁</button>
                    </td>
                </tr>
                <tr>
                    <td> <%=uid[5]%></td>
                    <td> <%=title[5]%></td>
                    <td>
                        <button class="buttonsub" onclick="location.href='Console.jsp?info_pgno=<%=info_pgno%>&movie_pgno=<%=movie_pgno%>&user_pgno=<%=user_pgno%>&flag=2&premiss=-1&uid=<%=uid[5]%>'">封禁账号</button>
                        <button class="buttonsub" onclick="location.href='Console.jsp?info_pgno=<%=info_pgno%>&movie_pgno=<%=movie_pgno%>&user_pgno=<%=user_pgno%>&flag=2&premiss=0&uid=<%=uid[5]%>'">解除封禁</button>
                    </td>
                </tr>
                <tr>
                    <td> <%=uid[6]%></td>
                    <td> <%=title[6]%></td>
                    <td>
                        <button class="buttonsub" onclick="location.href='Console.jsp?info_pgno=<%=info_pgno%>&movie_pgno=<%=movie_pgno%>&user_pgno=<%=user_pgno%>&flag=2&premiss=-1&uid=<%=uid[6]%>'">封禁账号</button>
                        <button class="buttonsub" onclick="location.href='Console.jsp?info_pgno=<%=info_pgno%>&movie_pgno=<%=movie_pgno%>&user_pgno=<%=user_pgno%>&flag=2&premiss=0&uid=<%=uid[6]%>'">解除封禁</button>
                    </td>
                </tr>
                <tr>
                    <td> <%=uid[7]%></td>
                    <td> <%=title[7]%></td>
                    <td>
                        <button class="buttonsub" onclick="location.href='Console.jsp?info_pgno=<%=info_pgno%>&movie_pgno=<%=movie_pgno%>&user_pgno=<%=user_pgno%>&flag=2&premiss=-1&uid=<%=uid[7]%>'">封禁账号</button>
                        <button class="buttonsub" onclick="location.href='Console.jsp?info_pgno=<%=info_pgno%>&movie_pgno=<%=movie_pgno%>&user_pgno=<%=user_pgno%>&flag=2&premiss=0&uid=<%=uid[7]%>'">解除封禁</button>
                    </td>
                </tr>
                </tbody>
            </table>

        </div>
        <div style="clear: both"></div>
        <div id="page"><a class="buttonsub" onclick="Onpage(0)">上一页</a><a class="buttonsub" onclick="Onpage(1)">下一页</a>
        </div>
    </div>
    <script>onStart(<%=user_size%>,<%=movie_size%>,<%=info_size%>,'<%=flag%>')</script>
</div>
</body>

<script>
    function Onpage(i) {
        if(i==1&&page_flag==0)location.href="Console.jsp?info_pgno=<%=info_pgno%>&movie_pgno=<%=movie_pgno%>&user_pgno=<%=user_next%>&flag=0";
        else if(i==0&&page_flag==0)location.href="Console.jsp?info_pgno=<%=info_pgno%>&movie_pgno=<%=movie_pgno%>&user_pgno=<%=user_pre%>&flag=0";
        else if(i==1&&page_flag==1)location.href="Console.jsp?info_pgno=<%=info_pgno%>&movie_pgno=<%=movie_next%>&user_pgno=<%=user_pgno%>&flag=1";
        else if(i==0&&page_flag==1)location.href="Console.jsp?info_pgno=<%=info_pgno%>&movie_pgno=<%=movie_pre%>&user_pgno=<%=user_pgno%>&flag=1";
        else if(i==1&&page_flag==2)location.href="Console.jsp?info_pgno=<%=info_next%>&movie_pgno=<%=movie_pgno%>&user_pgno=<%=user_pgno%>&flag=2";
        else if(i==0&&page_flag==2)location.href="Console.jsp?info_pgno=<%=info_pre%>&movie_pgno=<%=movie_pgno%>&user_pgno=<%=user_pgno%>&flag=2";
    }
</script>
</html>


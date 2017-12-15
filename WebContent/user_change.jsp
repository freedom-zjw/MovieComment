<%--
  Created by IntelliJ IDEA.
  User: Chonor
  Date: 2017/12/13
  Time: 23:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*, java.util.*,java.sql.*,org.apache.commons.io.*"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<%  request.setCharacterEncoding("utf-8");%>
<jsp:useBean id="Userdb" class="com.group.bean.Userdb" scope="page"/> 
<%
    String user_id = (String)session.getAttribute("user_id");//用户id
    String Login="Login";//登陆后显示用户名
    String Login_src="login.jsp";
    ResultSet rs = null;
    String name="",sex="",info="",hobby="",img_src="";
    if(user_id!=null){
    	Login = (String)session.getAttribute("account");
    	Login_src="user_info.jsp";
    	sex = (String)session.getAttribute("sex");
    }
    else{
    	response.sendRedirect("login.jsp");
    }

    /**
     * 提交之后获取
     */
    String method = request.getMethod();
	boolean post = method.equalsIgnoreCase("post");
	if (post){
		 boolean isMultipart = ServletFileUpload.isMultipartContent(request);//检查表单中是否包含文件
		 if (isMultipart) {
	    	rs = Userdb.queryByAccount(Login);
	    	rs.next();
			FileItemFactory factory = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(factory);
			List items = upload.parseRequest(request);
			for (int i = 0; i < items.size(); i++) {
				FileItem fi = (FileItem) items.get(i);
				if (i==0){//图片文件
					DiskFileItem dfi = (DiskFileItem) fi;
					if (!dfi.getName().trim().equals("")) {
						String fileName = user_id + ".png";
						String filepath=application.getRealPath("/temp/UserPhotos");
						File FileDir = new File(filepath);
						if (!FileDir.exists()){
							FileDir.mkdirs();
						}
						filepath =  filepath
								 + System.getProperty("file.separator") //获取系统文件分隔符
								 + fileName;
						System.out.println(filepath);
						img_src = "temp/UserPhotos/" + fileName;
						dfi.write(new File(filepath));
					}
					else img_src = rs.getString("Image_src");
				}
				else if(i==1){
					name = fi.getString("utf-8").trim();
					if (name.equals(""))name = rs.getString("name");
				}
				else if (i==2){
					info = fi.getString("utf-8").trim();
					if (info.equals(""))info = rs.getString("info");
				}
				else if (i==3){
					sex = fi.getString("utf-8").trim();
					if (sex.equals(""))sex = rs.getString("sex");
				}
				else if (i==4){
					hobby= fi.getString("utf-8").trim();
					if (hobby.equals(""))hobby = rs.getString("name");
				}
			}
			String sql = "update User set name='" + name
					      + "', info='" + info
					      + "', sex='" + sex
					      + "', hobby='" + hobby
					      + "', Image_src='" + img_src
					      + "' where account='" + Login + "'";
  			Userdb.update(sql);
  			out.print("<script>alert('修改成功！');</script>");
		 }
	}
    		
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
    <script src="js/header.js"></script>
    <style>

    </style>
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


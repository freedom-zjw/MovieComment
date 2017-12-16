User(uid,account, password, name,sex, info,Image_src(头像),hobby,permissions(1为管理员，0为普通用户)) 
电影movie(mid,name,info,tag(标签，就是二级标题),ReleaseTime(上映时间),src(封面), score()评分, Type(movie or TV), hot(0表示不是时下流行，1是时下流行), ) 
评论comments(cid,mid,uid,info(评论内容）,score(给出的评分),commentTime(评论时间),src(影片封面),comment_src(用户自己上传的评论图片))
通知information(iid,uid,info,inforTime(发布通知时间),title(通知标题))
剧照stagephoto(pid, mid，src)
收藏likes(lid,uid,mid)




drop database if exists GoodMovie_15352008;
create database if not exists GoodMovie_15352008 character set utf8;

use GoodMovie_15352008;
create table User(
	uid INT not null AUTO_INCREMENT PRIMARY KEY,
	account varchar(20) unique not null,
	password varchar(20) not null,
 	name varchar(20) default '又偷懒不填昵称',
	Sex varchar(10) default 'unknow',
	info varchar(1000) default '还没有填写简介哦',
	Image_src varchar(500) default  'image/defaultPhoto.jpg',
	hobby varchar(1000) default '还没有填写兴趣哦',
	permission INT not null default 0
)default charset=utf8;

create table movie(
	mid INT not null AUTO_INCREMENT PRIMARY KEY,
	name varchar(50) not null,
	info varchar(1000),
 	tag varchar(50),
	ReleaseTime DATE,
	src varchar(500),
	score float(2,1),
	Type varchar(10),
	hot INT default 0
)default charset=utf8;

create table comments(
	cid INT not null AUTO_INCREMENT PRIMARY KEY,
	mid INT references movie(mid) on delete cascade,
	uid INT references User(uid) on delete cascade,
	info varchar(1000),
	score float(2,1),
	commentTime DATETIME,
	src varchar(500) references movie(src) on delete cascade,
	comment_src varchar(500)
)default charset=utf8;

create table information(
	iid INT not null AUTO_INCREMENT PRIMARY KEY,
	uid INT references User(uid) on delete cascade,
	info varchar(1000),
	inforTime DATETIME,
	title varchar(50)
)default charset=utf8;

create table stagephoto(
	pid INT not null AUTO_INCREMENT PRIMARY KEY,
	mid INT references movie(mid) on delete cascade,
	src varchar(500) not null
)default charset=utf8;

create table likes(
	lid INT not null AUTO_INCREMENT PRIMARY KEY,
	mid INT references movie(mid) on delete cascade,
	uid INT references User(uid) on delete cascade
)default charset=utf8;

Insert into User(account, password, name, Sex, info, Image_src, hobby, permission)
Values("admin","123", '管理员','unkown','我是管理员','头像2.0.png','管理本站', 1);

Insert into User(account, password, name, Sex, info, Image_src, hobby, permission)
Values("user","123", '平民','man','我是平民','头像2.0.png','打打代码', 0);




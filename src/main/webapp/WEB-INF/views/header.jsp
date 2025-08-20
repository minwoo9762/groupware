<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="/css/header.css">
    <link rel="stylesheet" type="text/css" href="/css/lnb.css">
    <link rel="stylesheet" type="text/css" href="/css/home.css">
    <link rel="stylesheet" type="text/css" href="/css/workboard.css">
    <script src="/script/workboard.js"></script>



    <%--<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>--%>
</head>
<body>
    <div id="wrap">
        <header id="header">
            <h1 class="logo">

                <%--<img src="" />--%>
                GROUPWARE
            </h1>


            <div class="util">
                <a class="mypage" href="myPage"><img src="/images/${loginUser.profileimg}" alt="마이페이지"/></a>
                <a class="address" href="address"><img src="/images/address.png" alt="주소록" /></a>
                <a class="logout" href="logout"><img src="/images/logout.png" alt="로그아웃" /></a>
            </div>
        </header>



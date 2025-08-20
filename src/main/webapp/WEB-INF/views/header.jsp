<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="/css/header.css">
    <link rel="stylesheet" type="text/css" href="/css/lnb.css">
    <link rel="stylesheet" type="text/css" href="/css/home.css">

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
                <a class="mypage" href="mypage"><img src="data:image/jpeg;base64,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" alt="마이페이지" /></a>
                <a class="address" href="address"><img src="/images/address.png" alt="주소록" /></a>
                <a class="logout" href="logout"><img src="/images/logout.png" alt="로그아웃" /></a>
            </div>
        </header>



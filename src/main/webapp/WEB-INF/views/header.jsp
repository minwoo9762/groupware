<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="/css/header.css">
    <link rel="stylesheet" type="text/css" href="/css/lnb.css">
    <link rel="stylesheet" type="text/css" href="/css/home.css">
    <link rel="stylesheet" type="text/css" href="/css/workBoard.css">
    <link rel="stylesheet" type="text/css" href="/css/payCheckList.css">
    <link rel="stylesheet" type="text/css" href="/css/mail.css">
    <link rel="stylesheet" type="text/css" href="/css/mypage.css">
    <link rel="stylesheet" type="text/css" href="/css/toast.css">
    <script src="/script/admin.js"></script>
   <%-- <script src="/script/hr.js"></script>--%>
    <script src="/script/workboard.js"></script>
    <script src="/script/toast.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script type="text/javascript">
        $(function() {
            $('#pfimg').change(function() {
                var formSelector = $('#selectImg')[0];
                var formData = new FormData(formSelector);
                $.ajax(
                    {
                        url: "<%=request.getContextPath()%>/fileup",
                        type: "POST",
                        enctype: "multipart/form-data",
                        data: formData,
                        timeout: 10000,
                        contentType: false,
                        processData: false,
                        success: function(data) {
                            $('#profileimgPrev').html(
                                "<img src='/images/" + data.profileimg + "' height='100'>"
                            );
                            $('#profileimg').val(data.profileimg);
                        },
                        error : function() {
                            alert('파일 업로드에 실패했습니다.');
                        }
                    }
                );
            });
        });
    </script>
</head>
<body>
    <div id="wrap">
        <header id="header">
            <h2>
                    The Quintessence of Connectivity
            </h2>

            <div class="util">
                <a class="mypage" href="myPage"><img src="/images/${loginUser.profileimg}" alt="마이페이지"/></a>
                <a class="address" href="address?first=y"><img src="/images/phonelist.png" alt="주소록" /></a>
                <a class="logout" href="logout"><img src="/images/checkout.png" alt="로그아웃" /></a>
            </div>

            <div id="toast"></div>
        </header>



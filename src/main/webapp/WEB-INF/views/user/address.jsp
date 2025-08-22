<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../header.jsp"%>
<section class="section address">
    <%@include file="../lnb.jsp"%>
    <div>
        <h2>Address</h2>
        <div class="tb" style="width: 1000px" >
            <div class="row" style="width: 100%; height:50px; display: flex; align-items: center; text-align: center">
                <div class="coltitle" style="flex: 1">프로필</div>
                <div class="coltitle" style="flex: 1">이름</div>
                <div class="coltitle" style="flex: 2">이메일</div>
                <div class="coltitle" style="flex: 2">전화번호</div>
                <div class="coltitle" style="flex: 1">부서</div>
                <div class="coltitle" style="flex: 1">직급</div>
            </div>
            <c:forEach items="${userList}" var="user" varStatus="status">
                <div class="row" style="width: 100%; height:50px; display: flex; align-items: center; text-align: center">
                    <div class="col" style="flex: 1">
                        <img src="/images/${user.profileimg}"
                        style="width: 50px; height: 50px; border-radius: 50%; object-fit: cover">
                    </div>
                    <div class="col" style="flex: 1">${user.name}</div>
                    <div class="col" style="flex: 2">${user.email}</div>
                    <div class="col" style="flex: 2">${user.phone}</div>
                    <div class="col" style="flex: 1">${infoList[status.index].partName}</div>
                    <div class="col" style="flex: 1">${infoList[status.index].providerName}</div>
                </div>
            </c:forEach>
        </div>
    </div>
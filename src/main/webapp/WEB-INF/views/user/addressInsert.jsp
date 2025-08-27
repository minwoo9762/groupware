<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../header.jsp"%>

<div class="layout" style="display: flex;" id="main">

  <%@include file="../lnb.jsp"%>

  <article>
    <form method="post" action="addressInsert">
        <input type="hidden" name="pwd" value="${dto.pwd}" />
        <input type="hidden" name="address1" value="${dto.address1}" />
        <input type="hidden" name="address2" value="${dto.address2}" />
        <input type="hidden" name="email" value="${dto.email}" />


      <div class="tb">

        <div class="header-row">
          <div class="coltitle">부서명</div>
          <div class="coltitle">직 책</div>
          <div class="coltitle">이 름</div>
          <div class="coltitle">연락처</div>
        </div>

          <div class="row">
            <div class="col">
            <select class="dropdown" name="part">
                <c:forEach items="${partList}" var="part">
                    <option value="${part.id}">${part.name}</option>
                </c:forEach>
            </select>
            </div>

            <div class="col">
            <select class="dropdown" name="provider">
                <c:forEach items="${providerList}" var="provider">
                    <option value="${provider.id}">${provider.name}</option>
                </c:forEach>
            </select>
            </div>

            <div class="col"><input type="text"
                                    style="border: none; font-size: 16px;"
                                    name="name" placeholder="이름을 입력하세요" /></div>
            <div class="col"><input type="text"
                                    style="border: none; font-size: 16px;"
                                    name="phone" placeholder="010-0000-0000" /></div>

          </div>

          <div class="updateBtns">
              <input type="submit" value="작성완료" />
              <input type="button" value="돌아가기" onclick="location.href='address'" />
          </div>

      </div>
    </form>
  </article>
</div>
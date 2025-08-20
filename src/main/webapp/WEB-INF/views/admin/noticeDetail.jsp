<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="../header.jsp" %>
<section class="section admin">
  <%@include file="../lnb.jsp" %>
  <div class="main">
    <h2 class="title">Admin</h2>
    <div class="tableWrap">
      <table>
        <colgroup>
          <col width="150px">
          <col width="">
        </colgroup>
        <tbody>
        <tr>
          <th>제목</th>
          <td style="text-align: left;">${notice.title}</td>
        </tr>
        <tr>
          <th>작성자</th>
          <td style="text-align: left;"><span id="name">${name}</span><span id="email" class="display-none">${notice.userid}</span>
          </td>
        </tr>
        <tr>
          <th>내용</th>
          <td><textarea id="content"></textarea></td>
        </tr>
        <tr>
          <th>이미지</th>
          <td style="height: auto; text-align: left;">

            <div class="fileWrap">
              <div class="customFile">
                <div id="savefilename">${notice.savefilename}</div>
              </div>
              <div id="imagepreview" style="justify-content: flex-start;">
                <img width='150' height='150'  style='margin-top:8px; object-fit: cover' src="images/${notice.image}" />
              </div>
            </div>
          </td>
        </tr>
        </tbody>
      </table>
      <div class="btnWrap topright">
        <button type="button" class="btn btnWrite" onclick="updateNotice(${notice.nseq})">저장하기</button>
        <button type="button" class="btn btnWrite" onclick="location.href='notice'">돌아가기</button>
      </div>
    </div>
  </div>
</section>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="/script/admin.js"></script>
</body>
</html>
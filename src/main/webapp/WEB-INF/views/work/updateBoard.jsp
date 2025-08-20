<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="../header.jsp"%>
<section class="section admin">
  <%@include file="../lnb.jsp"%>

  <%@ page contentType="text/html;charset=UTF-8" language="java" %>

  <%@include file="../header.jsp"%>
  <section class="section admin">
    <%@include file="../lnb.jsp"%>
    <form name="updateBoard" id="updateBoard" method="post" action="updateBoard" >
      <input type="hidden" name="id" value="${dto.id}" />
      <div class="main">
        <h2 class="title" style="font-size:40px;">게시글 수정</h2>
        <div class="tableWrap">
          <div class="table">

            <div class="thead">
              <div class="tr">
                <div class="th" style="flex: 1">작성자</div>
                <div class="th"  style="flex: 6">제 목</div>
              </div>
            </div>

            <div class="tr">
              <div class="th" style="flex: 1">${dto.name}</div>
              <div class="th"  style="flex: 6"><input type="text" name="title" value="${dto.title}"/></div>
            </div>

            <div class="tr">
              <div class="td" >카테고리</div>
              <div class="td" >게시판</div>
            </div>

            <div class="tr" id="textarea">
              <div class="td" style="flex: 1" >내 용</div>
              <div class="td"  style="flex: 6" ><textarea name="content" rows="22" cols="130">${dto.content}</textarea></div>
            </div>
            <div class="field">
                <div class="label">기존 이미지</div>
                <div class="text">
                    <c:choose>
                        <c:when test="${empty oldfilename}">
                            <img src="${pageContext.request.contextPath}/images/noname.jpg" width="100" alt="기본 이미지" />
                        </c:when>
                        <c:otherwise>
                            <img src="${pageContext.request.contextPath}/images/${oldfilename}" width="100" alt="기존 업로드 이미지" />
                        </c:otherwise>
                    </c:choose>
                    <input type="hidden" name="oldfilename" value="${oldfilename}" />
                </div>
            </div>

            <div class="field">
                <label>업데이트 할 이미지</label>
                <input type="button" value="이미지 선택" onclick="selectImg()" />
            </div>

            <div class="field">
                <div class="label">이미지 미리보기</div>
                <c:choose>
                    <c:when test="${empty dto.savefilename}">
                        <div style="flex:4">
                            <img src="" id="previewimg" width="150" style="display: none" alt="미리보기 이미지 없음" />
                        </div>
                        <input type="hidden" name="image" />
                        <input type="hidden" name="savefilename" />
                    </c:when>
                    <c:otherwise>
                        <div style="flex:4">
                            <img src="${pageContext.request.contextPath}/images/${dto.savefilename}" id="previewimg" width="150" alt="업로드 이미지 미리보기" />
                        </div>
                        <input type="hidden" name="image" value="${dto.image}" />
                        <input type="hidden" name="savefilename" value="${dto.savefilename}" />
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="btns">
              <input type="submit" value="수정완료" />
              <input type="button" value="돌아가기" onclick="location.href='boardViewWithoutCnt=${dto.id}'" />
            </div>

          </div>
        </div>
      </div>
    </form>
    <form method="post" enctype="multipart/form-data" id="boardImageForm">
      <div class="field">
        <label>Upload Image</label>
        <input type="file" name="boardimage" id="boardimage" value="이미지 선택"/>
      </div>
    </form>
  </section>
  </body>
  </html>


</section>

</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="../header.jsp"%>
<section class="section admin">
    <%@include file="../lnb.jsp"%>
    <form name="writeBoard" id="writeBoard" method="post" action="writeBoard" >
        <input type="hidden" name="userid" value="${loginUser.id}" />
        <input type="hidden" name="name" value="${loginUser.name}" />
        <input type="hidden" name="part" value="${loginUser.part}" />
    <div class="main">
        <h2 class="title" style="font-size:40px;">게시글 등록</h2>
        <div class="tableWrap">
            <div class="table">

                <div class="thead">
                    <div class="tr">
                        <div class="th" style="flex: 1">작성자</div>
                        <div class="th"  style="flex: 6">제 목</div>
                    </div>
                </div>

                <div class="tr">
                    <div class="th" style="flex: 1">${loginUser.name}</div>
                    <div class="th"  style="flex: 6"><input type="text" name="title" /></div>
                </div>

                <div class="tr">
                    <div class="td" >카테고리</div>
                    <div class="td" >게시판</div>
                </div>

                <div class="tr" id="textarea">
                    <div class="td" style="flex: 1" >내 용</div>
                    <div class="td"  style="flex: 6" ><textarea name="content" rows="22" cols="130" ></textarea> </div>
                </div>

                <div class="field">
                    <label>이미지</label><input type="button" value="이미지 선택" onclick="selectImg()"/>
                </div>

                <div class="field">
                <label>이미지 미리보기</label>
                <c:choose>
                    <c:when test="${empty dto.savefilename}">
                        <div style="flex:4">
                            <img src="" id="previewimg" width="150" style="display: none"/>
                        </div>
                        <input type="hidden" name="image" />
                        <input type="hidden" name="savefilename" />
                    </c:when>
                    <c:otherwise>
                        <div style="flex:4">
                            <img src="/images/${dto.savefilename}" id="previewimg" width="150" />
                        </div>
                        <input type="hidden" name="image" value="${dto.image}"/>
                        <input type="hidden" name="savefilename" value="${dto.savefilename}"/>
                    </c:otherwise>
                </c:choose>

            </div>

                <div class="btns">
                    <input type="submit" value="작성완료" />
                    <input type="button" value="돌아가기" onclick="location.href='workBoard'" />
                </div>

            </div>
        </div>
    </div>
    </form>

</section>
</body>
</html>
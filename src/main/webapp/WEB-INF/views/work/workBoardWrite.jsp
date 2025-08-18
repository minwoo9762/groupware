<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="../header.jsp"%>
<section class="section admin">
    <%@include file="../lnb.jsp"%>
    <form name="writeBoard" id="writeBoard" method="post" action="writeBoard" >
        <input type="hidden" name="userid" value="${loginUser.userid}" />
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
                    <div class="th" style="flex: 1">작성자<%--${loginUser.name}--%></div>
                    <div class="th"  style="flex: 6"><input type="text" name="title" /></div>
                </div>

                <div class="tr">
                    <div class="th" >카테고리</div>
                    <div class="th" >게시판</div>
                    <div class="th" ><label>패스워드</label><input type="password" name="bpwd" /></div>
                </div>

                <div class="tr" id="textarea">
                    <div class="th" style="flex: 1" >내 용</div>
                    <div class="th"  style="flex: 6" ><textarea name="content" rows="22" cols="130" ></textarea> </div>
                </div>
                <div class="field">
                    <label>img</label>
                    <div id="imgPreview"></div>
                    <input type="hidden" name="image" id="image"/>
                </div>

                <div class="btns">
                    <input type="submit" value="작성완료" />
                    <input type="button" value="돌아가기" />
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
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
                    <td style="text-align: left;"><input id="title" class="inputStyle" type="text" value="${notice.title}" required></td>
                </tr>
                <tr>
                    <th>작성자</th>
                    <td style="text-align: left;"><span id="name">${name}</span><span id="email"
                                                                                      class="display-none">${notice.userid}</span>
                    </td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td><textarea id="content" required>${notice.content}</textarea></td>
                </tr>
                <tr>
                    <th>이미지</th>
                    <td style="height: auto; text-align: left;">

                        <div class="fileWrap">
                            <div class="customFile">
                                <div id="savefilename">${notice.savefilename}</div>
                                <label class="btn" for="imageAddBtn">파일 업로드</label>
                            </div>
                            <div id="imagepreview" style="justify-content: flex-start;">
                                <img width='150' height='150' style='margin-top:8px; object-fit: cover'
                                     src="images/${notice.image}"/>
                            </div>
                        </div>
                        <form name="formm" id="fileupForm" method="post" enctype="multipart/form-data">
                            <input class="display-none" type="file" name="fileimage" id="imageAddBtn" value="파일을 선택하세요."
                                   onchange="fileUp();">
                        </form>
                    </td>
                </tr>
                </tbody>
            </table>
            <div class="btnWrap topright">
                <button type="button" class="btn btnWrite" onclick="writeUpdate(${notice.id}, ${notice.nseq})">수정완료</button>
                <button type="button" class="btn btnWrite" onclick="location.href='noticeDetail?nseq='+${notice.nseq}">
                    취소
                </button>
            </div>
        </div>
    </div>
</section>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="/script/admin.js"></script>
</body>
</html>
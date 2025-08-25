<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>title</title>
</head>
<body>
<script type="text/javascript">
    // 부모 창의 히든 필드에 파일명 값 세팅
    opener.document.fileInsertForm.orginalname.value='${originalname}';
    opener.document.fileInsertForm.savedname.value='${savedname}';

    self.close();
</script>
</body>
</html>
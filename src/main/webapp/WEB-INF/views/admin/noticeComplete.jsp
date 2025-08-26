<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<script type="text/javascript">
    opener.document.getElementById('previewimg').setAttribute('src','/images/'+'${savefilename}');
    opener.document.getElementById('previewimg').style.display='inline'; //이미지 미리 보기

    opener.document.noticeUpdate.image.value='${image}';
    opener.document.noticeUpdate.savefilename.value='${savefilename}';
    self.close();
</script>
</body>
</html>

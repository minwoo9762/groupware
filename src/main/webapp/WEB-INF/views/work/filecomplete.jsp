<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<script type="text/javascript">
    opener.document.insertFile.originalname.value='${originalname}';
    opener.document.insertFile.savedname.value='${savedname}';
    self.close();
</script>
</body>
</html>

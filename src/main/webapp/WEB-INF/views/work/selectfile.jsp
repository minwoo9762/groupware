<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script type="text/javascript">
        function selectedfile(){
            document.frm.submit();
        }
    </script>
</head>
<body>
<div id="wrap" align="center" style="width:100%">
    <form name="frm" action="fileinsert" method="post" enctype="multipart/form-data">
        <h1>파일선택</h1>
        <input type="file" name="originalname" onchange="selectedfile();">
    </form>

</div>





</body>
</html>
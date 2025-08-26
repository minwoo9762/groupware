<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script type="text/javascript">
        function selectednoticeimage(){
            document.frm.submit();
        }
    </script>
</head>
<body>
<div id="wrap" align="center" style="width:100%">
    <form name="frm" action="adminFileup" method="post" enctype="multipart/form-data">
        <h1>파일선택</h1>
        <input type="file" name="image" onchange="selectednoticeimage();">
    </form>

</div>





</body>
</html>
function replyBoardCheck(){
    if(document.addBoardRep.content.value==''){
        alert('댓글 내용을 입력하세요');
        return false;
    }
    return true;
}

function replyAppCheck(){
    if(document.addAppRep.content.value==''){
        alert('댓글 내용을 입력하세요');
        return false;
    }
    return true;
}

function deleteBoardReply(id, boardid){
    if(confirm('댓글을 삭제하시겠습니까?')){
        location.href='deleteReply?id=' + id + '&boardid=' + boardid;
    }
}

function deleteAppReply(id, appid){
    if(confirm('댓글을 삭제하시겠습니까?')){
        location.href='deleteReply?id=' + id + '&appid=' + appid;
    }
}

function deleteBoard(id){
    if(confirm('게시물과 해당 게시물의 댓글이 모두 삭제됩니다. 계속하시겠습니까? ')){
        location.href='deleteBoard?id='+id
    }
}

function deleteFile(id){
    if(confirm('파일을 삭제하시겠습니까? ')){
        location.href='deleteFile?id='+id
    }
}


function selectImg(){
    var opt="toolbar=no, menubar=no, resizable=no, width=450, height=200";
    window.open('selectimg','selectimg', opt);
}

function selectFile(){
    document.getElementById("fileInput").click();
}

function go_searchWork(url){
    document.frm.action=url;
    document.frm.submit();
}

function deleteApp(id){
    if(confirm('해당 신청서를 삭제하시겠습니까?')){
        location.href='deleteApp?id='+id
    }
}

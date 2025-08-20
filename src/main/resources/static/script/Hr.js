function deleteVacation(pseq){
    if(confirm("삭제하시겠습니까?")){
        location.href='deleteVacation?pseq=' + pseq;
    }
}

function go_search(url){
    document.fr.action = url;
    document.fr.submit();
}
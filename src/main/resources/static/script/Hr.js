function go_search(url){
    document.fr.action = url;
    document.fr.submit();
}

function go_detail(pseq){
    location.href='payDetail?pseq=' + pseq;
}
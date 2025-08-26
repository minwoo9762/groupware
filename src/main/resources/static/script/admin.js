function userUpdate(target) {
    let userid = target.getAttribute("data-id");
    let subject = target.parentElement.parentElement;

    let partSelect = subject.querySelector(".partSelect").value;
    let providerSelect = subject.querySelector(".providerSelect").value;
    let stateSelect = subject.querySelector(".stateSelect").value;
    console.log(partSelect.value, providerSelect.value, stateSelect.value);

    if(confirm("사용자의 정보를 변경하시겠습니까?")) {
        location.href= `adminUserUpdate?id=${userid}&part=${partSelect}&provider=${providerSelect}`;
        /*location.href= `adminUserUpdate?id=${userid}&part=${partSelect}&provider=${providerSelect}&state=${stateSelect}`;*/
    }

    return;
}

function go_search(target) {
    let inputVal = target.parentElement.querySelector("#key").value;
    let url = location.origin + location.pathname;
    location.href= `${url}?key=${inputVal}`;
}

function writeNotice(id) {
    if(confirm("작성을 완료하시겠습니까?")) {
        let title = document.getElementById("title").value;
        let content = document.getElementById("content").value;
        let name = document.getElementById("name").innerText;
        let email = document.getElementById("email").innerText;
        let image = document.getElementById("imageAddBtn").files
        let savefilename = document.getElementById("savefilename").innerText;

        if(title.length <1) {alert("제목을 입력해주세요."); return;}
        if(content.length <1) {alert("내용을 입력해주세요."); return;}
        if(image.length < 1) {alert("파일첨부는 필수입니다."); return;}

        let formData = {
            id:id,
            title: title,
            content: content,
            userid: email,
            savefilename: savefilename,
            image: savefilename
        }
        $.ajax({
            url: location.origin + "/noticeWriteInsert",
            type: "POST",
            contentType: 'application/json',
            data:  JSON.stringify(formData),
            timeout: 10000,
            processData: false,
            success: function (data) {
                alert("작성이 완료되었습니다.");
                location.href="notice";

            },
            error: function () {
                alert('파일업로드실패');
            }
        });
    }
}





function updateNotice(nseq) {
    location.href = "/noticeUpdateForm?nseq=" + nseq;
}


function adminInsertPay(useridN) {
    let id = useridN;
    let updatePay = document.getElementById("updatePay").value;
    let title = document.getElementById("title").value;
    let content = document.getElementById("content").value;

    if(!updatePay) {alert("급여를 작성해주세요."); document.getElementById("updatePay").focus(); return}
    if(!title) {alert("제목을 작성해주세요."); document.getElementById("title"); return}
    if(!content) {alert("내용을 작성해주세요."); document.getElementById("content").focus(); return}

    let formData = {
        pay: updatePay,
        title: title,
        content: content
    }

    $.ajax({
        url: location.origin + "/adminInsertPay?id=" + id,
        type: "POST",
        contentType: 'application/json',
        data:  JSON.stringify(formData),
        timeout: 10000,
        processData: false,
        success: function (data) {
            alert("급여 저장이 완료되었습니다.");
            location.href="admin";
        },
        error: function () {
            alert('파일업로드실패');
        }
    });

}

function adminUpdatePay(useridN) {
    let id = useridN;
    let updatePay = document.getElementById("updatePay").value;
    let title = document.getElementById("title").value;
    let content = document.getElementById("content").value;

    if(!updatePay) {alert("급여를 작성해주세요."); document.getElementById("updatePay").focus(); return}
    if(!title) {alert("제목을 작성해주세요."); document.getElementById("title"); return}
    if(!content) {alert("내용을 작성해주세요."); document.getElementById("content").focus(); return}

    let formData = {
        pay: updatePay,
        title: title,
        content: content
    }

    $.ajax({
        url: location.origin + "/adminUpdatePay?id=" + id,
        type: "POST",
        contentType: 'application/json',
        data:  JSON.stringify(formData),
        timeout: 10000,
        processData: false,
        success: function (data) {
            alert("급여 수정이 완료되었습니다.");
            location.href="admin";
        },
        error: function () {
            alert('파일업로드실패');
        }
    });

}

function deleteInfo(target) {
    let tr = target.parentElement.parentElement;
    let tl = tr.querySelector(".tl").querySelector("input[name=id]").value;
    tr.remove();
    location.href = location.pathname + location.search + "&delete=true&deleteid=" + tl;
}

function noticeImg(){
    var opt="toolbar=no, menubar=no, resizable=no, width=450, height=200";
    window.open('noticeimg','noticeimg', opt);
}
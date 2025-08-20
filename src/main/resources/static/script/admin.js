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
        let image = document.getElementById("imageAddBtn").files[0].name;
        let savefilename = document.getElementById("savefilename").innerText;

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

function fileUp() {
    let formselect = $("#fileupForm")[0];
    let formData = new FormData( formselect );
    $.ajax({
        url: location.origin + "/adminFileup",
        type: "POST",
        enctype: "multipart/form-data",
        data: formData,
        timeout: 10000,
        contentType: false,
        processData: false,
        success: function (data) {
            $('#imagepreview').html("<img src='images/" + data.savefilename + "' width='150' height='150'  style='margin-top:8px;  object-fit: cover'/>");
            $('#image').val( data.image);
            $('#savefilename').html(data.savefilename);
        },
        error:function () {
            alert("실패");
        },
    });
}
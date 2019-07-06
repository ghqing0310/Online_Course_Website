$(document).ready(function(){
    $("#addChapterForm").validate({
        submitHandler:function (form) {
            const chapterName = $("#chapterName").val();
            $("#chapterNameMessage").remove();
            if (chapterName === ""){
                $("#chapterNameInput").after("<div class='modal-body' id='chapterNameMessage' style=\"color: red\">章节名称不能为空！</div>");
                return;
            }
            form.submit();
        }
    });

    $("#dropCourseForm").validate({
        submitHandler:function (form) {
            const password = $("input[name='password']").val();
            $("#passwordMessage").remove();
            if (password === ""){
                $("#passwordInput").after("<div class='modal-body' id='passwordMessage' style=\"color: red\">密码不能为空！</div>");
                return;
            }
            form.submit();
        }
    });

    for (var i = 1; i < 100; i++) {
        const t = i;
        $(".addPointForm" + i).validate({
            submitHandler: function (form) {
                const pointName = $("#pointName" + t).val();
                $(".pointNameMessage").remove();
                if (pointName === "") {
                    $(".pointNameInput" + t).after("<div class='pointNameMessage modal-body' style=\"color: red\">知识点名称不能为空！</div>");
                    return;
                }
                form.submit();
            }
        });
        $(".updateChapterForm" + i).validate({
            submitHandler: function (form) {
                const chapterName = $("#chapterName" + t).val();
                $(".chapterNameMessage").remove();
                if (chapterName === "") {
                    $(".chapterNameInput" + t).after("<div class='pointNameMessage modal-body' style=\"color: red\">章节名称不能为空！</div>");
                    return;
                }
                form.submit();
            }
        });
    }
});

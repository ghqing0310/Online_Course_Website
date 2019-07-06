$(function () {
    for (var i = 1; i < 100; i++) {
        const t = i;
        $("#dropCourseForm" + i).validate({
            submitHandler: function (form) {
                const password = $("#password" + t).val();
                $(".passwordMessage").remove();
                if (password === "") {
                    $("#passwordInput" + t).after("<div class='pointNameMessage modal-body' style=\"color: red\">密码不能为空！</div>");
                    return;
                }
                form.submit();
            }
        });
    }
});
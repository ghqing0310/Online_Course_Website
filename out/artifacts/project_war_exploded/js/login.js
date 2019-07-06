$(function () {
    $("#loginForm").validate({
        submitHandler:function (form) {
            const username = $("input[name='username']").val();
            const password = $("input[name='password']").val();
            $("#usernameMessage").remove();
            $("#passwordMessage").remove();
            if (username === ""){
                $("#usernameInput").after("<div id='usernameMessage' style=\"color: red\">用户名不能为空！</div>");
                return;
            }
            if (password === ""){
                $("#passwordInput").after("<div id='passwordMessage' style=\"color: red\">密码不能为空！</div>");
                return;
            }
            form.submit();
        }
    });
});
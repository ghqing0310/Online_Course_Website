$(function () {
    $("#registerForm").validate({
        submitHandler:function (form) {
            const username = $("input[name='username']").val();
            const password = $("input[name='password']").val();
            const passwordRepeat = $("input[name='passwordRepeat']").val();
            const type = $("input:radio:checked").val();
            $("#usernameMessage").remove();
            $("#passwordMessage").remove();
            $("#passwordRepeatMessage").remove();
            $("#typeMessage").remove();
            if (username === ""){
                $("#usernameInput").after("<div id='usernameMessage' style=\"color: red\">用户名不能为空！</div>");
                return;
            }
            if (password === ""){
                $("#passwordInput").after("<div id='passwordMessage' style=\"color: red\">密码不能为空！</div>");
                return;
            } else if (password.length < 6 || !isNaN(password)){
                $("#passwordInput").after("<div id='passwordMessage' style=\"color: red\">密码不能小于6位，且不得为纯数字！</div>");
                return;
            }
            if (passwordRepeat === ""){
                $("#passwordRepeatInput").after("<div id='passwordRepeatMessage' style=\"color: red\">重复输入不能为空！</div>");
                return;
            } else if (passwordRepeat !== password){
                $("#passwordRepeatInput").after("<div id='passwordRepeatMessage' style=\"color: red\">两次输入的密码应相同！</div>");
                return;
            }
            if (type === undefined){
                $("#typeInput").after("<div id='typeMessage' style=\"color: red\">身份不能为空！</div>");
                return;
            }
            form.submit();
        }
    });
});
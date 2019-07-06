$(function () {
    $("#codeForm").validate({
        submitHandler:function (form) {
            const code = $("input[name='code']").val();
            $("#codeMessage").remove();
            if (code === ""){
                $("#codeInput").after("<div id='codeMessage' style=\"color: red\">验证码不能为空！</div>");
                return;
            } else {
                const reg = /^[1-9]+[0-9]*]*$/;
                isOk= reg.test(code);
                if(!isOk) {
                    $("#codeInput").after("<div id='codeMessage' style=\"color: red\">请输入数字！</div>");
                    return
                }
            }
            form.submit();
        }
    });
});
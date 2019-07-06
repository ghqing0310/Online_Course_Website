$(function () {
    $("#mailForm").validate({
        submitHandler:function (form) {
            const mail = $("input[name='mail']").val();
            $("#mailMessage").remove();
            if (mail === ""){
                $("#mailInput").after("<div id='mailMessage' style=\"color: red\">邮箱不能为空！</div>");
                return;
            } else {
                const reg = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/;
                isOk= reg.test(mail);
                if(!isOk) {
                    $("#mailInput").after("<div id='mailMessage' style=\"color: red\">邮箱格式不正确！</div>");
                    return
                }
            }
            form.submit();
        }
    });
});
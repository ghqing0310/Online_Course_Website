$(function () {
    $("#openCourseForm").validate({
        submitHandler:function (form) {
            const courseName = $("input[name='courseName']").val();
            const courseDescription = $("input[name='courseDescription']").val();
            const coursePicture = $("input[name='coursePicture']").val();
            $("#courseNameMessage").remove();
            $("#courseDescriptionMessage").remove();
            $("#coursePictureMessage").remove();
            if (courseName === ""){
                $("#courseNameInput").after("<div id='courseNameMessage' style=\"color: red\">课程名称不能为空！</div>");
                return;
            }
            if (courseDescription === ""){
                $("#courseDescriptionInput").after("<div id='courseDescriptionMessage' style=\"color: red\">课程介绍不能为空！</div>");
                return;
            }
            if (coursePicture === ""){
                $("#coursePictureInput").after("<div id='coursePictureMessage' style=\"color: red\">课程图片不能为空！</div>");
                return;
            }
            form.submit();
        }
    });
});
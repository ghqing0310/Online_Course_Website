$(function () {
    $("#addChoiceForm").validate({
        submitHandler: function (form) {
            const question = $("input[name='choiceQuestion']").val();
            const answerA = $("input[name='answerA']").val();
            const answerB = $("input[name='answerB']").val();
            const answerC = $("input[name='answerC']").val();
            const rightAnswer = $("input[name='rightAnswer']:radio:checked").val();
            $("#choiceMessage").remove();
            if (question === "") {
                $("#choiceInput").after("<div id='choiceMessage' class='modal-body' style=\"color: red\">问题不能为空！</div>");
                return;
            } else if (answerA === "") {
                $("#choiceInput").after("<div id='choiceMessage' class='modal-body' style=\"color: red\">选择A不能为空！</div>");
                return;
            } else if (answerB === ""){
                $("#choiceInput").after("<div id='choiceMessage' class='modal-body' style=\"color: red\">选择B不能为空！</div>");
                return;
            } else if (rightAnswer === undefined){
                $("#choiceInput").after("<div id='choiceMessage' class='modal-body' style=\"color: red\">正确答案不能为空！</div>");
                return;
            } else if (rightAnswer === "C" && answerC === ""){
                $("#choiceInput").after("<div id='choiceMessage' class='modal-body' style=\"color: red\">选择C不能为空！</div>");
                return;
            }
            form.submit();
        }
    });

    for (var i = 1; i <= 100; i++){
        const t = i;
        $("#updateChoiceForm" + i).validate({
            submitHandler: function (form) {
                const question = $("#choiceQuestion" + t).val();
                const answerA = $("#answerA" + t).val();
                const answerB = $("#answerB" + t).val();
                const answerC = $("#answerC" + t).val();
                const rightAnswer = $("#rightAnswerC" + t + ":checked").val();
                $(".choiceMessage").remove();
                if (question === "") {
                    $("#choiceUpdateInput" + t).after("<div class='choiceMessage modal-body' style=\"color: red\">问题不能为空！</div>");
                    return;
                } else if (answerA === "") {
                    $("#choiceUpdateInput" + t).after("<div class='choiceMessage modal-body' style=\"color: red\">选择A不能为空！</div>");
                    return;
                } else if (answerB === ""){
                    $("#choiceUpdateInput" + t).after("<div class='choiceMessage modal-body' style=\"color: red\">选择B不能为空！</div>");
                    return;
                } else if (rightAnswer === "C" && answerC === ""){
                    $("#choiceUpdateInput" + t).after("<div class='choiceMessage modal-body' style=\"color: red\">选择C不能为空！</div>");
                    return;
                }
                form.submit();
            }
        });
        $("#updateQuestionForm" + i).validate({
            submitHandler: function (form) {
                const question = $("#question" + t).val();
                $(".questionMessage").remove();
                if (question === "") {
                    $("#questionUpdateInput" + t).after("<div class='questionMessage modal-body' style=\"color: red\">问题不能为空！</div>");
                    return;
                }
                form.submit();
            }
        });
    }

    $("#addQuestionForm").validate({
        submitHandler: function (form) {
            const question = $("input[name='question']").val();
            $("#questionMessage").remove();
            if (question === "") {
                $("#questionInput").after("<div id='questionMessage' class='modal-body' style=\"color: red\">问题不能为空！</div>");
                return;
            }
            form.submit();
        }
    });

    $("#addAnswerForm").validate({
        submitHandler: function (form) {
            const choiceNumber = $("input[name='choiceNumber']").val();
            for (var i = 1; i <= choiceNumber; i++){
                const choice = $("input[name='choice" + i + "']:radio:checked").val();
                $("#answerMessage").remove();
                if (choice === undefined){
                    $("#answerInput").after("<div id='answerMessage' style=\"color: red\">回答不能为空！</div>");
                    return;
                }
            }
            const questionNumber = $("input[name='questionNumber']").val();
            for (i = 1; i <= questionNumber; i++){
                const answer = $("textarea[name='answer" + i + "']").val();
                $("#answerMessage").remove();
                if (answer === ""){
                    $("#answerInput").after("<div id='answerMessage' style=\"color: red\">回答不能为空！</div>");
                    return;
                }
            }
            form.submit();
        }
    });
});
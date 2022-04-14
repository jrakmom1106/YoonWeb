<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
</head>
<body>
<form id="frm">
    <input type="text" placeholder="제목" id="subject" name="subject">
    <input type="text" placeholder="내용" id="content" name="content">
    <button type="button" onclick="fn_boardRegi();">등록</button>
</form>
</body>
</html>
<script src='/js/jquery-3.6.0.min.js?ver=1'></script>
<script src='/assets/lib/yoon/common.js'></script>
<script>
    function fn_boardRegi(){
        let title = $("#subject").val();

        let content = $("#content").val();
        let $globalStorage = $commons.storage.g_variable;
        let writer = $globalStorage.getValue("loginUser");
        let date = $commons.util.date();


        $.ajax({
            type : "POST",
            url : "/board/register",
            data : {title : title,content : content,writer: writer,regdate: date,viewcnt:0},
            success: function(data){
                if(data == "Y"){
                    alert("글 등록이 완료되었습니다.");

                }
            },
            error: function(data){
                alert("실패");
                console.log(data);
            }
        });
    };
</script>
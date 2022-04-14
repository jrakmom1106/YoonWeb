<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
<style>
    .board{
        width: 100%;
    }
</style>
</head>
<body>
<div id="content">
    <div id="contentwrap">


        <form id="frm">
            <input type="text" placeholder="제목" id="subject" name="subject">
            <input type="text" placeholder="내용" id="writecontent" name="content">
            <button type="button" onclick="fn_boardRegi();">등록</button>
        </form>

    </div>
</div>
</body>
</html>
<script src='/js/jquery-3.6.0.min.js?ver=1'></script>

<script>
    function fn_boardRegi(){
        let title = $("#subject").val();

        let content = $("#writecontent").val();
        let $globalStorage = $commons.storage.g_variable;
        let writer = $globalStorage.getValue("loginUser");
        let date = $commons.util.date();

        fetch("/board/register.do",{
            method: 'POST',
            headers: {
                'content-type' : 'application/json'
            },
            body: JSON.stringify({
                title: title,
                content : content,
                writer : writer,
                regdate: date,
                viewcnt : 0
            })
        }).then(res => res.json())
        .then(data => {
            console.log(data);
        })

    };
</script>
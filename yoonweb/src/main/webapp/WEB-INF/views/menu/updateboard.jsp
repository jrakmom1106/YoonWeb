<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <style>
        .uploadimage {
            width: 50px;
            height: 50px;
        }

        ul {
            list-style: none;
        }

        .fileuploder label {
            display: inline-block;
            padding: .5em .75em;
            font-size: inherit;
            line-height: normal;
            vertical-align: middle;
            background-color: #cae1f2;
            cursor: pointer;
            border: 1px solid #ebebeb;
            border-bottom-color: #e2e2e2;
            border-radius: .25em;
        }

        .fileuploder input[type="file"] {
            position: absolute;
            width: 1px;
            height: 1px;
            padding: 0;
            margin: -1px;
            overflow: hidden;
            clip: rect(0, 0, 0, 0);
            border: 0;
        }
    </style>
</head>
<div id="updateboardcontent">

    <form id="form" class="form">
        <input type="hidden" id="bno" name="bno" value="${bno}"/>
    </form>
    <h2>제목 : <input type="text" value="${title}" class="titletext"/> </h2>
    <h2>내용 : <input type="text" value="${content}" class="contenttext"/> </h2>
    <h3 class="fileuploder"> 파일첨부 :
        <label for="ex_file">파일 등록</label>
        <input type="file" id="ex_file" name="filename" multiple>
    </h3>
    <div>
        <a class="file"></a>
    </div>
    <br>
    <button class="backbtn">뒤로가기</button>
    <button class="updatebtn">수정하기</button>
</div>
</body>
</html>
<script src='/js/jquery-3.6.0.min.js?ver=1'></script>

<script>


    $(document).ready(function(){


        let upbtn = document.querySelector('.updatebtn');
        let backbtn = document.querySelector('.backbtn');
        let $history = $commons.history;
        let content = document.querySelector('#content');

        let titletx = document.querySelector('.titletext');
        let contenttx = document.querySelector('.contenttext');


        let form = new FormData(document.getElementById('form'));
        console.log("form");
        console.log(form);
        jQuery.ajax({
            url: "/board/boardDetail.do",
            data: form,
            type: "POST",
            dataType: "json",
            processData: false,
            contentType: false,
            success: function (data) {
                console.log("ajax here");
                console.log(data);
            },
            error: function (err) {
                console.log(err);
            }
        });



        upbtn.onclick = function(){

            fetch("/board/update.do",{
                method: "POST",
                headers: {
                    'content-type' : 'application/json'
                },
                body : JSON.stringify({
                    title: titletx.value,
                    content: contenttx.value,
                    bno: "${bno}"
                })
            });

            let url = 'menu/menu1.do'
            $('#main_content').load(url,function(){
                $history.deletehistory("/board/updateboard.do");
            });

        }


        backbtn.onclick = function(){
            let oldelement = document.querySelector('#updateboardcontent');
            let back = $history.gethistory("/board/updateboard.do");
            console.log(back.content);
            content.replaceChild(back.content,oldelement);
            $history.deletehistory("/board/updateboard.do");
        }

    });


</script>
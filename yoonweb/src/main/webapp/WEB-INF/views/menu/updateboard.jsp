<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div id="updateboardcontent">
    <h2>제목 : <input type="text" value="${title}" class="titletext"/> </h2>
    <h2>내용 : <input type="text" value="${content}" class="contenttext"/> </h2>


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
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

    <div id="contentwrap2">


            <input type="text" placeholder="제목" id="subject" name="subject">
            <input type="text" placeholder="내용" id="writecontent" name="content">

        <form id="form1" action="uploadForm" method="post"
              enctype="multipart/form-data" target="zeroFrame">
            <input type="file" name="file"/>
            <input type="submit" />
        </form>

        <iframe name="zeroFrame"></iframe>


            <button type="button" class="reg">등록</button>
            <button type="button" class="backbtn">취소</button>

    </div>

</body>
</html>
<script src='/js/jquery-3.6.0.min.js?ver=1'></script>

<script>
    $(document).ready(function(){

        //test
        function addFilePath(msg){
            alert(msg);
            document.getElementById("form1").reset();
        }






        let title = document.querySelector('#subject');
        let content = document.querySelector('#writecontent');
        let $globalStorage = $commons.storage.g_variable;
        let writer = $globalStorage.getValue("loginUser");
        let date = $commons.util.date();
        let regibtn = document.querySelector('.reg');

        let backbtn = document.querySelector('.backbtn');
        let $common = $commons.history
        let changecontent =document.querySelector('#content');


        backbtn.onclick = function(){

            console.log('click back')
            let test = $common.gethistory("/regi/loader.do");
            console.log(test.content);
            // $('#content').load("/menu/menu1.do",function (){
            //
            // });

            let oldElement = document.querySelector('div#contentwrap2');
            changecontent.replaceChild(test.content,oldElement);

        };

        regibtn.onclick = function(){


            fetch("/board/register.do",{
                method: 'POST',
                headers: {
                    'content-type' : 'application/json'
                },
                body: JSON.stringify({
                    title: title.value,
                    content : content.value,
                    writer : writer,
                    regdate: date,
                    viewcnt : 0
                })
            }).then(res => res.json());

            $common.deletehistory("/regi/loader.do");

            let url = 'menu/menu1.do'
            $('#main_content').load(url,function(){

            });


        }






    });


</script>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
<style>
    .board{
        width: 100%;
    }
    .ui-helper-hidden-accessible{
        display:none;
    }
</style>
</head>
<body>
<div id="content" class="menu2_tab">
    <div id="contentwrap">


        <table border="1" class="board">
            <thead>
            <tr>
                <th>회원 아이디</th>
                <th>회원 비밀번호</th>
                <th>중복확인</th>
                <th>바꾸실 이름</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <th><input id="autoCompleteInput" class="input_id"/></th>
                <th><input id="user_pw" class="input_pw"/></th>
                <th><button class="auth_check_btn">중복확인</button></th>
                <th><input id="user_id" class="input_name"/></th>
            </tr>
            <tr>
                <th><input  class="input_id"/></th>
                <th><input  class="input_pw"/></th>
                <th><button class="auth_check_btn">중복확인</button></th>
                <th><input  class="input_name"/></th>
            </tr>
            </tbody>
            <!-- forEach 문은 리스트 객체 타입을 꺼낼때 많이 활용된다. -->
        </table>
        <br>
        <button id="check_btn">테스트</button>

        <%--<form id="frm">
            <input type="text" placeholder="제목" id="subject" name="subject">
            <input type="text" placeholder="내용" id="writecontent" name="content">
            <button type="button" onclick="fn_boardRegi();">등록</button>

        </form>--%>

    </div>
</div>
</body>
</html>
<link rel="stylesheet"
      href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src='/js/jquery-3.6.0.min.js?ver=1'></script>
<script src='/js/jquery-ui.js?ver=1'></script>
<script type="text/javascript">

    $(document).ready(function () {

        let container = document.querySelector(".menu2_tab");

        let auto_input =  container.querySelector("#autoCompleteInput");
        let user_pw = container.querySelector("#user_pw");
        let check_btn = container.querySelector("#check_btn");


        let input_name = container.querySelectorAll(".input_name");
        let input_pw = container.querySelectorAll(".input_pw");
        let input_id = container.querySelectorAll(".input_id");

        let check_user_btn = container.querySelectorAll(".auth_check_btn");



        $("#autoCompleteInput",container).autocomplete({
            source: function(request,response){
                $.ajax({
                    url: 'member/memberAutomplete.do',
                    type : "POST",
                    contentType : "application/json",
                    data : JSON.stringify({VALUE : request.term}),
                    success : function (responseData){
                        response(
                            $.map(responseData , function(item){
                                return{
                                    value : item.MEMBERID,
                                    label : item.MEMBERID
                                }
                            })
                        )
                    },
                    error: function(){

                    }
                });
            },
            create : function(event , ui){
                $(this).data('ui-autocomplete')._renderItem = function(ul,item){
                    /*ul.addClass('auto-search__list');*/
                    let label = item.label.replace($("#autoCompleteInput",container).val(),'');
                    let element = $('<div><mark>'+$("#autoCompleteInput",container).val()+'</mark>'+ label +'</div>');
                    return $('<li></li>').append(element).appendTo(ul);
                }
            },
            focus: function(event,ui){
                return false;
            },
            minLength: 1,
            autoFocus : true,
            delay : 300,
            classes : {
                'ui-autocomplete': 'highlight'
            },
            /*appendTo : 해당 옵션 body에 만들지 container 와 같은 탭 영역에 생성해서 생명주기 조절 가능*/
            select: function(evt,ui){
                // 선택시 이벤트 부여 가능
            }

        });



        //중복확인 check event
        for(let i = 0 ; i < check_user_btn.length ; i++){

            $(check_user_btn[i]).on('click',function(){
                console.log(this);




            })
        }


        check_btn.onclick = async function(){

            console.log()

            let sendArray = [];
            for(let i = 0 ; i < input_id.length ; i++){

                let data = {
                    user_id : input_id[i].value,
                    user_pw : input_pw[i].value,
                    user_name :input_name[i].value
                }

                sendArray.push(data);

            }



            let sendReuslt = await $.ajax({
                url: 'member/ArrayListSample.do',
                type : "POST",
                contentType : "application/json",
                data : JSON.stringify(sendArray),
                success : function (responseData){

                },
                error: function(){

                }
            });

            console.log(sendReuslt)


        }





    });




    /*function fn_boardRegi(){
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

    };*/
</script>
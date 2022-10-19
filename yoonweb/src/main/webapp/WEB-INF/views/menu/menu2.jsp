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
                <th>
                    <button class="auth_check_btn">존재여부</button>
                    <input type="hidden" class="auth_check_yn" value="N"/>
                </th>
                <th><input id="user_id" class="input_name"/></th>
            </tr>
            <tr>
                <th><input  class="input_id"/></th>
                <th><input  class="input_pw"/></th>
                <th>
                    <button class="auth_check_btn">존재여부</button>
                    <input type="hidden" class="auth_check_yn" value="N"/>
                </th>
                <th><input  class="input_name"/></th>
            </tr>
            </tbody>
            <!-- forEach 문은 리스트 객체 타입을 꺼낼때 많이 활용된다. -->
        </table>
        <br>
        <button id="check_btn">테스트</button>
        <button id="reset_btn">초기화</button>

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
        let reset_btn = container.querySelector("#reset_btn");


        let input_name = container.querySelectorAll(".input_name");
        let input_pw = container.querySelectorAll(".input_pw");
        let input_id = container.querySelectorAll(".input_id");

        let check_user_btn = container.querySelectorAll(".auth_check_btn");
        let auth_check_yn = container.querySelectorAll(".auth_check_yn");



        $("#autoCompleteInput",container).autocomplete({
            source: function(request,response){
                $.ajax({
                    url: 'member/memberAutoComplete.do',
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

            $(check_user_btn[i]).on('click',async function(){
                console.log(this);

                if(!(input_id[i].value) || !(input_pw[i].value)){
                    alert('아이디와 비밀번호를 입력해 주세요');
                    return;
                }


                let data = {
                    user_id : input_id[i].value,
                    user_pw : input_pw[i].value
                }

                let sendReuslt = await $.ajax({
                    url: 'member/checkMemeber.do',
                    type : "POST",
                    contentType : "application/json",
                    data : JSON.stringify(data),
                    success : function (responseData){

                    },
                    error: function(){

                    }
                });

                debugger;

                if(sendReuslt === 0 ) {
                    auth_check_yn[i].value = 'N';
                    alert('존재하지 않는 회원입니다. 아이디와 비밀번호를 확인해주세요')
                    return;
                }

                alert('존재하는 아이디 입니다.');
                auth_check_yn[i].value = 'Y';


            })
        }


        check_btn.onclick = async function(){


            for(let idx in auth_check_yn){

                if(auth_check_yn[idx].value == 'N'){
                    let cnt = Number(idx) + 1;
                    alert(cnt+" 번 라인 아이디 존재여부 확인을 먼저 해주세요");
                    return;
                }
            }



            for(let idx in input_name){
                if(input_name[idx].value == ''){
                    let cnt = Number(idx) + 1;
                    alert(cnt+" 번째 변경할 이름을 넣어주세요. 빈값은 넣을 수 없습니다.");
                    return;
                }
            }


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
                    clearInputBox();
                    alert('회원정보 수정이 완료되었습니다.');


                },
                error: function(){

                }
            });




        }

        reset_btn.onclick = function(){
            clearInputBox();
        }



        function clearInputBox(){

            for(let i = 0; i < input_name.length; i++){
                input_name[i].value = '';
                input_pw[i].value = '';
                input_id[i].value = '';
                auth_check_yn[i].value = 'N';

            }

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
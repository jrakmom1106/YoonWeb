<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <link rel="stylesheet" href="/assets/css/join.css">
</head>
<body>

<div class="wrapper">
    <form action="">
        <div class="wrap">
            <div class="subjecet">
                <span>회원가입</span>
            </div>
            <div class="id_wrap">
                <div class="id_name">아이디</div>

                <div class="id_input_box">
                    <input class="id_input">
                </div>
                <input type="button" class="id_name_checkauth" value="중복확인"/>
                <span class="id_input_correct">사용가능한 아이디 입니다.</span>
                <span class="id_input_incorrect">중복된 아이디 입니다.</span>
                <span class="id_input_exist">이미 사용중인 아이디 입니다.</span>
            </div>
            <div class="pw_wrap">
                <div class="pw_name">비밀번호</div>
                <div class="pw_input_box">
                    <input class="pw_input">
                </div>
            </div>
            <div class="pwck_wrap">
                <div class="pwck_name">비밀번호 확인</div>
                <div class="pwck_input_box">
                    <input class="pwck_input">
                    <span class="pw_input_correct">비밀번호 일치</span>
                    <span class="pw_input_incorrect">비밀번호를 다시 확인해 주세요</span>
                </div>
            </div>
            </div>
            <div class="join_button_wrap">
                <input type="button" class="join_button" value="가입하기">
            </div>
        </div>
    </form>
</div>

</body>
<script src='/js/jquery-3.6.0.min.js?ver=1'></script>
<script>

    let initialize = function () {

        let authcheckbtn = document.querySelector('.id_name_checkauth');
        let idtext = document.querySelector('.id_input');
        let pwtext = document.querySelector('.pw_input');
        let pwcheck = document.querySelector('.pwck_input');
        let idexist = document.querySelector('.id_input_exist');
        let joinbtn = document.querySelector('.join_button');




        pwcheck.onchange = function(){

            if(pwtext.value == pwcheck.value){
                $('.pw_input_correct').css("display","inline-block"); // 사용할 수 있습니다.
                $('.pw_input_incorrect').css("display", "none");
            } else{
                $('.pw_input_incorrect').css("display","inline-block"); // 사용할 수 없습니다.
                $('.pw_input_correct').css("display", "none");
            }
        }


        authcheckbtn.onclick = async function () {

                let chk = await authCheck();

                if(chk.state == 'success'){
                    $('.id_input_correct').css("display","inline-block"); // 사용할 수 있습니다.
                    $('.id_input_incorrect').css("display", "none");
                } else {
                    $('.id_input_incorrect').css("display","inline-block"); // 사용할 수 없습니다.
                    $('.id_input_correct').css("display", "none");
                }

        }

        joinbtn.onclick = async function(){

            let chk = await authCheck();
            if(pwtext.value !== pwcheck.value){
                alert('비밀번호가 일치하지 않습니다. 다시 확인해 주세요')
                return;
            }
            if(chk.state == 'fail'){
                $('.id_input_exist').css("display","inline-block");
                return;
            }

            authJoin();
            opener.parent.location.reload();
            window.close();

        }


        function authJoin() {

            fetch("/auth/authjoin.do",{
                method: 'POST',
                headers: {
                    'content-type' : 'application/json'
                },
                body: JSON.stringify({
                    ID :idtext.value,
                    PW :pwtext.value
                })
            });
        }

        function authCheck() {

                let id = idtext.value;
                let response = fetch("/join/authjoincheck.do",{
                    method : 'POST',
                    headers: {
                        'content-type' : 'application/json'
                    },
                    body: JSON.stringify({
                        memberId : id
                    })
                });
                return response.then(res=> res.json());
            }


    }

    $(function () {
        initialize();
    });
</script>
</html>
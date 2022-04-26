<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script src="/assets/css/stylesheet.css"></script>

    <style>
        #container {
        }

        .header_text {
            float: left;
            margin-left: 60px;
            margin-top: 35px;
        }
        .loginidname{
            float: left;
            margin-right:10px ;
        }
        .helloword{
            margin-top: 29px;
            display: flex;
            display: none;
        }
        .logout{
            font-size: 12px;
            font-weight: bold;
            display: none;
            float: left;
            position: relative;
            top: 10px;
            left: 281px;
        }

        .header {
            background-color: #EEEFF1;
            position: relative;
            box-sizing: border-box;
            padding: 0 30px 0 26px;
            height: 150px;
            overflow: hidden;
        }

        .imgcontainer {
            float: left;
            width: 180px;
            margin-top: 10px;

        }

        .imgcontainer img {
            border-radius: 65%;
            width: 130px;
            height: 130px;
            text-align: center;


        }

        .header_login {
            position: absolute;
            left: 1350px;
            float: right;
        }


        .gnb {
            width: 150px;
            padding: 0px;
            position: fixed;
            margin-left: 10px;
            height: 700px;
        }

        sidebar_menu a {
            background-color: #FF6347;
            color: white;
        }

        sidebar_menu a:hover:not(.current) {
            background-color: #CD853F;
            color: white;
        }

        .sidebar_menu {
            list-style-type: none;
            width: 150px;
            height: 100%;
            padding: 0px;

            border: solid 1px black;
        }

        .sidebar_menu li {
            border-bottom: solid 1px black;
        }

        .sidebar_menu li:last-child {
            /*border-bottom: none;*/
        }

        .sidebar_menu a {
            display: block;
            color: #000000;
            padding: 8px;
            text-align: center;
            text-decoration: none;
            font-width: bold;
        }

        .sidebar_menu a:hover {
            background-color: #CD853F;
            color: white;
        }

        * {
            box-sizing: border-box;
            font-family: 'Noto Sans KR', sans-serif;
            border-radius: 5px;
        }

        .login-form {
            display: flex;
            margin-top: 11px;
            width: 300px;
            padding: 20px;
            text-align: center;
            border: none;

        }

        .text-field {
            font-size: 14px;
            padding: 10px;
            border: none;
            margin-bottom: 5px;

        }

        .submit-btn {
            font-size: 14px;
            border: none;
            padding: 10px;
            width: 100px;
            background-color: #1BBC9B;
            color: white;
            height: 90px;
        }

        .login-form-input {
            flex: 2;
        }

        .login-form-submit {
            flex: 1;
            width: 50px;
            margin-left: 10px;
            float: right;
        }
        .authjoin{
            float: left;
            font-size: 12px;
            font-weight: bold;
            padding-left: 4px;
        }


        .main {
            margin-left: 170px;
        }

        #tabmenu{
            background-color: #d8dde5;
            margin-top: 10px;
            height: 50px;
            margin-bottom: 0px;
            padding-top: 13px;
            padding-left: 0px;
        }
        #tabmenu li{
            display: inline-block;
            margin-left: 10px;
            width: 150px;
            height: 40px;
            /*padding-top: 5px;*/
        }
        a{
            text-decoration: none;
            color: black;
        }
        .tab-menu-click{
            display: inline-block;
            width: 150px;
            background-color: white;
            height: 40px;

        }
        .tabmenulist{
            /*padding-top: 5px;*/
        }
        .tabmenulist input{
            float: right;
            text-align: center;
            padding: 2px 2px 2px 2px;
            margin-top: 4px;
            margin-right: 5px;
        }
        .tabmenulist a{
            float: left;
            padding-top: 5px;
            padding-left: 5px;
        }

    </style>
</head>
<body>
<div id="container">
    <header class="header">
        <div class="imgcontainer">
            <img src="/assets/img/logo.jpg" class="header_image"/>
        </div>
        <div class="header_text">
            <h2 class="loginidname"></h2>
            <span class="helloword">님 어서오세요</span>
        </div>
        <div class="header_login">
            <div class="login-form">
                <div class="login-form-input">
                    <input type="text" name="memberId" id="idtext" class="text-field" placeholder="아이디">
                    <input type="password" name="memberPw" id="pwtext" class="text-field" placeholder="비밀번호">
                    <a class="authjoin" href="javascript:void(0)" >회원가입</a>
                </div>
                <div class="login-form-submit">
                    <input type="button" value="로그인" class="submit-btn">
                </div>

            </div>
            <a href="javascript:void(0)" class="logout" id="logoutbtn">로그아웃</a>
        </div>
    </header>

    <div class="gnb">
        <ul class="sidebar_menu">
            <li><a href="javascript:void(0)" id="menu1">menu1</a></li>
            <li><a href="javascript:void(0)" id="menu2">menu2</a></li>
            <li><a href="javascript:void(0)" id="menu3">menu3</a></li>
        </ul>

    </div>
    <div class="main">
        <div class="tab_bar">
            <ul id="tabmenu">

            </ul>
        </div>
        <div id="main_content">
            <div id="content">

            </div>
        </div>
    </div>

</div>
</body>

<script src='/js/jquery-3.6.0.min.js?ver=1'></script>
<script src='/assets/lib/yoon/common.js'></script>
<script src='/assets/lib/yoon/createtab.js'></script>

<script>

    let initialize = function () {
        let container = document.querySelector('div#container')

        let menu1 =container.querySelector('a#menu1');
        let menu2 =container.querySelector('a#menu2');
        let menu3 =container.querySelector('a#menu3');

        let tabmenu =container.querySelector('ul#tabmenu');
        let content = container.querySelector('div#main_content');

        let $globalStorage = $commons.storage.g_variable;
        let $random = $commons.util;
        let $common = _commons().history;


        let idtext = container.querySelector('#idtext');
        let pwtext = container.querySelector('#pwtext');

        let logout = container.querySelector('#logoutbtn');



        $globalStorage.setValue("menu1","");
        $globalStorage.setValue("menu2","");
        $globalStorage.setValue("menu3","");

        if($globalStorage.getValue("loginUser")){
            $('.loginidname').text($globalStorage.getValue("loginUser"));
            $('.login-form').css("display", "none");
            $('.helloword').css("display","inline-block");
            $('.logout').css("display","inline-block");
        }

        $('.authjoin').click(function(){
            window.open('auth/authjoin.do', 'windowPop', 'width=400, height=600, left=400, top=400, resizable = yes')

        });


        logout.onclick = function(){
            $globalStorage.setValue("loginUser","");
            location.reload();
        }

        $('.submit-btn').click( async function (){
                let id =idtext.value;
                let pw =pwtext.value;

                let result = await fetch('/join/authlogin.do',{
                    method:'POST',
                    headers: {
                        'content-type' : 'application/json'
                    },
                    body: JSON.stringify({
                        memberId : id,
                        memberPw: pw
                    })
                }).then(res => res.json());

                if(result){
                    $globalStorage.setValue("loginUser",id);
                    location.reload();
                }else{
                    alert('아이디와 비밀번호를 다시 확인해주세요');
                }
        });


        function creatTemplate(menuname) {
            //이름 변경
            let url;
            let name;
            switch (menuname) {
                case 'menu1':
                    name = "메뉴1"
                    url = 'menu/menu1.do'
                    $globalStorage.setValue('menu1', 'open');
                    break;
                case 'menu2':
                    name = "메뉴2"
                    url = 'menu/menu2.do'
                    $globalStorage.setValue('menu2', 'open');
                    break;
                case 'menu3':
                    name = "메뉴3"
                    url = 'menu/menu3.do'
                    $globalStorage.setValue('menu3', 'open');
                    break;
            }


            // 템플릿 만드는 곳
            let node = document.createElement('li');
            node.classList.add(menuname);

            let tabname = menuname + 'tab';
            let tabclosename = menuname + 'close';
            let id = $random.random();

            const template = `<span class="tabmenulist" id="\${id}">
                <a href="javascript:void(0);"  id="\${tabname}"}">\${name}</a>
                <input type="button" id="\${tabclosename}" value="닫기"}"></input>
                <span>`

            node.innerHTML = template;

            node.querySelector('a').onclick = function(){

                let oldElement = document.querySelector('div#content');
                content.replaceChild(history[url].content, oldElement);
                setActivate(url,id);

                $('.tabmenulist').removeClass('tab-menu-click')
                $('#'+ _historyTab.id).addClass('tab-menu-click');

            }
            node.querySelector('input[type=button]').onclick = function(){

                let close = document.querySelectorAll(("." + menuname));
                close.forEach(function (close) {
                    close.remove();
                });

                $globalStorage.setValue(menuname, 'close');
                let indexkey = index(url);
                console.log(indexkey)


                if (_historyTab.activate == url) {

                    if (indexkey.key.length == 1) {

                        let oldElement = document.querySelector('div#content');
                        oldElement.remove();
                        //

                        delete history[url];

                    } else {

                        console.log('activate')
                        let oldElement = document.querySelector('div#content');
                        let siburl = indexkey.siblingid;

                        if (indexkey.index == 0) {
                            let next = indexkey.nextId
                            siburl = indexkey.key[next];
                        }

                        console.log(siburl);
                        content.replaceChild(history[siburl].content, oldElement);
                        setActivate(siburl,history[siburl].id);

                        $('.tabmenulist').removeClass('tab-menu-click');
                        $('#'+ _historyTab.id).addClass('tab-menu-click');
                        delete history[url];
                    }
                } else {
                    delete history[url];
                    $('.tabmenulist').removeClass('tab-menu-click');
                    $('#'+ _historyTab.id).addClass('tab-menu-click');

                }
            }
            tabmenu.appendChild(node);

            //$('#tabmenu').append(template);
            //메뉴 생성시 해당 카운트 새야함. -> globalvariable
            //지금 마지막으로 열려있는곳 activate
            setActivate(url,id);


            $('#main_content').load(url, function () { //~~에 로드한다. 즉 해당 url의 값을 산하에 두겠다는 의미
                //히스토리 저장하기
                let newContent = document.querySelector('#content');
                setHistory(url, newContent, id);
                // active기준 css

                $('.tabmenulist').removeClass('tab-menu-click');
                $('#'+ _historyTab.id).addClass('tab-menu-click');
                // $(node).firstElementChild().addClass('tab-menu-click');
            });

        }

        let _historyTab = {
            activate: undefined,
            tabs: {},
            id: ''
        }

        function setActivate(url,id) {
            _historyTab.activate = url;
            _historyTab.id = id
        }

        function index(url) {
            let key = Object.keys(history); // 순서가 들어감.

            let index = key.indexOf(url); // 해당 url주소의 인덱스 넘버.

            console.log(key);
            console.log(index);

            let prev = index - 1;
            let next = index + 1;

            if (prev == -1) {
                prev = 0;
            }
            if (next == key.length) {
                next = key.length - 1;
            }

            return {
                key: key,
                index: index,
                prevId: prev,
                nextId: next,
                siblingid: key[prev] ? key[prev] : key[next]
            }
        }

        let history = {};

        function setHistory(url, newContent, id) {
            let content = newContent;
            history[url] = {
                expires: new Date().getTime(),
                content: content,
                id: id
            }
        }

        function openCheck(name) {
            let temp = $globalStorage.getValue(name);
            let check = (temp == 'open') ? true : false;
            return check;
        }


        menu1.onclick = function () {
            if (openCheck('menu1')) {
                return;
            } else {
                creatTemplate('menu1');
            }

        }
        menu2.onclick = function () {
            if (openCheck('menu2')) {
                return;
            } else {
                creatTemplate('menu2');
            }
        }
        menu3.onclick = function () {
            if (openCheck('menu3')) {
                return;
            } else {
                creatTemplate('menu3');
            }
        }


    }


    $(function () {
        initialize();
    })

</script>
</html>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="kr">
<head>

    <title>tab 테스트</title
    <meta charset="UTF-8"/>
    <meta name="format-detection" content="telephone=no"/>
    <%--    <meta name="viewport" content="width=device=width, initial-scale=1"/>--%>

    <%@ include file="../_stylesheet.jsp" %>

    <style>
        #container {
            text-align: center;
        }

        .menuselect a {
            text-align: center;
            margin-left: 10px;
            border: 1px solid;

        }

        .menuselect a:hover {
            text-decoration: underline;
        }

        .tabtitle {
            text-align: center;
        }

        .tabmenudiv {
            margin-top: 50px;
        }

        #tabmenu {
            text-align: center;

        }

        #tabmenu li {
            display: inline-block;
            margin-left: 10px;

        }
    </style>
</head>
<body>

<div id="container">
    <div class="tabtitle">
        <h2>메뉴</h2>
    </div>

    <div class="menuselect">
        <a href='javascript:void(0)' id="menu1">메뉴1번</a>
        <a href='javascript:void(0)' id="menu2">메뉴2번</a>
        <a href="javascript:void(0)" id="menu3">메뉴3번</a>
        <a href='javascript:void(0)' id="load">히스토리 로드</a>
    </div>

    <div class="tabmenudiv">
        <ul id="tabmenu">

        </ul>
    </div>
    <div id="tabcontent">
        <div id="content">

        </div>
    </div>
</div>


<script>

</script>
<script src='/js/jquery-3.6.0.min.js?ver=1'></script>
<script src='/assets/lib/yoon/common.js'></script>
<script src='/assets/lib/yoon/createtab.js'></script>


<script type="text/javascript">


    let initialize = function () {

        let $createTab = $createtab;

        let $globalStorage = $commons.storage.g_variable;
        let $random = $commons.util;

        let menu1 = document.querySelector('a#menu1');
        let menu2 = document.querySelector('a#menu2');
        let menu3 = document.querySelector('a#menu3');
        let back = document.querySelector('a#load');

        let tabmenu = document.querySelector('ul#tabmenu');
        let content = document.querySelector('div#tabcontent');
        let oldElement = document.querySelector('div#content');


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

            const template = `<span>
                <a href="javascript:void(0);" id="\${tabname}"}">\${name}</a>
                <button id="\${tabclosename}"}">닫기</button>
                <span>`

            node.innerHTML = template;
            tabmenu.appendChild(node);

            //$('#tabmenu').append(template);
            //메뉴 생성시 해당 카운트 새야함. -> globalvariable
            //지금 마지막으로 열려있는곳 activate
            setActivate(url);


            $('#tabcontent').load(url, function () { //~~에 로드한다. 즉 해당 url의 값을 산하에 두겠다는 의미
                //히스토리 저장하기
                let newContent = document.querySelector('#content');
                let id = $random.random();
                setHistory(url, newContent, id)

            });

            //template click listener

            $("#" + tabclosename).click(function () {

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

                    }else{

                    console.log('activate')
                    let oldElement = document.querySelector('div#content');
                    let siburl = indexkey.siblingid;

                        if(indexkey.index ==0){
                            let next = indexkey.nextId
                            siburl = indexkey.key[next];
                        }

                    console.log(siburl);
                    content.replaceChild(history[siburl].content, oldElement);
                    setActivate(siburl);

                    delete history[url];
                    }
                } else {
                    delete history[url];
                }


            });

            $(document).on("click", "#" + tabname, function () {
                //replaceChild 와야함
                let oldElement = document.querySelector('div#content');
                content.replaceChild(history[url].content, oldElement);
                setActivate(url);

            });


        }

        let _historyTab = {
            activate: undefined,
            tabs: {}
        }

        function setActivate(url) {
            _historyTab.activate = url;
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
</body>
</html>
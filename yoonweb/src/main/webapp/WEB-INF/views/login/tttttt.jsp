<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="kr">
<head>

    <title>tab 테스트</title>
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

        .tabmenu {
            text-align: center;
        }

        .tabmenu li {
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
        <ul class="tabmenu">

        </ul>
    </div>
    <div class="tabcontent">
        <div class="content">

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

        let menu1 = document.querySelector('a#menu1');
        let menu2 = document.querySelector('a#menu2');
        let menu3 = document.querySelector('a#menu3');


        let tabmenu = document.querySelector('ul#tabmenu');
        let content = document.querySelector('div#tabcontent');
        let oldElement = document.querySelector('div#content');



        function openCheck(name) {
            let temp = $globalStorage.getValue(name);
            let check = (temp == 'open') ? true : false;
            return check;
        }


        menu1.onclick = function () {
            if (openCheck('menu1')) {
                return;
            } else {
                $createTab.add({
                    type: 'TAB',
                    target: 'menu/menu1.do',
                    title: '메뉴1',
                    name: 'menu1',
                    parent: location.href

                })
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
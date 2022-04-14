<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="kr">
<head>

    <title>다운로드 테스트</title>

    <meta charset="UTF-8"/>
    <meta name="format-detection" content="telephone=no"/>
<%--    <meta name="viewport" content="width=device=width, initial-scale=1"/>--%>

    <%@ include file="../_stylesheet.jsp"%>

</head>

<body>
<div id="wrap">
    <div class="layout-wrap">
        <div class="fix-top-wrap">
            <header class="header">
                <h1 class="header__logo">
                    <a href="" class="header__logo-link">
                        <span class="for-ally">test</span>
                    </a>
                </h1>
            </header>
<%--            위 공간--%>
        </div>

        <nav class="gnb">
            <h2 class="for-ally">글로벌 네비게이션 바</h2>
<%--            메인메뉴--%>
            <div class="gnb__scroller ui-scroller">
                <ul class="gnb__list"></ul>
            </div>
<%--            서브메뉴--%>
            <div class="gnb-depth">
                <div class="gnb-depth__scroller ui-scroller"></div>
            </div>
        </nav>
                <%--   왼쪽 사이드 메뉴--%>


        <div class="contents-wrap">
            <%--    히스토리--%>
            <nav class="history-tab">
<%--                위에 탭부분 히스토리 분리--%>
                <h2 class="for-ally">history tab</h2>
                    <div class="history-tab__scroller">
                        <ul class="history-tab__list">
                            <input type="button" class="button" id="_test" />

                        </ul>
                    </div>


            </nav>

            <div class="content"></div>
<%--            아래 바뀌는 document 의 정체--%>

        </div>
    </div>
</div>

<div class="layer-wrap" data-layer="layer=name">
    <div class="layer-container">

    </div>
</div>

<script src='/js/jquery-3.6.0.min.js?ver=1'/>
<script src='/assets/lib/yoon/common.js?ver=1'/>
<script src='/assets/lib/tab/tab-ui.js?ver=1'></script>

<script>

    function _navigatorActive(menuID){ // 글로벌 네비게이션 바에 있는 메뉴를 넣어준다
        let navItems = document.querySelectorAll('ui.gnb__list>li');
        for(let i = 0; i< navItems.length; i++){
            navItems[i].classList.remove('is-active');
        }
        let target = document.querySelector('ul.gnb__list>li[data-val=\${menuID}]');
        if(target){
            target.classList.add('is-active');
        }
    }

    function _tabActive(menuID){
        document.querySelector('a[link-id=\${menuID}]').click();
    }

</script>


<script type="text/javascript">

    let $tabManager;

    $tabManager = $testTabManager();

    let initialize = function () {



/*
        let api = _api();

        api.getMenuList().then(function (data){
            createSlidMenu(data.output[0]); /// 여기서부터 해야함.

            createHeaderMenu(); // 위의 메뉴
        });

        createSlidMenu();

        async function createSlidMenu(data){
            const TEMP_MENU = {
                "메뉴 1번": {class: 'gnb__item--1', menuId: 'M0000000_DM1',index:1},
                "메뉴 2번": {class: 'gnb__item--1', menuId: 'M0000001',index:2}
            }
            const LINK_IGNORE = 'javascipt:void(0);';

            let response = await fetch('./assets/lib/menu/yoonweb-menu.json');
            let menuData = await response.json(); // data-> response.output[0]
            let tabContainer = document.querySelector('.history-tab__list')
            let navContainer = document.querySelector('.gnb__list');

            let element = $commons.ui.element;

            for(let menuText in TEMP_MENU){
                let menuId = TEMP_MENU[menuText].menuId;
                let menuIndex = TEMP_MENU[menuText].index;

                let menuUrl = menuData[menuId] ? menuData[menuId].url : '';
                let item;

                if(menuIndex ===1){ //기본적으로 세팅해주는 페이지
                    //history 부분
                    let HOME_ITEM_TEMPLETE =
                        `<li class="history-tab-item history-tab__item--home" data-val="\${menuId}">
                            <div class="history-tab__block">
                                <a href="\${mainUrl}" class = "history-tab__link" link-id="\${menuId}">
                                    <span class = "for-ally">\${menuText}</span>
                                </a>
                            </div>
                        </li>`;
                    item = element.create(HOME_ITEM_TEMPLETE,true);
                    tabContainer.appendChild(item);
                }else{
                    let MENU_ITEM_TEMPLETE =
                        `<li class="gnb__item \${menuClass}" data-gnb="\${menuText}" data-val="\${menuId}">
                                <a href="\${mainUrl}" class = "gnb__link" link-id="\${menuId}">\${menuText}</a>
                        </li>`;

                    item= element.create(MENU_ITEM_TEMPLETE,true);
                    navContainer.appendChild(item);
                }
                item.querySelector('a').onclick=function (menuId){
                    let url = this.href;
                    let title = this.innerText;
                    let linkId = this.getAttribute('link-id');

                    if(isValidUrl(url)) {
                        $tabManager.add({
                            title: title,
                            type: 'TAB',
                            id: linkId,
                            navId: menuId,
                            parent: location.href,
                            target: url
                        })
                        _navigatorActive(menuId);
                    }
                    return false ;
                }.bind(item.querySelector('a'),menuId);


                if(menuData[menuId]){
                    let MENU_SECTION_TEMPLETE =
                        `<section class="gnb-depth__section" data-gnb-contents="\${menuText}"}>
                            <h3 class="gnb-depth_title \${'gnb-depth__title--' + menuIndex}">\${menuText}</h3>
                            <ul class="gnb-depth__list"></ul>
                         </section>
                        `;
                    let menuDepth = element.create(MENU_SECTION_TEMPLETE, true);

                    if(menuDatap[menuId].child && Object.keys(menuData[menuId].child).length !=0){
                        let mainList = menuData[menuId].child;

                        for(let mainId in mainList){
                            let mainItemUrl = mainList[mainId].url;

                            let MENU_DEPTH_ITEM_TEMPLATE =
                                `
                                <li class="gnb-depth__item">
                                    <div class="gnb-depth__head">
                                        <a href="\${mainItemUrl}" class="gnb-depth__link" link-id="\${mainId}">\${mainItemText}</a>
                                        <button class="ui-button gnb-depth__opener"></button>
                                    </div>
                                </li>
                                `;

                            let mainItemDepth = element.create(MENU_DEPTH_ITEM_TEMPLATE,true)
                            mainItemDepth.querySelector('a.gnb-depth__link').onclick = function(menuId){
                                let url = this.href;
                                let title = this.title;
                                let linkId = this.link //여기까지함.
                            }

                        }
                    }
                }

            }

            function isValidUrl(url){
                url = url.replace(location.href, '');
                return(url && url.length !==0 && url !==location.href && url !== 'javascript:void(0)');
            }

        }


        function _api(){
            let commonData = $commons.data.serialize({
                parameters: {},
                datasets: {}
            });

            return{

                getMenuList: function (data = commonData){
                    let URI = '/sys/getMenuTreeByUserAuth.do'// do나 view나 같음 do 는 예전 스타일 느낌

                    return $fetch.request({
                        url: URI,
                        method: 'POST',
                        headers: {'Content-Type': 'application/json'},
                        data: data
                    })
                }
            }
        }

*/


        const container = document.querySelector('.page-contents-test');
        let addButton = document.getElementById('_test');




            addButton.onclick = function () {
                console.log('버튼');
                let filename = "test"
                let userFile = "테스트.txt"
                fileDown(filename, userFile);
            }


        function fileDown(_filename, _userFile) {
                console.log('test')
            let url = "/jsp/download.jsp?file=" + _filename + "&userfile=" + encodeURI(_userFile) + "&fileType=test";
            console.log(url);
            $commons.ui.download(url)
        }


    }

    $(function () {
        initialize();
    });

</script>
</body>
</html>
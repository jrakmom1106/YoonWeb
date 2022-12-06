<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="kr">
<head>

    <title>ajax 테스트</title>

    <meta charset="UTF-8"/>
    <meta name="format-detection" content="telephone=no"/>
    <%--    <meta name="viewport" content="width=device=width, initial-scale=1"/>--%>

    <%@ include file="../_stylesheet.jsp" %>

    <style>
        #container {
            text-align: center;
        }
    </style>
</head>
<body>
<button id="testbtn" type="button">pop</button>
<button id="testbtn2" type="button">method: POST</button>
<button id="testbtn3" type="button">method: PUT</button>
<button id="testbtn4" type="button">method: DELETE</button>
<input type="text" value="" id="text"/>
<select id="select">
    <option value="10">10대</option>
    <option value="20">20대</option>
</select>
<button id="ajaxbtn" type="button">ajax통신</button>

<div id="container">
    <button id="tab1">1</button>
    <button id="tab2">2</button>
    <nav class="history-tab">
        <h2 class="for-ally">History tab</h2>
        <ul class="history-tab__list">

        </ul>
    </nav>
    <div id="content">
        <ul id="testid">

        </ul>
    </div>
    <div id="idtest">
        <input type="text" id="id"/>
        <button id="idbtn">아이디 넣기</button>
    </div>
    <div>
        <button id="popuptestbtn">팝업</button>
    </div>
    <button id="windowhistory">히스토리 저장 현황</button>
    <div id="menuselect">
        <a href='javascript:void(0)' id="menu1">메뉴1번</a>
        <a href='javascript:void(0)' id="menu2">메뉴2번</a>
        <a href="javascript:void(0)" id="menu3">메뉴3번</a>
        <a href='javascript:void(0)' id="load">히스토리 로드</a>
    </div>
    <div id="tabstate">
        <ul id="tabhistory"></ul>
    </div>
    <div id="menucontent">
        <div id="insidecontent">
            <div id="contentwrap">
            <h2>contents</h2>
            </div>
        </div>
    </div>

</div>


<script>
    /*let $windowPopupManager;
    $windowPopupManager = $yoonWindowPopupManager();

    function $openPopup(url, options) {
        if ($windowPopupManager && url != undefined && url !== '') {
            return $windowPopupManager.open(url, options);
        }
    }*/

</script>
<script src='/js/jquery-3.6.0.min.js?ver=1'></script>
<script src='/assets/lib/yoon/common.js'></script>
<%--<script src='/WEB-INF/views/_layout.jsp'></script>--%>
<%--<script src='/assets/lib/tab/tab-ui.js?ver=1'></script>--%>


<script type="text/javascript">


    let initialize = function () {

        let historybtn = document.querySelector('button#windowhistory');


        let $globalVariable = $commons.storage.g_variable;
        let history = {};

        let menu1 = document.querySelector('a#menu1');
        let menu2 = document.querySelector('a#menu2');
        let menu3 = document.querySelector('a#menu3');

        let tabnode = document.querySelector('ul#tabhistory')
        const tabindex = $globalVariable.getValue('tabindex');

        //let contentElement = $ui.element.create('');
        let contentview = document.querySelector('div#menucontent');
        let loadbtn = document.querySelector('a#load');


        function Stack(max_size){
            const size = max_size;
            let top =0;
            let array = [];
            return{
                pop(){
                    if(top ==0){
                        //스택이 빔
                    }else {
                        let temp = array[top];
                        top --;
                        return temp;
                    }
                },
                push(item){
                    if(size>top){
                        top++;
                        return array[top] = item;
                    }else{
                        //스택꽉참
                    }
                },
                peek(){
                    return array[top];
                },
                back(){
                    //let temp = array[top]
                    top--;
                    return array[top]
                },
                option(){
                    return array[top-1]
                }
            }
        }
        let stack = Stack(100);


        loadbtn.onclick = function () {
            let oldElement = contentview.querySelector('#insidecontent');
            if(stack.option() == undefined){
                alert('더이상없음')
                return;
            }
            contentview.replaceChild(history[stack.back()].content,oldElement);
        }


        historybtn.onclick = function () {
            // window.history.back();
            // let countindex = $('#tabhistory').children('li').length
            // console.log(countindex);
            //
            console.log(history);
            console.log(stack.peek());
            console.log(stack.pop());
           // console.log(history[url].content)
        }


        function menu1opener(){
            let url = 'menu/menu1.do'
             $('#menucontent').load(url,function(){
                let content = contentview.querySelector('#insidecontent');
                setHistory(url,content);
                stack.push(url);
            })
        }

        function menu2opener(){
            let url = 'menu/menu2.do'
             $('#menucontent').load(url,function(){
                let content = contentview.querySelector('#insidecontent');
                setHistory(url,content);
                stack.push(url);
            });
        }
        function menu3opener(){
            let url = 'menu/menu3.do'
            $('#menucontent').load(url,function(){
                let content = contentview.querySelector('#insidecontent');
                setHistory(url,content);
                stack.push(url);
            })
        }


        menu1.onclick =  async function () {
            menu1opener();
            checktab('menu1');

        }

        menu2.onclick =  async function () {
            menu2opener();
            checktab('menu2');

        }

        menu3.onclick = async function(){
            menu3opener();
            checktab('menu3');
        }

        function checktab(tabname){
            let temp;
            switch (tabname){
                case 'menu1' : temp = 'tab1'
                break;
                case 'menu2' : temp = 'tab2'
                break;
                case 'menu3' : temp = 'tab3'
                break;
            }

            const tabindex = $globalVariable.getValue(temp);

            if(tabindex =='close' || tabindex == null){
                $globalVariable.setValue(temp,'open');
                createTemplate(tabname);
            }

        }

        // function createMenubar(tabname){
        //     let createnode = document.createElement('li');
        //     createnode.classList.add(tabname);
        //     let template = `<span><a href="javascript:void(0);" id=>menu1</a>
        //             <button id='closetabbtn'>닫기</button>
        //             <span>`
        //
        // }


        let tablist ={};
        function createTabMenu(index,url,tabContent){
            let content = tabContent;
            tablist[index]= {
                expires: new Date().getTime(),
                url: url,
                content: content
            }

            return tablist;


        }

        class Node {
            constructor(data, next = null) {
                //data와 next를 넣고 next의 디폴트는 null로 지정 왜냐하면 linkedlist의 tail(마지막은) null로 끝나기때문
                this.data = data;
                this.next = next;
            }
        }

        class LinkedList {
            constructor() {
                this.head = null; //처음에 데이터가 없다면 head는 null이다.
                this.size = 0; //리스트의 크기를 찾기위해 사용 디폴트는 0으로 지정.
            }

            // Insert first node - 첫번째 삽입
            insertFirst(data) {
                this.head = new Node(data, this.head) //head에 새로운 node가 들어가고 기존의 해드는 next로 밀려난다.
                this.size++;
            }

            // Insert last node - 마지막 삽입
            insertLast(data) {
                let node = new Node(data);
                let current;

                // if empty, make head
                if (!this.head) {
                    this.head = node;
                } else {
                    current = this.head;

                    while (current.next) { //this.head에 next가 있다면 즉, next가 null이아니라면
                        current = current.next; // current는 current.next가 되고
                    }

                    current.next = node; //결국 current.next가 새로넣은 node가 된다?
                }
                this.size++; //length 는 1증가
            }

            // Insert at index - 중간 삽입
            insertAt(data, index) {
                tabcount++;
                // If index is out of range ~ 인덱스가 size 범위 넘어서면 아무것도 리턴 하지 않는다.
                if (index > 0 && index > this.size) {
                    return;
                }

                // If first index
                if (index === 0) {
                    this.head = new Node(data, this.head) //즉, index 0에 삽입시 해당 노드를 넣고 다 한칸식 뒤로 미룸
                    this.size++
                    return;

                }

                const node = new Node(data);
                let current, previous;

                // Set current first
                current = this.head;
                let count = 0;

                while (count < index) {
                    previous = current; //node before index
                    count++;
                    current = current.next; //node after index
                }

                node.next = current;
                previous.next = node;

                this.size++;
            }

            // Get at index
            getAt(index) {
                let current = this.head;
                let count = 0;

                while (current) {
                    //해당 data의 값을 가져오기 위해 index와 값이 같아질때까지 loop한다.
                    if (count == index) {
                        console.log(current.data);
                    }
                    count++;
                    current = current.next;
                }
                return null;
            }

            // Remove at index
            removeAt(index) {
                if (index > 0 && index > this.size) {
                    return;
                }

                let current = this.head; //current는 현재 첫번째 노드임
                let previous;
                let count = 0;

                // Remove first
                if (index === 0) {
                    this.head = current.next;
                } else {
                    //loop를 통해 해당 index의 연결고리를 끊는다.
                    while (count < index) {
                        count++;
                        previous = current;
                        current = current.next;
                    }
                    previous.next = current.next;
                }

                this.size--;
            }

            // Clear list ~ 메모리자체에는 데이터가 남아있겠지만 보여주기 위해서 func 만들었다.
            clearList() {
                this.head = null;
                this.size = 0;
            }
            // Print list data ~ data값만 따로
            printListData() {
                let current = this.head; // 현재 노드를 나타냄

                while (current) {
                    console.log(current.data);
                    current = current.next;
                }
            }
        }

        const linkedList = new LinkedList();


        let tabcount = 0;

        function createTemplate(tabname){
            let createnode = document.createElement('li');

            switch (tabname){
                case 'menu1':
                     let url1 = 'menu/' + tabname + '.do';
                     let count = tabcount;
                    tabcount++;
                    createnode.classList.add(tabname);
                    let template1 = `<span><a href="javascript:void(0);" id="menu1opener">menu1</a>
                    <button id='closetabbtn'>닫기</button>
                    <span>`
                    createnode.innerHTML = template1;
                    tabnode.appendChild(createnode);

                    let oldElement = contentview.querySelector('#insidecontent');
                    let content = createTabMenu(count,url1,oldElement)

                    if(count == 0){
                        linkedList.insertFirst(content)
                    }else{

                    linkedList.insertAt(content,count)
                    }

                    $('#menu1opener').click(function (){
                        let oldElement = contentview.querySelector('#insidecontent');

                        contentview.replaceChild(history[url1].content,oldElement);
                    });

                    let closebtn = document.querySelector('button#closetabbtn')
                    closebtn.onclick = function () {
                        let oldElement = contentview.querySelector('#insidecontent');

                        const close = document.querySelectorAll('.menu1')
                        close.forEach(function (close) {
                            close.remove();
                        })  // 유용하네.
                        $('.menu1content').empty();
                        $globalVariable.setValue('tab1', 'close');

                        //content 제거
                        if(count ==0){

                          //  linkedList.removeAt(count);
                            let first = linkedList.head.data[count].content
                            contentview.replaceChild(first,oldElement);

                        }else{
                            contentview.replaceChild(tablist[count].content,oldElement);
                        }


                    }
                break;
                case 'menu2':
                    let url2 = 'menu/' + tabname + '.do';
                    createnode.classList.add(tabname);
                    let template2 = `<span><a href="javascript:void(0);" id="menu2opener">menu2</a>
                    <button id='closetab2btn'>닫기</button>
                    <span>`
                    createnode.innerHTML = template2;
                    tabnode.appendChild(createnode);

                    let count2 = tabcount;
                    tabcount++;
                    let oldElement2 = contentview.querySelector('#insidecontent');
                    let content2 = createTabMenu(count2,url2,oldElement2)

                    if(count2 == 0){
                        linkedList.insertFirst(content2)
                    }else{

                        linkedList.insertAt(content2,count2)
                    }

                    $('#menu2opener').click(function (){
                        let oldElement = contentview.querySelector('#insidecontent');

                        contentview.replaceChild(history[url2].content,oldElement);
                    });

                    let closebtn2 = document.querySelector('button#closetab2btn');
                    closebtn2.onclick = function () {
                        let oldElement = contentview.querySelector('#insidecontent');
                        const close = document.querySelectorAll('.menu2')
                        close.forEach(function (close) {
                            close.remove();
                        })
                        $('.menu2content').empty();
                        $globalVariable.setValue('tab2', 'close');

                        if(count2 ==0){
                            debugger;
                            //  linkedList.removeAt(count);
                            let first = linkedList.head.data[count2].content
                            contentview.replaceChild(first,oldElement);

                        }else{
                            contentview.replaceChild(tablist[count2].content,oldElement);
                        }
                    }
                break;
                case 'menu3':
                    let url3 = 'menu/' + tabname + '.do';
                    createnode.classList.add(tabname);
                    let template3 = `<span><a href="javascript:void(0);" id="menu3opener">menu3</a>
                    <button id='closetab3btn'>닫기</button>
                    <span>`
                    createnode.innerHTML = template3;
                    tabnode.appendChild(createnode);

                    let count3 = tabcount;
                    tabcount++;
                    let oldElement3 = contentview.querySelector('#insidecontent');
                    let content3 = createTabMenu(count3,url3,oldElement3)

                    if(count3 == 0){
                        linkedList.insertFirst(content3)
                    }else{

                        linkedList.insertAt(content3,count3)
                    }

                    $('#menu3opener').click(function (){
                        let oldElement = contentview.querySelector('#insidecontent');

                        contentview.replaceChild(history[url3].content,oldElement);
                    });

                    let closebtn3 = document.querySelector('button#closetab3btn');
                    closebtn3.onclick = function () {
                        let oldElement = contentview.querySelector('#insidecontent');
                        const close = document.querySelectorAll('.menu3')
                        close.forEach(function (close) {
                            close.remove();
                        })
                        $('.menu3content').empty();
                        $globalVariable.setValue('tab3', 'close');

                        if(count3 ==0){
                            debugger;
                            //  linkedList.removeAt(count);
                            let first = linkedList.head.data[count3].content
                            contentview.replaceChild(first,oldElement);

                        }else{
                            contentview.replaceChild(tablist[count3].content,oldElement);
                        }

                    }
                    break;

            }

        }




        function load(url, isForce) {
            setHistory()
        }


        function setHistory(url, newContent) {

            let content = newContent;
            history[url] = {
                expires: new Date().getTime(),
                content: content
            }

        }


        let popuptestbtn = document.querySelector('button#popuptestbtn');

        popuptestbtn.onclick = function () {
            let popOption = "width = 650px, height=550px, top=300px, left=300px, scrollbars=yes";
            let openUrl = '/test/popup.do'
            window.open(openUrl, 'pop', popOption);
        }


        /*
                const _PATH = 'assets/lib/yoon'
                const _LEGACY_GLOBAL_VARIABLE = load(_PATH, 'yoon-legacy-global-variable.json');
                function load(path,filename){
                    let filePath = path + '/' + filename;
                    const key = filename.replace('.json','');
                    debugger;

                    let data;
                    let storage = window.localStorage;

                    if(storage && storage.getItem(key)){
                        data = storage.getItem(key);
                    }else{
                        let xhr = new XMLHttpRequest();
                        xhr.open('GET',filePath,false);

                        xhr.send();

                        if(xhr.status == 200){
                            data = xhr.responseText;
                            storage.setItem(key,xhr.responseText);
                        }
                    }
                    return JSON.parse(data);
                }*/


        let url = "/assets/lib/ajax/test.json"
        let httpRequest;

        /*document.getElementById("testbtn").addEventListener('click', makeRequest);

         function makeRequest() {
             httpRequest = new XMLHttpRequest();

             if(!httpRequest) {
                 alert('XMLHTTP 인스턴스를 만들 수가 없어요 ㅠㅠ');
                 return false;
             }
             httpRequest.onreadystatechange = alertContents;
             httpRequest.open('GET', url);
             httpRequest.send();
         }

         function alertContents() {
             try {
                 if (httpRequest.readyState === XMLHttpRequest.DONE) {
                     if (httpRequest.status === 200) {
                         var xmldoc = httpRequest.responseXML;
                         var root_node = xmldoc.getElementsByTagName('root').item(0);
                         alert(root_node.firstChild.data);
                     } else {
                         alert('There was a problem with the request.');
                     }
                 }
             }
             catch( e ) {
                 alert('Caught Exception: ' + e.description);
             }
         }
 */

        let testbtn = document.querySelector('button#testbtn');
        let testbtn2 = document.querySelector('button#testbtn2');
        let testbtn3 = document.querySelector('button#testbtn3');
        let testbtn4 = document.querySelector('button#testbtn4');

        let ajaxbtn = document.querySelector('button#ajaxbtn');

        let text = document.querySelector('input#text');
        let select = document.querySelector('select#select');


        let tab1 = document.querySelector('button#tab1');
        let tab2 = document.querySelector('button#tab2');


        let tabContainer = document.querySelector('.history-tab__list')
        text.value = "";
        select.value = '10';


        function acyncMovePage(url) {

            // ajax option

            var ajaxOption = {

                url: url,

                async: true,

                type: "POST",

                dataType: "html",

                cache: false

            };


            $.ajax(ajaxOption).done(function (data) {

                // Contents 영역 삭제

                $('#bodyContents').children().remove();

                // Contents 영역 교체

                $('#bodyContents').html(data);

            });

        }

        let idtext = document.querySelector('input#id');
        let idbtn = document.querySelector('button#idbtn');


        idbtn.onclick = function () {

            let submitid = idtext.value;
            $globalVariable.setValue('G_USER_NM', submitid);
            const G_USER_NM = $globalVariable.getValue('G_USER_NM');
            alert(G_USER_NM);

        }


        let nodetest = document.querySelector('div#content');

        tab1.onclick = function () {
            debugger;
            let createnode = document.createElement('div');
            const template = `<div>testli</div>`

            createnode.innerHTML = template;

            nodetest.appendChild(createnode);

        }

        tab2.onclick = function () { //controller 통해서...
            debugger;
            $('#content').load('/test/tab2.do #tabcontent', function (response) {
                response ? alert('clear') : alert('fail');
                console.log(response)
            });
        }


        function createNavItem(options) {
            options = options ? options : {};
            options.type = options.type ? options.type : 'common';
            options.text = options.text ? options.text : '';
            options.url = options.url ? options.url : 'javascript:void(0)';

            const TEMPLATES =
                `<li class="history-tab__item">
                            <div class="history-tab__block">
                            <h2>test22</h2>
                            </div>
                            </li>
                            `


            let item = create(TEMPLATES, true);
            return item;
        }

        function create(htmlString, isTemplate) {
            let nodeName = isTemplate ? 'template' : 'div';
            let template = document.createElement(nodeName);
            template.innerHTML = htmlString;
            if (isTemplate) {
                return template.content.firstElementChild;
            } else {
                return template;
            }

        }


        async function Popup() {
            $openPopup("/login/login.jsp", {pid: "test", width: 1500, height: 1500, data: ""});
            /* let url = "/login/login.jsp";
             let options = {pid: "test",width: 1500, height: 1500, data: ""};
          //   $yoonWindowPopupManager.open(url,options);*/

        }


        testbtn.onclick = function () { //GET
            Popup();
        }

        let data = {username: 'example'};

        testbtn2.onclick = function () {
            fetch("/test/testList.do", {
                method: 'POST',
                headers: {
                    "Content-Type": "application/json",
                },
                body: $commons.data.serialize(data)
            })
                .then(res => res.json())
                .then(response => console.log('Success:', JSON.stringify(response)))

        }

        testbtn3.onclick = function () {
            fetch("/test/testList2.do", {
                method: "PUT",
                headers: {
                    "Content-Type": "application/json",
                },
                body: JSON.stringify(data),
            })
                .then(res => res.json())
                .then(response => console.log('Success:', JSON.stringify(response)))


        }

        testbtn4.onclick = function () {
            fetch(url)
                .then(res => res.json())
                .then(function (res) {

                });

        }


        ajaxbtn.onclick = function () {

            let result = {
                name: text.value,
                age: select.value,
                rule: "",
                auth: ""

            }
            fetch("/test/testList3.do", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                },
                body: JSON.stringify(result)


            })
                .then(res => res.json())
                .then(response => {
                    console.log(response);
                    if (response.auth === "Y") {
                        alert("관리자님 어서오세요")
                    } else if (response.auth === "T") {
                        alert("테스터님 어서오세요")
                    } else {

                        if (response.rule === "N") {
                            alert("10대는 이용이 불가합니다.")
                        } else {
                            alert(response.name + ' 님 어서오세요 나이는' + response.age + '입니다');
                        }
                    }
                })
        }

        // body: $commons.data.serialize(result)
        // dataset을 규격을 주면 그런식으로 받아야 한다.

        async function getfetch() {

            let fetchdata = {
                request: {
                    datasets: {
                        name: "",
                        age: 26
                    }
                }
            }

            let result = await _api().testfunction(fetchdata);

            //api 규격에 맞는 datasets에 각각의 db에 맞는 값을 지정하고 규격에 맞는 출력값을 result.규격이름 으로 사용가능

        }


        function _api() {
            return {
                testfunction: function (data) {

                    let _promise = new Promise((resolve, reject) => {

                        let result = fetch('/test/testList3.do', {
                            headers: {'Content-Type': 'application/json'},
                            method: 'POST',
                            body: JSON.stringify(data)
                            //기본 이외는 커스텀 옵션

                        })
                            .then((response) => {
                                response.json();
                            });

                        let message = 'fetch api error';
                        resolve(result);
                        reject(message);


                    })

                    return _promise;
                }
            }
        }


    }


    $(function () {
        initialize();
    })

</script>
</body>
</html>
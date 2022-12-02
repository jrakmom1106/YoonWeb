<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<html>
<head>
    <style>
        .board {
            width: 100%;

        }
    </style>
</head>
<body>
<div id="content">
    <div id="contentwrap">
        <h2>CRUD</h2>
        <button class="regi">등록</button>
        <select id="selectview">
            <option value="10" selected="selected">10개씩 보기</option>
            <option value="15">15개씩 보기</option>
            <option value="20">20개씩 보기</option>
        </select>
        <select class="searchoption">
            <option value="titlename">제목</option>
            <option value="wirtername">작성자</option>
        </select>
        <input type="text" class="searchtext" value =""/>
        <button class="detailsearch">조회</button>
        <table border="1" class="board">
            <thead>
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>글쓴이</th>
                <th>작성일자</th>
                <th>조회수</th>
            </tr>
            </thead>
            <tbody id="table">
            </tbody>
            <!-- forEach 문은 리스트 객체 타입을 꺼낼때 많이 활용된다. -->
        </table>
        <span id="nav"></span>
    </div>
</div>
</body>
</html>
<script>
    $(document).ready(async function () {

        let regibtn = document.querySelector('.regi');
        let tbody = document.querySelector('#table');
        let viewcnt = document.querySelector('#selectview');
        let nav = document.querySelector('#nav');
        let $common = $commons.history

        let searchoption = document.querySelector('.searchoption');
        let searchtext = document.querySelector('.searchtext');
        let detailsearchbtn = document.querySelector('.detailsearch');




        searchtext.onkeyup = function(e){
            if(e.key === "Enter" || e.keyCode === 13 ){
                detailsearchbtn.click();

            }

        }

        viewcnt.onchange = function(){
            detailsearchbtn.click();
        }




        regibtn.onclick = function () {
            let url = "/regi/loader.do"
            let parentContent = document.querySelector('#contentwrap');
            let id = _commons().util.random();
            $common.sethistory(url,parentContent,id);
            let test = $common.gethistory(url);
            console.log(test);

            $('#content').load(url,function(){

            });

        }


        detailsearchbtn.onclick = function(){
            let wr;
            let ti;

            if(searchoption.value == "titlename" ){
                ti = searchtext.value;
                wr = "";
            }else{
                wr = searchtext.value;
                ti = "";
            }
            createBoard(1,wr,ti);
            createPagenation(wr,ti);
        }

        detailsearchbtn.click();

        async function createPagenation(wr,ti) {
            let cnt;

            while(nav.firstChild){
                nav.removeChild(nav.firstChild);
            }

            await fetch('/board/boardcount.do', {
                method: "POST",
                headers: {
                    'content-type': 'application/json'
                },
                body: JSON.stringify({
                    writer : wr,
                    title : ti
                })
            }).then(res => res.json())
                .then(data => {
                    cnt = data;
                })

            //총 페이지 수
            let totalpagecnt = Math.ceil(cnt / viewcnt.value);
            //페이지 숫자 생성.
            for (let i = 1; i <= totalpagecnt; i++) {
                //html 생성하기.
                let node = document.createElement('a');
                const template = `
                <a class="navclick" href="javascript:void(0)">\${i}</a>
                `
                node.innerHTML = template;

                node.querySelector('a').onclick = function () {
                    createBoard(i,wr,ti);

                }
                nav.appendChild(node);
            }

        }

        //테이블 생성
        async function createBoard(nowpage,wr,ti) {


            while(tbody.firstChild){
                tbody.removeChild(tbody.firstChild);
            }

            await fetch('/board/search.do', {
                method: "POST",
                headers: {
                    'content-type': 'application/json'
                },
                body: JSON.stringify({
                    view: viewcnt.value, // ~만큼 보기
                    pagenum: nowpage, // 페이지 숫자클릭넘버.
                    writer : wr,
                    title : ti
                })
            }).then(res => res.json())
                .then(data => {
                    console.log(data);
                    for (let i = 0; i < data.length; i++) {
                        console.log(data[i].title);

                        let node = document.createElement('tr');
                        const template = `
                                        <th><a href="javascript:void(0)" class="boardlink">\${data[i].NUM}</a></th>
                                        <th>\${data[i].title}</th>
                                        <th>\${data[i].writer}</th>
                                        <th>\${data[i].regdate}</th>
                                        <th>\${data[i].viewcnt}</th>
                                        `
                        node.innerHTML = template;
                        tbody.appendChild(node);

                        let boardlink = document.getElementsByClassName('boardlink');
                        boardlink[i].onclick =function(){
                            selectBoard(data[i].bno);
                        }
                    }

                });


            }

            //테이블 목록 클릭시 함수
            function selectBoard(bno){
                fetch('/board/selectboard.do',{
                    method:"POST",
                    headers: {
                        'content-type': 'application/json'
                    },
                    body :JSON.stringify({
                        bno: bno
                    })
                }).then(res => res.json())
                .then(data => {
                    console.log(data);
                    console.log(data[0].content);

                    let url = "/board/selectboarddetail.do"
                    let parentContent = document.querySelector('#contentwrap');
                    let id = _commons().util.random();
                    $common.sethistory(url,parentContent,id);

                    let jsondata = {
                        "title" : data[0].title,
                        "content" : data[0].content,
                        "writer" : data[0].writer,
                        "regdate" : data[0].regdate,
                        "bno" : data[0].bno,
                        "filename" : data[0].filename,
                        "filerealname" : data[0].filerealname
                    }

                    $('#content').load(url,jsondata,function(){

                    });
                })
            }




    });
</script>
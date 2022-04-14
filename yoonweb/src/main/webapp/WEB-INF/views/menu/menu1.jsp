<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <style>
        .board{
            width: 100%;

        }
    </style>
</head>
<body>
<div id="content">
    <div id="contentwrap">
        <h2>CRUD</h2>
        <button class="regi">등록</button>
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
    </div>
</div>
</body>
</html>
<script>
    $(document).ready( async function(){

        let regibtn = document.querySelector('.regi');

        regibtn.onclick = function(){
            $('#main_content').load("/regi/loader",function(){

            });
        }

        let fetchdata;

            await fetch('/board/search.do',{
                method: "POST",
                headers: {
                    'content-type' : 'application/json'
                },
                body: JSON.stringify({

                })
            }).then(res=> res.json())
            .then(data =>{
                fetchdata = data;

                });

        console.log(fetchdata);



        function goPost(){
            alert('test');
        }


    });
</script>
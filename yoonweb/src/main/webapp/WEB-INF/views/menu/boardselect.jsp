<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <div id="contentwrap2">
        <h2> 제목 : <span class="title">${title}</span></h2>
        <p> 작성자 : <span class="writer">${writer}</span> </p>
        <p> 내용 : <span class="boardcontent">${content}</span> </p>
        <p>작성일자 : <span class="date">${regdate}</span> </p>
        <p class="attachfile" style="display: none"> 첨부파일 :</p>

        <button class="backbtn">뒤로가기</button>
        <button class="updatebtn" style="display: none">수정하기</button>
        <button class="rmbtn" style="display: none">게시글 삭제</button>
    </div>
</body>
</html>
<script src='/js/jquery-3.6.0.min.js?ver=1'></script>

<script>
    $(document).ready(function(){

        let $localstorage = $commons.storage.g_variable;
        let writercheck = "${writer}";
        let bno = "${bno}";
        let rmbtn = document.querySelector('.rmbtn');
        let backbtn = document.querySelector('.backbtn');
        let $history = $commons.history;
        let changecontent =document.querySelector('#content');
        let $common = $commons.history
        let upbtn = document.querySelector('.updatebtn');
        let attach = document.querySelector('.attachfile');







        //노드생성
        let filetest = "${filename}";


        //파일없을때 숨기기.\
        if(filetest !== ""){
            attach.style.display = '';
        }


        console.log('tet ='+filetest);
        let converfilename = filetest.slice(1,-1);
        console.log(converfilename);
        const filenamearr = converfilename.split(", ");

        //filerealname
        let realname = "${filerealname}"
        console.log(realname);
        let converrealfilename = realname.slice(1,-1);
        const filerealnamearr = converrealfilename.split(", ");

        for(let i = 0; i < filenamearr.length;i++){
            console.log(filenamearr[i]);
            let test = filenamearr[i];
            console.log(test);
            let node = document.createElement("a")
            let template = `
        <a href="fileDownload.do?fileName=\${filenamearr[i]}&&filerealName=\${filerealnamearr[i]}">\${filerealnamearr[i]}
        </a>`
            node.innerHTML = template;
            attach.appendChild(node);

        }







        // authcheck
        if( writercheck === $localstorage.getValue("loginUser")){
            rmbtn.style.display = '';
            upbtn.style.display = '';
        }

        //수정
        upbtn.onclick = function(){
            //history set
            let historycontent = document.querySelector('#contentwrap2');
            let id = _commons().util.random();
            $history.sethistory("/board/updateboard.do",historycontent,id);


            let url = "/board/updateboard.do";
            let date = "${regdate}";
            let json ={
                title : "${title}",
                content : "${content}",
                regdate : date.toString(),
                bno : "${bno}"
            }
            $('#content').load(url,json,function(){
            })
        }


        rmbtn.onclick = function(){
            fetch('/board/remove.do',{
                method : "POST",
                headers : {
                    'content-type' : 'application/json'
                },
                body :JSON.stringify({
                    bno: bno
                })
            }).then(res => res.json());

            $common.deletehistory("/board/selectboarddetail.do");

            let url = 'menu/menu1.do'
            $('#main_content').load(url,function(){

            });


        }


        backbtn.onclick = function(){
            let link = $history.gethistory("/board/selectboarddetail.do");
            let oldElement = document.querySelector('div#contentwrap2');
            changecontent.replaceChild(link.content,oldElement);
        }



    });


</script>
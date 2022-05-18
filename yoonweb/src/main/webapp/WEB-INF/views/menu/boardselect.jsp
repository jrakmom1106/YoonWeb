<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div id="contentwrap2">
    <h2> 제목 : <span class="title"></span></h2>
    <p> 작성자 : <span class="writer"></span></p>
    <p> 내용 : <span class="boardcontent"></span></p>
    <p>작성일자 : <span class="date"></span></p>
    <div class="file">
        <p class="attachfile"> 첨부파일 :<span class="filelist"></span></p>
    </div>
    <form id="formdata" name="formdata" method="post">
        <input type="hidden" id="bno" name="bno"/>
    </form>


    <button class="backbtn">뒤로가기</button>
    <button class="updatebtn">수정하기</button>
    <button class="rmbtn">게시글 삭제</button>
</div>
</body>
</html>
<script src='/js/jquery-3.6.0.min.js?ver=1'></script>

<script>


    $(document).ready(function () {

        let $localstorage = $commons.storage.g_variable;
        let writercheck = "${writer}";
        $("#bno").val("${bno}");
        let bno = "${bno}";
        let rmbtn = document.querySelector('.rmbtn');
        let backbtn = document.querySelector('.backbtn');
        let $history = $commons.history;
        let changecontent = document.querySelector('#content');
        let $common = $commons.history
        let upbtn = document.querySelector('.updatebtn');
        let attach = document.querySelector('.attachfile');

        let form = new FormData(document.getElementById("formdata"));
        console.log(form);
        jQuery.ajax({
            url: "/board/boardDetail.do",
            data: form,
            type: "POST",
            dataType: "json",
            processData: false,
            contentType: false,
            success: function (data) {
                console.log("ajax here");
                console.log(data);
                console.log("lis");
                console.log(data.dataList);
                $(".title").text(data.dataList.TITLE);
                $(".writer").text(data.dataList.WRITER);
                $(".boardcontent").text(data.dataList.CONTENT);
                $(".date").text(data.dataList.REGDATE);

                if(data.dataList.file[0] == null){
                    $(".file").hide();
                }else{
                    console.log("파일있음");
                    let element ='';
                    $(data.dataList.file).each(function(i,itm){
                       console.log(i);
                       console.log(itm);
                       console.log(itm.REALNAME);
                       element += '<a href="fileDownload.do?fileName='+itm.FILENAME+'&&filerealName='+itm.REALNAME+'">'+itm.REALNAME+'</a>';
                    });
                    $(".filelist").html(element);
                    if(!(data.dataList.WRITER == $localstorage.getValue("loginUser"))){
                        $(".updatebtn").hide();
                        $(".rmbtn").hide();
                    }


                    /* ES6 시
                    for (let key in data.dataList.file){
                        console.log(key)
                        console.log(data.dataList.file[key]);
                    }
                    */


                }
            },
            error: function (err) {
                console.log(err);
            }
        })



        //수정
        upbtn.onclick = function () {
            //history set
            let historycontent = document.querySelector('#contentwrap2');
            let id = _commons().util.random();
            $history.sethistory("/board/updateboard.do", historycontent, id);

            let url = "/board/updateboard.do";
            let json = {
                bno: "${bno}"
            }
            $('#content').load(url, json, function () {
            })
        }


        rmbtn.onclick = function () {
            fetch('/board/remove.do', {
                method: "POST",
                headers: {
                    'content-type': 'application/json'
                },
                body: JSON.stringify({
                    bno: bno
                })
            }).then(res => res.json());

            $common.deletehistory("/board/selectboarddetail.do");

            let url = 'menu/menu1.do'
            $('#main_content').load(url, function () {

            });


        }


        backbtn.onclick = function () {
            let link = $history.gethistory("/board/selectboarddetail.do");
            let oldElement = document.querySelector('div#contentwrap2');
            changecontent.replaceChild(link.content, oldElement);
        }


    });


</script>
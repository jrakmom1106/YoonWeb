<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <style>
        .uploadimage {
            width: 50px;
            height: 50px;
        }
        ul{
            list-style:none;
        }
        .fileuploder label {
            display: inline-block;
            padding: .5em .75em;
            color: #999;
            font-size: inherit;
            line-height: normal;
            vertical-align: middle;
            background-color: #fdfdfd;
            cursor: pointer;
            border: 1px solid #ebebeb;
            border-bottom-color: #e2e2e2;
            border-radius: .25em;
        }
        .fileuploder input[type="file"] {
            /* 파일 필드 숨기기 */
            position: absolute;
            width: 1px;
            height: 1px;
            padding: 0;
            margin: -1px;
            overflow: hidden;
            clip:rect(0,0,0,0);
            border: 0;
        }
    </style>
</head>
<div id="contentwrap2">

    <form id="formdata">
        <h3> 제목 : <input type="text" placeholder="제목" id="subject" name="subject"></h3>
        <h3> 내용 : <input type="text" placeholder="내용" id="writecontent" name="content"></h3>
        <h3 class="fileuploder"> 파일첨부 :
            <label for="ex_file">업로드</label>
            <input type="file" id="ex_file" name="filename" multiple>
        </h3>
    </form>

    <ul class="lst_thumb">

    </ul>

    <button type="button" class="reg">등록</button>
    <button type="button" class="backbtn">취소</button>

</div>

</body>
</html>
<script src='/js/jquery-3.6.0.min.js?ver=1'></script>

<script>
    $(document).ready(function () {


        const imageTag = document.getElementById("ex_file");

        imageTag.addEventListener('change', function () {

            loadImg(this); // 이미지 파일을 읽어 img src 에 넣는 함수

        });

        function loadImg(value) {


            for(let i = 0; i<value.files.length ;i++){
                console.log("in")
            if (value.files && value.files[i]) {

                let reader = new FileReader();

                let fullname = document.getElementById("ex_file").files[i].name;
                let str = fullname.split('.');
                let ext = str[1];
                console.log("확장자: " + ext);

                let node = document.createElement('li');
                let tmp = `
                    <li><img scr="" class="uploadimage">
                            \${fullname}
                        <input type="button" class="rmbtn" value="삭제">
                    </li>
                `
                node.innerHTML = tmp;

                node.querySelector('.rmbtn').onclick = function(){
                    node.remove();
                    const dataTransfer = new DataTransfer();
                    let trans = $('#ex_file')[0].files;
                    let filearray = Array.from(trans);
                    filearray.splice(i,1);
                    filearray.forEach(file => {dataTransfer.items.add(file);});
                    $('#ex_file')[0].files = dataTransfer.files

                }

                let onnode = document.querySelector('.lst_thumb');

                if (ext == "txt") {
                    onnode.appendChild(node)
                    node.querySelector("img").setAttribute('src',"/assets/img/textfile.jpg");
                } else {
                    reader.onload = function (e) {
                        onnode.appendChild(node)
                        node.querySelector("img").setAttribute('src', e.target.result);
                    }
                }

                reader.readAsDataURL(value.files[i]);
            }

            }

        }


        let title = document.querySelector('#subject');
        let content = document.querySelector('#writecontent');
        let $globalStorage = $commons.storage.g_variable;
        let writer = $globalStorage.getValue("loginUser");
        let date = $commons.util.date();
        let regibtn = document.querySelector('.reg');

        let backbtn = document.querySelector('.backbtn');
        let $common = $commons.history
        let changecontent = document.querySelector('#content');


        let ex_file = document.querySelector('#ex_file');






        backbtn.onclick = function () {

            console.log('click back')
            let test = $common.gethistory("/regi/loader.do");
            console.log(test.content);
            // $('#content').load("/menu/menu1.do",function (){
            //
            // });

            let oldElement = document.querySelector('div#contentwrap2');
            changecontent.replaceChild(test.content, oldElement);

        };

        regibtn.onclick = function () {
            let myformdata = document.getElementById('formdata');
            let formData = new FormData(myformdata);

            let filelist = document.getElementById("ex_file").files;

            let sendList = new Array();

            for(let i = 0; i< filelist.length;i++ ){
                let fullname = filelist[i].name
                let str = fullname.split('.');
                let ext = str[1];

                let data = new Object();
                data.filename = fullname;
                data.ext = ext;
                sendList.push(data);
            }
            let jsonData = JSON.stringify(sendList);

            formData.append("files",jsonData);
            formData.append("writer", writer);
            formData.append("date", date)

            fetch("/board/register.do", {
                method: 'POST',
                body: formData
            }).then(res => {
                $common.deletehistory("/regi/loader.do");

                let url = 'menu/menu1.do'
                $('#main_content').load(url, function () {

                });
            });


        }


    });


</script>

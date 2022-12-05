<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="kr">
<head>

    <title>ajax2 테스트</title>

    <meta charset="UTF-8"/>
    <meta name="format-detection" content="telephone=no"/>
    <%--    <meta name="viewport" content="width=device=width, initial-scale=1"/>--%>

    <%@ include file="../_stylesheet.jsp"%>

</head>
<body>
Ajax 요청 방식 : get, post
<br>
<form>
    이름 : <input type="text" name="name" id="name"><br>
    나이 : <input type="text" name="age" id="age"><br> <br>
    <input   type="button" value="get" id="btnGet">
    <input type="button"  value="post" id="btnPost">
    <hr>
    <div id="show"></div>
</form>





<script src='/js/jquery-3.6.0.min.js?ver=1'/></script>
<script src='/assets/lib/yoon/common.js?ver=1'/></script>
<script src='/assets/lib/tab/tab-ui.js?ver=1'></script>
<script type="text/javascript">

    let initialize = function(){

        let url = "/assets/lib/ajax/getpost.jsp"
        let fName=""
        let name = document.querySelector('input#name');
        let age = document.querySelector('input#age');

        window.onload = function() {
            document.getElementById("btnGet").onclick=getFunc;
            document.getElementById("btnPost").onclick=postFunc;

        }
        let xhr;
        function getFunc() {
            let irum = name.value;
            let nai = age.value;
            //alert(irum + " " + nai);
            fName = "/assets/lib/ajax/getpost.jsp?name=" + irum + "&age=" + nai;
            xhr = new XMLHttpRequest();
            xhr.open("GET", fName, true);
            xhr.onreadystatechange = function() {
                if (xhr.readyState == 4) {
                    if (xhr.status == 200) {
                        process();
                    } else {
                        alert("요청 실패:" + xhr.status);
                    }
                }
            }
            xhr.send(null);
        }
        function postFunc() {
            let irum = name.value;
            let nai = age.value;
            //alert(irum + " " + nai);
            fName = "/assets/lib/ajax/getpost.jsp";
            xhr = new XMLHttpRequest();
            xhr.open("post", fName, true);
            xhr.onreadystatechange = function() {
                if (xhr.readyState == 4) {
                    if (xhr.status == 200) {
                        process();
                    } else {
                        alert("요청 실패:" + xhr.status);
                    }
                }
            }

            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xhr.send("name=" + irum + "&age=" + nai);
        }

        function process() {
            let data = xhr.responseText;
            document.getElementById("show").innerHTML = data;
        }



    }

    $(function(){
        initialize();
    })
</script>
</body>
</html>
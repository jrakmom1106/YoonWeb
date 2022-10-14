<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
<style>
    .board{
        width: 100%;
    }
    .ui-helper-hidden-accessible{
        display:none;
    }
</style>
</head>
<body>
<div id="content" class="menu2_tab">
    <div id="contentwrap">

        <input id="autoCompleteInput"/>

        <%--<form id="frm">
            <input type="text" placeholder="제목" id="subject" name="subject">
            <input type="text" placeholder="내용" id="writecontent" name="content">
            <button type="button" onclick="fn_boardRegi();">등록</button>

        </form>--%>

    </div>
</div>
</body>
</html>
<link rel="stylesheet"
      href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src='/js/jquery-3.6.0.min.js?ver=1'></script>
<script src='/js/jquery-ui.js?ver=1'></script>
<script type="text/javascript">

    let initailize = function(){

        let container = document.querySelector(".menu2_tab");

        let auto_input =  container.querySelector("#autoCompleteInput");



        $("#autoCompleteInput",container).autocomplete({
            source: function(request,response){
                $.ajax({
                    url: 'member/memberAutoComplete.do',
                    type : "POST",
                    contentType : "application/json",
                    data : JSON.stringify({VALUE : request.term}),
                    success : function (responseData){
                        response(
                            $.map(responseData , function(item){
                                return{
                                    value : item.USER_NAME,
                                    label : item.USER_NAME
                                }
                            })
                        )
                    },
                    error: function(){

                    }
                });
            },
            create : function(event , ui){
                $(this).data('ui-autocomplete')._renderItem = function(ul,item){
                    /*ul.addClass('auto-search__list');*/
                    let label = item.label.replace($("#autoCompleteInput",container).val(),'');
                    let element = $('<div><mark>'+$("#autoCompleteInput",container).val()+'</mark>'+ label +'</div>');
                    return $('<li></li>').append(element).appendTo(ul);
                }
            },
            focus: function(event,ui){
                return false;
            },
            minLength: 1,
            autoFocus : true,
            delay : 300,
            classes : {
                'ui-autocomplete': 'highlight'
            },
            /*appendTo : 해당 옵션 body에 만들지 container 와 같은 탭 영역에 생성해서 생명주기 조절 가능*/
            select: function(evt,ui){
                // 선택시 이벤트 부여 가능
            }

        })


    }


    $(document).ready( function () {
        // start
        initailize();

    });

    /*function fn_boardRegi(){
        let title = $("#subject").val();

        let content = $("#writecontent").val();
        let $globalStorage = $commons.storage.g_variable;
        let writer = $globalStorage.getValue("loginUser");
        let date = $commons.util.date();

        fetch("/board/register.do",{
            method: 'POST',
            headers: {
                'content-type' : 'application/json'
            },
            body: JSON.stringify({
                title: title,
                content : content,
                writer : writer,
                regdate: date,
                viewcnt : 0
            })
        }).then(res => res.json())
        .then(data => {
            console.log(data);
        })

    };*/
</script>
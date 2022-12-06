<%--
  Created by IntelliJ IDEA.
  User: 82105
  Date: 2021-12-15
  Time: 오후 6:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

<input type="radio" class="ui-radio" name="equip_type_radio" id="equip_type_all" disabled value="01" checked/>
<label for="equip_type_all" class="ui-label"></label>

<input type="radio" class="ui-radio" name="equip_type_radio" id="equip_type_3g" disabled value="02" checked/>
<label for="equip_type_3g" class="ui-label"></label>




<ul>
    <li>
        <div>
            <input type="radio" class="ui-radio" name="filter2" id="filter2-1" checked/>
            <label for="filter2-1" class="ui-label">
                <span class="ui-radio-object"></span>
                <span class="ui-label__text">전체</span>
            </label>
        </div>
    </li>
    <li>
        <div>
            <input type="radio" class="ui-radio" name="filter2" id="filter2-2" checked/>
            <label for="filter2-2" class="ui-label">
                <span class="ui-radio-object"></span>
                <span class="ui-label__text">전체</span>
            </label>
        </div>
    </li>
</ul>

<%--
    label을 쓰게 되면 for가 중요하다 for는 label에 해당하는 유닛의 아이디를 집어넣어줘야 한다. document,container 유의할것
--%>



<script type="text/javascript">

    let initialize = function(){


        let currentYear = new Date().getFullYear();
        let currentMonth = new Date().getMonth();

        let container = document.querySelector("div.wrap-content");

        let report= container.querySelector("input#report")

        /*
        let radio1 = container.querySelector("input#radio1");
        let radio2 = container.querySelector("input#radio2");
        */ // 각각에 id를 부여하지말고 name으로 해결하자

        let equip_type_radio = container.querySelector('input[type=radio][name=equip_type_radio]');
        //이런식으로 선언하여 배열의 index 넘버를 칭하는 것처럼 핸들링 가능하다.
        equip_type_radio[0].checked = true; // 이것도 위에 checked 를 주었기 때문에 필요가 없다.

        equip_type_radio[0].onchange = function(){
            setSelectorYear(2008);
            yearList.value = currentYear;
        }

        // case를 나눠서 코딩하지 말고 주는 parameter을 핸들링하여서 코딩하기.
        function setSelectorYear(startYear){
            yearList.innerHTML=""; // 뒤의 remove()를 할 이유가 없어진다. 호출이 되면 그 값을 비워주고 다시 생성
            for(let i = startYear; i< currentYear; i++){
                let yearTemplate = `<option value=\${i}>${i}</option>`
                let template = document.createElement('template');
                template.innerHTML = yearTemplate;
                let node = document.importNode(template.content, true);
            }

        }

        //참고로 html에서 넘어오는 value의 값은 string이다.
        //swith case에서 만약 똑같은 값을 준다면 어차피 break 문을 만나기 전까지 쭉 내려오게 되어있다. 따라서 공통된 부분을 다음과 같이 묶어버리면 코드가 간략해진다.

        report.onchange = function (){
            switch (report.value){
                case '1' :
                case '2' :
                case '6' :
                    // 위의 순서는 연관되어있다는 고정관념을 깨자
                setSelectorYear(2008);
                equip_type_radio[0].checked = true;
                equip_type_radio[0].disabled = true;
                equip_type_radio[1].disable = true;
                break;
                case '2':
                equip_type_radio[0].disabled = false;
                equip_type_radio[1].disable = false;
                break;
            }
        }

        //check 된 값에 따라 01,00 을 부여하지 않고 value를 html 값에 주고 해당하는 값을 가져오기
        excel.onclick = function(){
           let radioresult = container.querySelector('input[type=radio][name=equip_type_radio]:checked').value
        }




    let fromyear = 2008;
    /*let currnetYear = new Date().getFullYear();
    let currentMonth = new Date().getMonth();*/


    for(let i = fromyear; i< currnetYear; i++){
        let yearTemplate = `<option value=\${i}>${i}</option>`
        let template = document.createElement('template');
        template.innerHTML = yearTemplate;
        let node = document.importNode(template.content, true);
        yearList.appendChild(node)
        }
    yearList.value = currnetYear;



    $("#year_list *").remove();
    $("#year_list").remove();






    let yearList = container.querySelector("select#year_list");
    let monthList = container.querySelector("select#month_list");



    function controlldate(index){
        let year = yearList.value;
        let month = monthList.value;

        let lastDate = new Date(year,month,0).getDate(); // 해당 달의 마지막 날
        let substryear = String(year).substring(2,4); // string 값을 가지고 있음
        // number을 string으로 바꾼다음에 함수를 사용해야 함 안하게 되면 function type exception

        let returnStr = "";
        if(index == 1){
            returnStr = "이번달 마지막 날은" + lastDate + "입니다" + " 이번년도 끝자리 2글자는" + substryear +"입니다";
        }
        return returnStr;
    }


    //2 radio onchange 핸들링

        // radio는 체크되어있는지 안되어있는지 checked 함수를 통해서 true 혹은 false를 리턴받을 수 있다.


        let radio1 = container.querySelector("input#radio1");
        let radio2 = container.querySelector("input#radio2");

        // onchange를 이용해서 값이 변할 때 마다 action을 줄 수 도 있고
        radio1.onchange = function(){
            yearList.value = currentYear; // 선택박스의 값을 현재년도로
        }
        radio2.onchange = function(){
            monthList.value = currentMonth; // 현재월로
        }

        //아래와 같이 boolean 값 리턴을 이용해서 action을 줄 수도 있다.
        if(radio1.checked){
            console.log("1번 radio 체크 되어 있음")
        }
        else if(!(radio1.checked)){
            console.log("1번 radio 체크 되어있지 않음")
        }

        //let 이나 var 이나 const 나 jsp 는 {} 안에 감싸져 있지 않다면 hoisting을 하기 때문에 순서는 상관이 없다.
        //하지만 예를 들어 radio.checked = ture 라는 것이 앞의 if문보다 뒤에 있으면 어느 값을 출력할까
        radio1.checked = true;

        // 결과값은 체크 되어있지 않다고 나온다.

        //event 리스너나, await, async 등은 안에서 대기하고 있게 되고 그 외의 값들은 순차적으로 전부다 메모리에 올라가고 실행되기 때문이다.
        // 그래서 if문 먼저 판독을 한뒤 당연히 체크가 안되어 있으니 안되어있다고 출력하고 그 뒤에 radio1.checked = true 만나 화면상으로는 체크된 모습을 확인 할 수 있다.




        let datagrid;

        function gridlist(data){
            let id = container.querySelector('.ui-board-table').id; // 해당하는 값의 고유 id
            if(!datagrid){
                id = $commons.util.random();
                container.querySelector('.ui-board-table').id = id
            } // SPA에서 다른 페이지 와 비교하기 위한 random 함수를 이용해서 고유 id 부여하고 이를 비교

        }



        ///

        function _fetchAjax(globalFunctions){ // object를 받아와야한다
            let _globalFunctions = {
                start: globalFunctions && globalFunctions.start ? globalFunctions.start : undefined,
                stop: globalFunctions && globalFunctions.stop ? globalFunctions.stop : undefined,
                send: globalFunctions && globalFunctions.send ? globalFunctions.send : undefined,
                success: globalFunctions && globalFunctions.success ? globalFunctions.success : undefined,
                error: globalFunctions && globalFunctions.error ? globalFunctions.error :undefined,
                complete: globalFunctions && globalFunctions.complete ? globalFunctions.complete : undefined
            }
            let _requests = {}
            return{
                request: function(option){
                    let request = _fetchAjaxRequest(option,_globalFunctions);
                    if(option.global){
                        _requests[request.id] = request;
                    }
                    return request;
                },
                abort: function(id){
                    if(_requests[id]){
                        _requests.abort();
                        delete _requests[id];
                    }
                },
                abortAll: function(){
                    for(let id in _requests){
                        this.abort(id);
                    }
                },

            }
        }

        function _fetchAjaxRequest(userOptions, globalFunctions){
            const _DEFAULT_OPTIONS = {
                url: undefined,
                type: undefined,
                method: undefined,
                datatype: 'json',
                cors: 'no-cors',
                global: true,
                data: undefined,
                header: {},
                body: undefined,
                success: undefined,
                error: undefined,
                complete: undefined
                // befroeSend: undefined
            }

            const abortController = new AbortController(); // ?

            let _id = Math.random().toString(36).substr(2,11);
            let _options = _optionsSerialize(userOptions); // 전달받은 유저 옵션에 따른 값
            let _globalFunctions =globalFunctions; // 전달받은 파라미터 값





            console.log(' > Ajax request [' + _id +  '] \n', _options);

            _eventDispatch('start',_id);
            let _promise = new Promise((resolve,reject) =>{
                _eventGlobalDispatch('send',_id);
                _eventDispatch('beforeSend');

                let request = fetch(_options.url,_options);

                request.then(async (response)=>{
                    try{
                        let data = await _parseResponse(response);
                        _eventGlobalDispatch('success',_id,data);
                        _eventDispatch('success',data);
                        resolve(data);
                    }catch(e){
                        console.log('response.parse Error');
                    }finally {
                        _eventGlobalDispatch('complete',_id);
                        _eventDispatch('complete');
                        _eventGlobalDispatch('stop',_id);
                    }

                })

                request.catch((error)=>{
                    _eventGlobalDispatch('error',_id,error);
                    _eventDispatch('error',error);

                    reject(error)

                    _eventGlobalDispatch('complete',_id);
                    _eventDispatch('complete');

                    _eventGlobalDispatch('stop',_id);
                })

            });

            //promise
            _promise['id']=_id;
            _promise['options'] = _options;
            _promise['abort'] = () =>{
                abortController.abort();
            };
            _promise['response']= undefined



        downbtn = container.querySelector("button#downbtn");

        downbtn.onclick = function (){
            //클릭 이벤트
            console.log('클릭')
        }


    }
    $(function (){
        initialize();
    })


</script>
</body>
</html>

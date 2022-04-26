
let _commons = function() {
    const _PATH = '/assets/lib/yoon'
     const _LEGACY_GLOBAL_VARIABLE = load(_PATH,'yoon-legacy-global-variable.json');
   //  const _LEGACY_INPUT_DATASET = load(_PATH,'yoon-legacy-global-variable.json');
   //  const _LEGACY_GLOBAL_DATASET = load(_PATH,'yoon-legacy-input-variable.json');
    //레거시
    let _Self;

    function load(path,fileName){

        let filePath = path + '/' + fileName;
        const key = fileName.replace('.json','');

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
    }




    /**
     * Fetch API 를 통해 HTTP 메시지를 요청
     * @param {Object} globalFunctions 글로벌 이벤트 함수 에  로드된 페이지 위치의 모든 요청에 대한 이벤트 핸들링 함수 모음
     * (start,stop) // 추가 가능..
     * @function : request
     * @function : abort
     * @function : abortAll
     */


    function _fetchAjax(globalFunctions){ // object를 받아와야한다
        let _globalFunctions = {
            start: globalFunctions && globalFunctions.start ? globalFunctions.start : undefined,
            stop: globalFunctions && globalFunctions.stop ? globalFunctions.stop : undefined
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

    /**
     * Fatch API 를 통해 HTTP 메시지를 요청
     * @param {Object} userOptions HTTP 메시지 생성에 필요한 데이터
     * {
     *      url:{String},
            type: {String},
            method: {String},
            datatype: 'json',
            global: {Boolean} default 'true',
            data: {Any},
            header: {Object},
            body: {Function},
            success: {Function},
            error: {Function},
            complete: {Function}
     *  }
     (start,stop)

     * @function request
     * @function abort
     * @function abortAll
     * @return {Promise}
     */

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




        // 함수부분 //
        function _parseResponse(response){
            _promise['response'] = {
                status: response.status
            }
            let data;
            switch (_options.datatype){
                case "json":
                    data= response.json();
                    break;
                case 'fromData':
                    data = response.formData();
                    break;
                case 'blog':
                    data= response.blob();
                    break;
                case 'text':
                    data = response.text();
                    break;
            }
            return data;
        }


        function _eventDispatch(event,data){
            if(_options[event]){
                _options[event](data);
            }
        }


        function _eventGlobalDispatch(event, id, data){ //event 보내는 함수
            if(!_options.global){
                return;
            }
            if(_globalFunctions && _globalFunctions[event]){
                _globalFunctions[event](id,data);
            }
        }


        function _optionsSerialize(userOptions){ // 옵션에 따른 분배. type과 method를 같게하고 내용물을 data로 바꿈
            let options = Object.assign({},_DEFAULT_OPTIONS);
            for(let name in userOptions){
                if(Object.keys(options).includes(name)){
                    options[name] = userOptions[name];
                }
            }

            if(options.type){
                options.method = options.type;
            }else if(options.method){
                options.type = options.method;
            }
            if(options.data){
                options.body = options.data;
            }
            return options;

        }

        return _promise;

    }



    let history={
    };

    let activate={};

        return _Self ={
            fetchAjax:_fetchAjax,


            data: {
                // global: _LEGACY_GLOBAL_DATASET,
                // input: _LEGACY_INPUT_DATASET,
                variable: _LEGACY_GLOBAL_VARIABLE,

                g_variables:{


                },

                serialize: function(data){
                    let temp = {
                        parameters: {},
                        datasets: {}
                    }
                    let parameters = data['parameters'];
                    let datasets = data['datasets'];

                    if(data&&parameters){
                        if(typeof parameters !=="object"){
                            throw 'Invalid data (\'parameters :Object\', Map<String>, Object>)';
                        }
                        for(let key in parameters){
                            let value = parameters[key];

                            temp.parameters[key]= value; // 비어있는 temp안의 parameters에게 key 값 전달
                        }
                    }
                    if(data&&datasets){
                        if(typeof datasets !=="object"){
                            throw 'Invalid data (\'parameters :Object\', Map<String>, Object>)';
                        }
                        for(let key in datasets){  // 받아온 오브젝트의 datasets라는 부분을 datasets라 칭했고 그 안에 있는 값들을 dataset 이라는 객체안에 datsets[key] 라는(반복분을 돌면서 처음부터 끝까지 반복_
                            let dataset = datasets[key];
                            if(!Array.isArray(datasets)){
                                throw 'Invalid data (\'datasets :Array\', Array<Map<String>, Object>)';
                            }
                            temp.datasets[key] = []; // 받아온 object의 크기만큼 배열 만들기
                            for(let value of dataset){
                                //실제로 받아온 값들에 크기에 대한 index넘버에 따른 값들을 value라는 곳에 반복해서 집어넣기.
                                temp.datasets[key].push(value);
                            }

                        }
                    }

                    return JSON.stringify(temp);
                }

            },
            storage:{
                constant: {
                    g_variable: 'yoon-legacy-global-variable'
                },
                set : function(constant, data){
                    if(!data){
                        throw 'data is undefined or null';
                    }
                    if(typeof data ==='object'){
                        data = JSON.stringify(data);
                    }
                    window.localStorage.setItem(constant,data);
                },
                get : function(constant){
                    let userData = window.localStorage.getItem(constant);
                    return userData ? JSON.parse(userData) : {};
                },
                g_variable: {
                    get : function(){
                        return _Self.storage.get(_Self.storage.constant.g_variable)
                    },
                    getValue: function(key){
                        let temp = this.get();
                        return temp[key]
                    },
                    set : function (data){
                      _Self.storage.set(_Self.storage.constant.g_variable, data);
                    },
                    setValue : function(key, value){
                        let temp = this.get();
                        temp[key] = value;
                        this.set(temp);
                        return temp[key];
                    }
                }
            },
            ui: {
                _runScript: function (content){
                    const SCRIPT_QUERY = 'script';
                    let scripts = content.querySelector(SCRIPT_QUERY);
                    for(let script of scripts){
                        (new Function(script.innerText))();
                    }
                },

                _loadContent: function(url,options){
                    //히스토리로 사용할 부분을 지정
                    /* options
                    {
                        title: title,
                        type : 'TAB,
                        id: linkId,
                        navId: menuId,
                        parent: location.href,
                        target: url
                    }
                    */
                    const CONTENT_WRAP_QUERY = options && options.wrap ? options.wrap : 'contents-wrap'
                    const SCRIPT_QUERY = 'script';

                    return new Promise(async (resolve,reject)=>{
                        let response = await fetch(url) // 프로미스 리턴
                        let html = await response.text(); // String 값으로 변경한뒤 create에 넘겨주기 위함
                        let element = _Self.ui.element.create(html); // 템플릿 생성
                        let content = element.querySelector('div.' + CONTENT_WRAP_QUERY);
                        let scripts = element.querySelectorAll(SCRIPT_QUERY) //선택자와 일치하는 노드의 자손인 첫 번째 요소를 반환합니다

                        if(content){
                            let wrap = document.createElement('div'); // 지정된 테그에 대한 인스턴스 요소를 만든다.

                            let temp = options && options.outer ? content.outerHTML : content.innerHTML; //?
                            for(let script of scripts){
                                if(!scripts.hasAttribute('ignore')){ //지정된 요소에 지정된 속성이 있는지 여부를 나타내는 부울 값을 반환합니다 .
                                    temp += script.outerHTML;
                                }
                            }


                            wrap.innerHTML = temp;
                            wrap.id = '';
                            wrap.dataset.tabId='';

                            resolve(wrap);

                        }
                    });
                },

                _createParam : function(url){ //?
                    let hiddenParam = {};
                    if(url.indexOf('?')>=0){
                        let params = url.substring(url.indexOf('?') + 1, url.length).split('&'); //2개
                            //url의 시작점과 그 해당하는 길이만큼 뽑아와서 &를 기준으로 나눈다음에 배열로 리턴
                        while(params.length !==0){
                            let param = params.shift().split('=',2);
                            hiddenParam[param[0]] = param[1];
                        }
                    }
                    return hiddenParam;
                },

                download: function (url) {
                    const hiddenIFrameID = 'hiddenDownloader';
                    let iframe = document.getElementById(hiddenIFrameID);
                    if (iframe === null) {
                        iframe = document.createElement('iframe');
                        iframe.id = hiddenIFrameID;
                        iframe.style.display = 'none';
                        document.body.appendChild(iframe);
                    }
                    iframe.src = url;
                },
                loader: function(){

                },
                popup: function(){
                    let popups = {};
                    let popupCallback = undefined;
                    let popupCallbacks = [];
                    let parentId = undefined;
                    let parentType = undefined;

                    return{
                        setParent: function(id,type){ // 히스토리 상의 부모가 되는 id와 타입을 지정함
                            parentId = id;
                            parentType = type;
                        }
                    }
                },
                element: {
                    /**
                     * String 형태의 tag 문자열을 element 화
                     * @param {String} htmlString Element 문자열
                     * @apram {Boolean=} isTemplate Template 혀태인지 일반 Element인지
                     * return {HTMLElement}
                     */
                    create: function(htmlString,isTemplate){
                        let nodeName = isTemplate ? 'template' : 'div'
                        let template = document.createElement(nodeName);
                        //템플릿 생성
                        template.innerHTML = htmlString;
                        if(isTemplate){
                            return template.content.firstElementChild;
                        }else{
                            return template;
                        }
                    },
                    removeChild : function(element){
                        while(element.firstElementChild){
                            element.removeChild(element.firstElementChild);
                        }
                    },
                    /**
                     * Element의 이벤트를 발생
                     * @param {HTNLElement} element Target Element
                     * @param {Stirng} eventId 이벤트 명
                     * @param {String|Number=} value element value
                     * @return {HTMLElement}
                     */
                    dispatchEvent: function(element,eventId,value) {
                        if(value){
                            element.value=value;
                        }
                        element.dispatchEvent(new Event(eventId));
                    }
                }

            },
            util:{
                random : function(){
                    return Math.random().toString(36).substr(2,11);
                },
                date : function(){
                    let date = new Date()
                    let year = date.getFullYear().toString()
                    let month = date.getMonth()+1 ;
                    let day = date.getDate();
                    let hours = date.getHours().toString();
                    let min =date.getMinutes().toString();


                    if(month < 10){
                        month = "0"+month.toString();
                    }
                    if(day < 10){
                        day = "0"+day.toString();
                    }

                    return year+ "-" +month+ "-"+day+ "-"+hours+ "-"+min;

                }
            },
            history:{
                sethistory: function(url,newContent,id){
                    let content = newContent;
                    history[url]={
                        content : content,
                        id : id
                    }
                    console.log(history[url]);
                },
                gethistory: function(url){
                    console.log('get' + history[url]);
                    return history[url];
                },
                deletehistory : function(url){
                    delete history[url];
                }
            },
            activate:{
                setactivate: function(url,id){
                    activate={
                        activate: url,
                        id: id
                    }


                }
            }

        }
}


const $commons=_commons();
const $loader=$commons.ui.loader(document.body); //     body: HTMLElement; loader 코딩 말 그대로 화면 로딩 뜨는것

const $fetch = $commons.fetchAjax({ //fetch란? fetAjax 코딩 해야함.
    /*
    외부에서 commons 를 통해 부르고 그 부른 self return 에 의하여 ferchAjax함수를 부른다.
    */
    start: function (){
        $loader.show();
    },
    stop: function (){
        $loader.hide();
    }
});

const $popupManager = function(){
    let components = {};
    return{
        get: function(id){
            if(!components[id]){
                components[id] = $commons.ui.popup();
            }
            return components[id];
        },
        clear: function(){
            if(components[id]){
                delete components[id];
            }
        }
    }
}

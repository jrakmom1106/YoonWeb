const $testTabManager = function () {
    const CONTAINERS = {
        tab: document.querySelector('ul.history-tab__list'),
        content: document.querySelector('div.content')
    } //탭을 구현할 부분을 컨테이너식으로 지정
    const BUTTONS = {
        prev: document.querySelector('button.hi')//전후 버튼 필요시 생성
    }
    const PROPERTIES = { // 탭의 정보
        maxTabCount: 20,
        history: {
            expired: 1000 * 60 * 60 * 24
        }
    }
    const EVENTS = ['active', 'load', 'unload'];

    let _eventListeners = {}

    let _historyTab = {
        activate: undefined,
        tabs: {}
    }

    let _historyWindow = {
        activate: undefined,
        tabs: {}
    }

    let $ui = $commons.ui

    async function _createTab(options) {

        /*
        {
            title:''
            type: '' // 탭인지 윈도우 인지
            id: '' // component ID 즉 메뉴 아이디 menuId
            navID: '' // navigator id (parent menu Id)
            parent: '' //  component 호출 주소
            target: '' // component 가 될 주소

        }
        ->
        {
        id: id,
        title: title,
        url: _url(url),
        parentId: parentId
        }
        */
        if(options.forced) {
            if (_historyTab.tabs[options.id]) {
                _historyTab.tabs[options.id].remove();
            }
        }


        if (_historyTab.tabs[options.id]) {
            console.log('create history tab :' + options.id + '::' + options.title + '-' + options.target);

            let history = {}
            let callbacks = {}
            let data = undefined;

            let popup = $popupManager().get(options.id); // popup

            popup.setParent(options.id, options.type);

            const TAB_TEMPLATE =
                `<li class = "history-tab__item">
                    <div class ="history-tab__block">
                        <a href="javascript:void(0)" class="history-tab__link" title="${options.title}">${options.title}</a>
                        <button type="button" class="ui-button history-tab__delete">
                            <span class="for-ally">삭제</span>
                        </button>
                    </div>
                </li>
                `;

            let tabElement = $commons.ui.element.create(TAB_TEMPLATE, true); // 만든 템플릿 보여주게 하기

            let contentElement = $ui.element.create('');

            let content = await $ui._loadContent(options.target); // 데이터를 가져옴.
            let createId = $commons.util.random();

            let tabId = '_history_tab_' + options.id + '_' + createId;
            let contentId = '_history_content_' + options.id + '_' + createId;

            let _activated = false;

            console.log('> tab : ', tabElement);
            console.log('> content :', contentElement);

            let hiddenId = document.createElement('input');
            hiddenId.type = 'hidden'
            hiddenId.value = options.id;
            hiddenId.id = '_tab_id';

            content.querySelector('.page-contents').appendChild(hiddenId);


            tabElement.id = tabId // 아이디 부여
            contentElement.id = contentId
            contentElement.appendChild(content); // outer 가 뭔지

            CONTAINERS.tab.appendChild(tabElement);
            CONTAINERS.content.appendChild(contentElement);

            _setHistory(options.target, content)
            $ui._runScript(content);

            eventCall('load', {id: options.id, tab: tabElement, content: contentElement});
            _eventCall('load', {id: options.id, tab: tabElement, content: contentElement});

            tabElement.addEventListener('click', function (id) {
                _historyTab.activate = _historyTab.tabs[id];

                _inactiveAll();
                _active(id);
                _arrowCheck();


            }.bind(this, options.id))


            tabElement.querySelector('button.history-tab__delete').addEventListener('click', function (id) {
                let indexs = _historyTab.tabs[id].index()
                event.stopPropagation();

                //활성화 탭 아닌경우 그냥 삭제
                if (id === indexs.siblingId || id !== _historyTab.activate.id) {
                    _remove();
                    _arrowCheck();
                    if (id === indexs.siblingId) {
                        for (let key in _historyTab.tabs) {
                            _active(key);
                            break;
                        }
                    }
                } else {
                    _historyTab.activate = _historyTab.tabs[indexs.siblingId];
                    _remove();
                    _inactiveAll();
                    _active();
                    _arrowCheck();
                }
            }.bind(this, options.id), {capture: false})

            function _setHistory(url, newContent) {
                content = newContent;
                history[url] = {
                    expires: new Date().getTime() + PROPERTIES.history.expired,
                    content: content
                }
            }

            function _remove() {
                CONTAINERS.tab.removeChild(tabElement);
                CONTAINERS.content.removeChild(contentElement);

                popup.closeAll();
                $popupManager().clear(options.id);

                delete history;
                delete _historyTab.tabs[options.id]
                delete data;
                eventCall('unload', {id: options.id});
                _eventCall('unload', {id: options.id});

            }

            return new Promise((resolve) => {
                resolve({
                    title: options.title,
                    id: options.id,
                    navId: options.navId,
                    parent: options.parent,
                    target: options.target,
                    type: 'TAB',
                    tabId: tabId,
                    tabElement: tabElement,
                    contentId: contentId,
                    contentElement: contentElement,
                    content: contentElement,
                    getEditor: function () {

                    },
                    getParams: function () {
                        return $ui._createParam(options.target);
                    },
                    getData: function () {
                        return data;
                    },
                    setData: function (newData) {
                        return data = newData;
                    },
                    active: function () {
                        tabElement.classList.add('is-active');
                        contentElement.style.display = 'block';

                        let tabs = CONTAINERS.tab.querySelectorAll('li.history-tab__item');
                        for (let i = 0; i < tabs.length; i++) {
                            let current = tabs[i];
                            if (current.classList.contains('is-active')) {
                                let index = i;
                                let previous = current.previousElementSibling;
                                let next = current.nextElementSibling;

                                let gap = tabs.length - index;
                                if (gap > index && previous) {
                                    previous.scrollIntoView(false);
                                } else if (index > gap && next) {
                                    next.scrollIntoView(false);
                                } else {
                                    current.scrollIntoView(false);
                                }
                            }
                        }
                    },
                    inactive: function () {
                        tabElement.classList.remove('is-active');
                        contentElement.style.display = 'none';
                    },
                    remove: _remove,
                    index: function () {
                        let keys = Object.keys(_historyTab.tabs);
                        let index = keys.indexOf(options.id);

                        let prev = index - 1;
                        let next = index + 1;

                        if (prev == -1) {
                            prev = 0;
                        }

                        if (next == keys.length) {
                            next = keys.length - 1;
                        }

                        return {
                            index: index,
                            prevId: keys[prev],
                            nextId: keys[next],
                            siblingId: keys[prev] ? keys[prev] : keys[next],
                        }
                    },
                    load: async function (url, isForced, continueValues) {
                        _setHistory(options.target, contentElement.firstElementChild)

                        url = _url(url, options.id, options.type)
                        options.target = url;

                        if (isForced || !history[url]) {
                            console.log('> new load page:' + url + ',' + isForced);
                            let newContentElement = await $ui._loadContent(url);
                            let hiddenId = document.createElement('input');
                            hiddenId.type = 'hidden';
                            hiddenId.value = options.id;
                            hiddenId.id = '_tab_id';

                            newContentElement.querySelector('.page-contents').appendChild(hiddenId);

                            if (history[url] && isForced && continueValues) {
                                let historyContent = history[url].content;
                                for (let initValue of continueValues) {
                                    let historyValueElement = historyContent.querySelector(initValue);
                                    switch (historyValueElement.nodeName) {
                                        case 'INPUT':
                                            switch (historyValueElement.getAttribute('type')) {
                                                case 'checkbox':
                                                    let checkboxValue;
                                                    for (let checkbox of historyContent.querySelectorAll(initValue)) {
                                                        if (checkbox.checked) {
                                                            checkboxValue = checkbox.value;
                                                            break;
                                                        }
                                                    }
                                                    for (let checkbox of newContentElement.querySelectorAll(initValue)) {
                                                        if (checkbox.value === checkboxValue) {
                                                            checkbox.checked = true;
                                                        }
                                                    }
                                                    break;
                                                case 'radio':
                                                    let radioValue;
                                                    for (let radio of historyContent.querySelectorAll(initValue)) {
                                                        if (radio.checked) {
                                                            radioValue = radio.value;
                                                            break;
                                                        }
                                                    }
                                                    for (let radio of newContentElement.querySelectorAll(initValue)) {
                                                        if (radio.value === radioValue) {
                                                            radio.checked = true;
                                                            break;
                                                        }
                                                    }
                                                    break;
                                                default :
                                                    newContentElement.querySelector(initValue).value = historyContent.querySelector(initValue).value
                                                    break;
                                            }
                                            break;
                                        case 'SELECT' :
                                            if(newContentElement.querySelector(initValue).children.length>1){
                                                newContentElement.querySelector(initValue).value = historyContent.querySelector(initValue).value

                                            }else {
                                                let observer = new MutationObserver((mutations) => {
                                                    mutations.forEach(() => {
                                                        newContentElement.querySelector(initValue).value = historyContent.querySelector(initValue).value
                                                        observer.disconnect();
                                                    })
                                                });
                                                observer.observe(newContentElement.querySelector(initValue), {
                                                    childList: true
                                                });
                                            } break;
                                        default:
                                            newContentElement.querySelector(initValue).value = historyContent.querySelector(initValue).value
                                            break;
                                    }
                                }
                            }

                            contentElement.replaceChild(newContentElement, contentElement.firstElementChild);
                            console.log('> replace contents (after, before)' , CONTAINERS.content,contentElement,CONTAINER.content.firstElementChild);

                            $ui._runScript(contentElement)
                            _setHistory(url,contentElement);

                            console.log('new loaded ,',url,history);

                            eventCall('change', {id: options.id, tab: tabElement, content: contentElement});
                            _eventCall('change', {id: options.id, tab: tabElement, content: contentElement});
                        }else if(history[url]){
                            if(history[url].expired > new Date().getTime()){
                                console.log('history load page:' + url +',' + isForced);
                                contentElement.replaceChild(history[url].content, contentElement.firstElementChild);
                                console.log('replace contents (after,before)',CONTAINERS.content,history[url].content,CONTAINERS.content.firstElementChild);
                                console.log('> history loaded', history);

                            }else{
                                console.log('> history  espired. new load page:' + url +',' + isForced);
                                let newContentElement = await $ui._loadContent(url);
                                let hiddenId = document.createElement('input');
                                hiddenId.type = 'hidden'
                                hiddenId.value = options.id
                                hiddenId.id = '_tab_id';

                                newContentElement.querySelector('page-contents').appendChild(hiddenId);

                                contentElement.replaceChild(newContentElement,contentElement.firstElementChild);
                                console.log('> replace contents (after, before' , CONTAINERS.content, contentElement,CONTAINERS.content.firstElementChild);

                                $ui._runScript(contentElement);
                                _setHistory(url,contentElement);
                                console.log('new loaded',url,history);
                            }
                            eventCall('change',{id:options.id,tab: tabElement,content:contentElement});
                            _eventCall('change',{id:options.id,tab: tabElement,content:contentElement});
                        }else{
                            console.log('not work')
                        }

                    },
                    addEventListener : function(eventName,callback){
                        if(!callbacks[eventName]){
                            callbacks[eventName] = [];
                        }
                        callbacks[eventName].push(callback); // push 가 다름...
                    },
                    parentId: options.navId,
                    activated : _activated
                })
            })

            function eventCall(id, value) { //callbacks 라는 객체에 id 값을 load라 주고 value를 삽입
                if (callbacks[id]) {
                    for (let i = 0; callbacks[id].length; i++) {
                        callbacks[id][i](value);
                    }
                }
            }

        } else
            {
                console.log('> before')
                return new Promise((resolve) => {
                    resolve(_historyTab.tabs[options.id])
                })
            }
        } //createtab



        function _active(id) {
            if (id && _historyTab.tabs[id]) {
                _historyTab.tabs[id].active();
                _historyTab.tabs[id].activated = true;
            } else {
                if (_historyTab.activate) {
                    _historyTab.activate.active();
                    _historyTab.activate.activated = true;
                }
            }
            _eventCall('active', {
                title: _historyTab.tabs[id].title,
                parentId: _historyTab.tabs[id].parentId,
                id: id
            });
        }

        function _inactiveAll() {
            for (let id in _historyTab.tabs) {
                _historyTab.tabs[id].inactive();
                _historyTab.tabs[id].activated = false;
            }
        }

        function _url(url, id, type) {
            url = url.replace(location.origin, '');
            let params = $ui._createParam(url);
            if (id && !params.id) {
                params['id'] = id;
            }
            if (type && !params.type) {
                params['type'] = type;
            }
            let paramString = '?';
            for (let paramName in params) {
                paramString += `${paramName} = ${params[paramName]}&`;
            }
            paramString = paramString.substring(0, paramString.length - 1);
            if (url.indexOf('?') > 0) {
                url = url.substring(0, inexOf('?')) + +paramString;
            } else {
                url += paramString
            }
            return url;
        }

        function _arrowCheck() {
            let keys = Object.keys(_historyTab.tabs);
            let index = -1;
            if (_historyTab.activate) {
                index = keys.indexOf(_historyTab.activate.id);
            }
            if (index !== 0 || index !== keys.length - 1) {
                BUTTONS.next.disable = false;
                BUTTONS.prev.disable = false;
            }

            if (index === 0) {
                BUTTONS.prev.disabled = true;
            }
            if (index === keys.length - 1) {
                BUTTONS.next.disabled = true;
            }
        }

        function _eventCall(id, value) {
            if (_eventListeners[id]) {
                for (let i = 0; i < _eventListeners[id].length; i++) {
                    _eventListeners[id][i](value);
                }
            }
        }

        return {
            add: function (options) { //옵션값을 받아와서 탭인지 windwo인지 판단
                switch (options.type) {
                    case 'TAB' :
                        return this.addTab(options);
                    case 'WINDOW' :
                        return this.addWindow(options);
                }
            },
            addTab: async function (options) { //탭 추가의 기능.
                options.target = _url(options.target, options.id, options.type);
                options.parent = _url(options.parent, options.id, options.type);

                let tab = await _createTab(options)
                let id = options.id

                _historyTab.activate = tab;
                _historyTab.tabs[id] = id;

                _inactiveAll();
                _active(id);
                _arrowCheck();

            }

        }

    }

    const $testLaterPopupManager = function () {


        function _url(url, id) {
            if (!url) {
                return;
            }

            url = url.replace(location.origin, ''); //Location 객체의 URL의 출처를 반환합니다. 그리고 공백으로초기화
            let originUrl = url;
            let extensionUrl = url;
            let params = $ui._createParam(extensionUrl); //?

            if (id && !params.id) {
                params['id'] = id
            } // 비어있으면 id 란에 id 값입력

            let paramString = '?'
            for (let paramName in params) {
                paramString += `${paramName} = ${params[paramName]}&`;
            }

            paramString = paramString.substring(0, extensionUrl.length - 1);
            if (extensionUrl.indexOf('?') >= 0) {
                extensionUrl = extensionUrl.substring(0, extensionUrl.indexOf('?')) + paramString;
            } else {
                extensionUrl += paramString
            }
            return extensionUrl;

        }


    }
    const $yoonWindowPopupManager = function () {
        const EVENTS = ['data', 'load', 'focus', 'unload', 'close'];
        let $ui = $commons.ui;
        let _popups = {
            _ordering: []
        }
        let _callbacks = {};
        let _callbacksByPid = {};

        function createId() {
            let randomId = $commons.util.random();
            if (_popups[randomId]) {
                return createId();
            } else {
                return randomId;
            }
        }

        function _setPopup(id, result) {
            _popups[id] = result;
            _popups._ordering.push(id)
        }

        function _removePopup(id) {
            _popups._ordering.splice(_popups._ordering.indexOf(id), 1);// 하나만 지운다.
            delete _popups[id];//
        }

        function _getPopup(id) {
            return _popups[id];
        }

        function _dispatchEvent(id, eventName, data) {
            let callbackGroup = _callbacks[id];
            if (callbackGroup) {
                let callbacks = _callbacks[id][eventName];
                if (callbacks && callbacks.length !== 0) {
                    for (let i = 0; i < callbacks.length; i++) {
                        callbacks[i](id, _popups[id], data);
                    }
                }
            }
        }

        function _dispatchEventByPid(_pid, eventName, data) {
            for (let id in _popups) {
                let pid = _popups[id].pid;
                if (pid === _pid) {
                    let callbackGroup = _callbacksByPid[pid];
                    if (callbackGroup) {
                        let callbacks = _callbacksByPid[pid][eventName];
                        if (callbacks && callbacks.length !== 0) {
                            for (let i = 0; i < callbacks.length; i++) {
                                callbacks[i](id, _popups[id], data);
                            }
                        }
                    }
                }

            }
        }

        let _initPosition = {
            x: 0,
            y: 0
        }

        function _nextPopupPosition(width, height) {
            let X_POSITION_GAP = 30;
            let Y_POSITION_GAP = 20;
            let POSITION_OVER = 40;
            let position = {
                x: 0,
                y: 0
            }

            let popupCount = Object.keys(_popups).length;
            if (popupCount !== 0) {
                let screenWidth = window.screen.width;
                let screenHeight = window.screen.height;

                let lastPopupId = _popups._ordering[_popups._ordering.length - 1];
                if (lastPopupId) {
                    let lastPopup = _popups[lastPopupId];

                    if (lastPopup) {
                        position.x = lastPopup.window.screenLeft + X_POSITION_GAP;
                        position.y = lastPopup.window.screenTop + Y_POSITION_GAP;

                        if (width && position.x + width + POSITION_OVER >= screenWidth) {
                            _initPosition.x = 0;
                            position.x = 0;
                            position.y = 0;
                        }
                        if (height && position.y + height + POSITION_OVER >= screenHeight) {
                            _initPosition.x = _initPosition, x + POSITION_OVER
                            position.y = 0;
                            position.x = _initPosition.x;
                        }
                    }
                }

            }

            return position;

        }


        function _Url(url, id) {
            if (!url) {
                return;
            }
            url = url.replace(location.origin, '');
            let originUrl = url;
            let extensionUrl = url;
            let params = $ui._createParam(extensionUrl);
            if (id && !params.id) {
                params['id'] = id;
            }
            let paramString = '?';
            for (let paramName in params) {
                paramString += `${paramName}=${params[paramName]}&`;
            }
            paramString = paramString.substring(0, paramString.length - 1);
            if (extensionUrl.indexOf('?') >= 0) {
                extensionUrl = extensionUrl.substring(0, extensionUrl.indexOf('?')) + paramString;
            } else {
                extensionUrl += paramString
            }
            return extensionUrl;

        }


        return {
            open: function (url, options) {

                let nextPosition = _nextPopupPosition(options.width, options.height);

                let id = options && options.id ? options.id : undefined;
                let pid = options && options.pid ? options.pid : undefined;
                let data = options && options.data ? options.data : undefined;
                let width = options && options.width ? options.width : 'auto';
                let height = options && options.height ? options.height : 'auto';
                let top = options && options.top ? options.top : nextPosition.y;
                let left = options && options.left ? options.left : nextPosition.x;
                let observerId = undefined;
                let callbacks = {};


                if (!id) {
                    id = createId();
                }
                let parentUrl = options && options.parentUrl ? _Url(options.parentUrl) : undefined;
                let targetUrl = _Url(url, id);

                let _window;
                if (_popups[id]) {
                    let popup = _popups[id];
                    pid = pid ? pid : popup.pid;
                    data = data ? data : popup.data;
                    width = width ? width : popup.width;
                    height = height ? height : popup.height;
                    left = left ? left : popup.left;
                    top = top ? top : popup.top;
                    observerId = popup.observerId;

                    _window = popup.window;
                    _window.location.href = targetUrl;
                } else {
                    let features = (width && height) ? `width=${width},height=${height}` : '';
                    features += `,left=${left},top=${top}`;
                    features += `All=no,status=no,directories=no,menubar=no,toolbar=no,resizeable=no,scrollbars=no,location=no`

                    _window = window.open(targetUrl, id, features);
                    _window.onfocus = function () {
                        dispatchEvent('focus', data);
                        _dispatchEvent('focus', data);
                        _dispatchEventByPid('focus', data);
                    }
                    _window.onunload = function () {
                        dispatchEvent('unload', data);
                        _dispatchEvent('unload', data);
                        _dispatchEventByPid('unload', data);
                    }
                    observerId = stateObserver(targetUrl)
                    loadObserver();
                }

                function loadObserver() {
                    let isLoadSend = false;

                    let interval = setInterval(function () {
                        if (_window.document && _window.document.readyState === 'complete' && !isLoadSend) {
                            dispatchEvent('load', data);
                            _dispatchEvent('load', data);
                            _dispatchEventByPid('load', data);

                            clearInterval(interval);
                            interval = undefined;
                            isLoadSend = true;
                        }
                    }, 10);
                    return interval;
                }


                function stateObserver() {
                    let stateInterval = setInterval(function () {
                        try {
                            if ((_window.location.href && targetUrl) && _Url(_window.location.href, id) !== targetUrl) {
                                loadObserver();

                                _window.onfocus = function () {
                                    dispatchEvent('focus', data);
                                    _dispatchEvent('focus', data);
                                    _dispatchEventByPid('focus', data);
                                }
                                _window.onunload = function () {
                                    dispatchEvent('unload', data);
                                    _dispatchEvent('unload', data);
                                    _dispatchEventByPid('unload', data);
                                }
                                targetUrl = _Url(_window.location.href, id);
                            }

                            if (!_window || _window.close) {
                                dispatchEvent('close', data);
                                _dispatchEvent('close', data);
                                _dispatchEventByPid('close', data);

                                _removePopup();
                                clearInterval(stateInterval);
                            }
                        } catch (e) {
                            dispatchEvent('close', data);
                            _dispatchEvent('close', data);
                            _dispatchEventByPid('close', data);

                            _removePopup();
                            clearInterval(stateInterval);

                            _window.close();
                        }
                    }, 500);
                    return stateInterval
                }

                function dispatchEvent(eventName, data) {
                    if (callbacks[eventName] && callbacks[eventName].length !== 0) {
                        for (let callback of callbacks[eventName]) {
                            callback(data);
                        }
                    }
                }


                let result = {
                    id: id,
                    pid: pid,
                    parentUrl: parentUrl,
                    targetUrl: targetUrl,
                    window: _window,
                    data: data,
                    observerId: observerId,

                    addEventListener: function (eventName, callback) {
                        if (EVENTS.indexOf(eventName) == -1) {
                            throw 'Unsupported event type :' + eventName;
                            return;
                        }
                        if (!callbacks[eventName]) {
                            callbacks[eventName] = [];
                        }
                        callbacks[eventName].push(callback)
                    },
                    removeEventListener: function (eventName, callback) {
                        if (callbacks && callbacks.length !== 0) {
                            for (let i = 0; i < callbacks.length; i++) {
                                if (callbacks[i] == callback) {
                                    _callbacks[eventName].splice(i, 1);
                                }
                            }
                        }
                    },
                    sendData: function (data) {
                        dispatchEvent('data', data);
                        _dispatchEvent('data', data);
                        _dispatchEventByPid('data', data);

                    },
                    dispatchEvent: function (eventName, data) {
                        if (EVENTS.indexOf(eventName) == -1) {
                            throw 'unsurported event type' + eventName;
                            return;
                        }
                        dispatchEvent(eventName, data);
                        _dispatchEvent(id, eventName, data);
                        _dispatchEventByPid(pid, eventName, data);
                    },
                    close: function () {
                        if (_popups[id]) {
                            _window.close();
                            _removePopup(id);
                        }
                    }
                }

                _setPopup(id, result);

                return result;

            }, // open


            close: function (id) {
                if (_popups[id]) {
                    _popups[id].close();
                    delete _popups[id];
                }
            },
            closeByPid: function (pid) {

            }
        }

    }
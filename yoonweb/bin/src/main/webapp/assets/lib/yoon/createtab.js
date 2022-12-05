let _createtab = function(){
    let _self;
    /*
        options :{
        title: '메뉴이름'
        name: 영어탭이름
        parent: location.href
        targer : url
        type: tab
        }
    */
    let _historyTab ={
        activate: undefined
    }
    let history = {

    }
    const CONTAINERS ={
        tab: document.querySelector('ul.tabmenu'),
        content: document.querySelector('div.content')
    }

    let $globalStorage = $commons.storage.g_variable;

    async function createtab(options){
        $globalStorage.setValue(options.name,'open');

        const template = `<span>
                <a href="javascript:void(0);" id="\${options.name}"}">${options.name}</a>
                <button class="history-tab__delete"}">닫기</button>
                <span>`
        let tabnode = document.createElement('li');
        tabnode.classList.add(options.name);
        tabnode.innerHTML = template;

        let contentElement = document.createElement('div');
        contentElement.innerHTML = '';
        let tabcontent = _loadContent(options.target);
        //contentElement.appendChild(tabcontent); ?

        CONTAINERS.tab.appendChild(tabnode);
        CONTAINERS.content.appendChild(contentElement);

        setActivate(options.target);
        _setHistory(options.target,contentElement);

        tabnode.querySelector('button.history-tab__delete').addEventListener('click',function (){

            let close = document.querySelectorAll(("." + options.name));
            close.forEach(function (close) {
                close.remove();
            });

            $globalStorage.setValue(options.name, 'close');
            let indexkey = this.index();
            console.log(indexkey)

            if (_historyTab.activate == options.target) {

                if (indexkey.key.length == 1) {

                    let oldElement = document.querySelector('div.content');
                    oldElement.remove();
                    //
                    delete history[options.target];

                }else{

                    console.log('activate')
                    let oldElement = document.querySelector('div.content');
                    let siburl = indexkey.siblingid;

                    if(indexkey.index ==0){
                        let next = indexkey.nextId
                        siburl = indexkey.key[next];
                    }
                    let content = document.querySelector('div.tabcontent');
                    console.log(siburl);
                    content.replaceChild(history[siburl].content, oldElement);
                    setActivate(siburl);

                    delete history[options.target];
                }
            } else {
                delete history[options.target];
            }



        });

        $(document).on("click", "#" +options.name, function () {
            //replaceChild 와야함
            let content = document.querySelector('div.tabcontent');
            let oldElement = document.querySelector('div.content');
            debugger;
            content.replaceChild(history[options.target].content, oldElement);
            setActivate(options.target);

        });

        return new Promise((resolve,reject)=>{
          resolve({
              title: options.title,
              id: options.id,
              parent : options.parent,
              target: options.target,
              type: 'TAB',
              tabElement: tabnode,
              contentElement: contentElement,
              content: contentElement,
              index : function(){
                  let key = Object.keys(history); // 순서가 들어감.

                  let index = key.indexOf(options.target); // 해당 url주소의 인덱스 넘버.

                  console.log(key);
                  console.log(index);

                  let prev = index - 1;
                  let next = index + 1;

                  if (prev == -1) {
                      prev = 0;
                  }
                  if (next == key.length) {
                      next = key.length - 1;
                  }

                  return {
                      key: key,
                      index: index,
                      prevId: prev,
                      nextId: next,
                      siblingid: key[prev] ? key[prev] : key[next]
                  }
              }
            })
        })



        function _setHistory(url,newContent){
            let content = newContent;
            history[url] = {
                expired: new Date().getTime(),
                content : content
            }
        }

        function setActivate(url){
            _historyTab.activate = url;
        }

    }

    function _loadContent(url){
        let content =$('div.tabcontent').load(url,function(){})
        return content;
    }



    return _self ={
        add: function (options){
            switch (options.type){
                case 'TAB':
                    return this.addTab(options);
                    break;
                case 'WINDOW':
                    return this.addWindow(options);
            }
        },
        addTab: async function (options) { //탭 추가의 기능.
            createtab(options);

        }
    }
}


const $createtab=_createtab();
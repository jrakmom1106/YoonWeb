<Script type="text/javascript">

    let initialize = function (){

        if(!username){
            let print = 'hi'+ username;
            return print;
        }else{
            return "no name";
        }

    }


    $(function(){
        initialize();
    })
</Script>
<%--
  Created by IntelliJ IDEA.
  User: 82105
  Date: 2022-01-06
  Time: 오후 4:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

</body>
</html>

<script src='/js/jquery-3.6.0.min.js?ver=1'/>
<script type="text/javascript">


    let initialize = function(){
        console.log('start');
        let a = {}
        let b = {a: 1, b : 2}
        let c = {a: 10, c : 3}

        let copy = Object.assign(a,b);
        let copy2 = Object.assign(a,b,c);

        console.log(copy);
        console.log(copy2);


    }



    $(function(){
        initialize();
    })

</script>
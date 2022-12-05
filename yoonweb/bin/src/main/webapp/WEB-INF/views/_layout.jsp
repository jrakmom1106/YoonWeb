<%@ page language="java" contentType="text/html; charset = UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>

<script>

    let $windowPopupManager;
    $windowPopupManager = $yoonWindowPopupManager();


    function $openPopup(url,options){
        if($windowPopupManager && url != undefined && url !==''){
            return $windowPopupManager.open(url,options);
        }
    }


    $(function (){

    });

</script>
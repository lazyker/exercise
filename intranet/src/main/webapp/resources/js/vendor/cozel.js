/**
 * toastr message option 설정 
 */
var toastrOptions= function(){
    toastr.options = {
            "closeButton": true,
            "debug": false,
            "newestOnTop": false,
            "progressBar": false,
            "positionClass": "toast-bottom-center",
            "preventDuplicates": false,
            "onclick": null,
            "showDuration": "300",
            "hideDuration": "1000",
            "timeOut": "3000",
            "extendedTimeOut": "1000",
            "showEasing": "swing",
            "hideEasing": "linear",
            "showMethod": "fadeIn",
            "hideMethod": "fadeOut"
    };
}();

//중앙 팝업창
function popupCenter(href, nm, w, h){
    var xPos = (document.body.clientWidth / 2) - (w / 2);  //document.body.clientWidth 현재 브라우저가 있는 모니터의 화면 폭 사이즈
    xPos += window.screenLeft;  //듀얼 모니터일때//현재 브라우저의 x 좌표(모니터 두 대를 합한 총 위치 기준)
    var yPos = (screen.availHeight / 2) - (h / 2);
  
    window.open(href, nm, "width=" + w + ",height=" + h + ", left=" + xPos + ", top=" + yPos + ", toolbars=no, resizable=no, scrollbars=no");
}
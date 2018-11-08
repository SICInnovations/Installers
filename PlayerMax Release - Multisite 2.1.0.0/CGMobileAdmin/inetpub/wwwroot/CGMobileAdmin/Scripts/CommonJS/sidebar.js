jQuery(document).ready(function(){
  var agent   = navigator.userAgent;

  if ( agent.match(/(iPhone|iPod|iPad|Blackberry|Android)/) ) {
    jQuery('#sideBar').click(function(){
        jQuery('body').addClass('opensidebar');
        jQuery('.input-group-btnbtnmargin').addClass('input-group-btnmargin');
       // $("#dvLeftcontentdetail").height($('#dvRightContent').height());
    });
  }
  else{
    jQuery('#sideBar').hover(function(){
        jQuery('body').addClass('opensidebar');
        jQuery('.input-group-btnbtnmargin').addClass('input-group-btnmargin');
        //$("#dvLeftcontentdetail").height($('#dvRightContent').height());
    });
  }

  var timer = 0;
  var timer1 = 0;
  jQuery(document).mousemove(function () {
      if (timer1) {
          clearTimeout(timer1);
          timer1 = 0;

      }
    if (timer) {
        clearTimeout(timer);
      timer = 0;
      
    }
   
    timer = setTimeout(function () {
        jQuery('body').removeClass('opensidebar');
        jQuery('.input-group-btnbtnmargin').removeClass('input-group-btnmargin');
        jQuery('#sideBar .panel-collapse').removeClass('in').addClass('collapse').animate({ 'height': '0' });
       
    }, 15000);
    //timer1 = setTimeout(function () {        
    //    $("#dvLeftcontentdetail").height($('#dvRightContent').height());
    //}, 1000);
   
  });
 
});

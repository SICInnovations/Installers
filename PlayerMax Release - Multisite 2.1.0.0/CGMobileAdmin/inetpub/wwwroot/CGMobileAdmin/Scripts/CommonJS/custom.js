$(document).ready(function () {
    
   
        $("#dvLeftcontentdetail").height($('#dvRightContent').height());
 
  //  Award Builder Link
  $("#awardBuilderLink").click(function() {
      $('.preloaderNew').show();
      $('.preloaderNew').fadeOut(1000, function () {
      $("#awardBuilderLink").siblings().removeClass('active');
      $("#awardBuilderLink").addClass('active');
      $(".rightBar").load("awardBuilder.aspx");
    });
  });

//  Poker Bad Beat Jackpot Link
  $("#jackpotLink").click(function() {
      $('.preloaderNew').show();
      $('.preloaderNew').fadeOut(1000, function () {
      $("#jackpotLink").siblings().removeClass('active');
      $("#jackpotLink").addClass('active');
      $(".rightBar").load("PokerBadBeatJackpot.aspx");
    });
  });

//  Slot Inventory Link
  $("#slotInventoryLink").click(function() {
      $('.preloaderNew').show();
      $('.preloaderNew').fadeOut(1000, function () {
      $("#slotInventoryLink").siblings().removeClass('active');
      $("#slotInventoryLink").addClass('active');
      $(".rightBar").load("slotInventory.aspx");
    });
  });

//  Manage Content Link
  $("#manageContentLink").click(function() {
      $('.preloaderNew').show();
      $('.preloaderNew').fadeOut(1000, function () {
      $("#manageContentLink").siblings().removeClass('active');
      $("#manageContentLink").addClass('active');
      $(".rightBar").load("manageContent.aspx");
    });
  });

//  Tournament Builder Link

  $("#tournamentBuilderLink").click(function() {
      $('.preloaderNew').show();
      $('.preloaderNew').fadeOut(1000, function () {
      $("#tournamentBuilderLink").siblings().removeClass('active');
      $("#tournamentBuilderLink").addClass('active');
      $(".rightBar").load("tournamentBuilder.aspx");
    });
  });

//  adPression Management Link
  $("#pressionLink").click(function() {
      $('.preloaderNew').show();
      $('.preloaderNew').fadeOut(1000, function () {
      $("#pressionLink").siblings().removeClass('active');
      $("#pressionLink").addClass('active');
      $(".rightBar").load("adPressionManagement.aspx");
    });
  });

  //  Refer a Friend Link
  $("#referFriendLink").click(function() {
      $('.preloaderNew').show();
      $('.preloaderNew').fadeOut(1000, function () {
      $("#referFriendLink").siblings().removeClass('active');
      $("#referFriendLink").addClass('active');
      $(".rightBar").load("referFriend.aspx");
    });
  });

  //  Map Management Link
  $("#mapManagementLink").click(function() {
      $('.preloaderNew').show();
      $('.preloaderNew').fadeOut(1000, function () {
      $("#mapManagementLink").siblings().removeClass('active');
      $("#mapManagementLink").addClass('active');
      $(".rightBar").load("mapManagement.aspx");
    });
  });





    //  Inactive Fieldset
  //var fieldSwitch = $('.fieldSwitch');
  //var legendSwitch = $('.fieldset legend input');
  //  //fieldSwitch.find('input, select').prop('disabled', true);
  ////$('.input-group-addon').parent().removeClass('dis');
  //legendSwitch.on('click', function () {
  //    if ($(this).is(':checked')) {
  //        $(this).parent().next('.fieldSwitch').find('input, select').prop('disabled', true);
  //        //$('.input-group-addon').parent().addClass('dis');
  //    }
  //    else {
  //        $(this).parent().next('.fieldSwitch').find('input, select').prop('disabled', false);
  //        //$('.input-group-addon').parent().removeClass('dis');
  //    }
    //});
  
  
  $('.dhtmlgoodies_tree ul li').click(function () {
      $('.dhtmlgoodies_tree ul li').removeClass('active');
      $(this).addClass('active');
      //stopPropagation();
  });

});



//page loader
$(window).load(function () {
  $('.preloaderNew').fadeOut(2000);
});


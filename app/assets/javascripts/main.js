$(function(){
  $('.project-toggle').on('switch-change', function (e, data) {
    var url = $(data.el).attr('dashbozu-url');
    $.post(url, {state: data['value']}).fail(function(){
      $(e.target).bootstrapSwitch('setState', false);
    });
  });
});

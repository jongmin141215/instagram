$(function() {
  $.ajaxSetup({
    headers: {
      'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    }
  });
  $('.comment_form').hide();
  $('.glyphicon-save').hide();
  $('.comment').on('click', function(event) {
    var $commentButton = $(this);
    console.log('hihi')
    $(this).parents('.panel-footer').find('.comment_form').show()
    // $commentButton.parents('.panel-footer').children('.comment_div').children().show();
    $commentButton.hide();


    $('.glyphicon-save').show();
  });

  $('.glyphicon-save').on('click', function(event) {
    var $saveButton = $(this);
    event.preventDefault();
    var $url = $(this).attr('href');
    $.ajax({
      url: $url,
      method: 'POST',
      data: {"comment": {"content": $saveButton.next().children('input[type="textarea"]').val()}},
      dataType: "json"
    }).done(function(data) {
      $saveButton.parent().parent().append('<p>' + data.comment + '</p>')
    })
    $('.comment_form').hide();
    $('.comment').show();
    $('.glyphicon-save').hide();
  });

});

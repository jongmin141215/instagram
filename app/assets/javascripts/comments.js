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
    $(this).parents('.panel-footer').find('.comment_form').show();
    $commentButton.hide();
    $commentButton.parents('.panel-footer').find('.glyphicon-save').show();
  });

  $('.glyphicon-save').on('click', function(event) {
    var $saveButton = $(this);
    event.preventDefault();
    var $url = $(this).attr('name');
    $.ajax({
      url: $url,
      method: 'POST',
      data: {"comment": {"content": $saveButton.next().children('input[type="textarea"]').val()}},
      dataType: "json"
    }).done(function(data) {
      $saveButton.parent().siblings('ul.comments').append('<li class="each_comment"><a href="/users/' + data.userid + '/pictures">'+ data.username + ': </a>' + data.comment + '</li>');
      $saveButton.parent().siblings('ul.comments').append(' <button class="remove glyphicon glyphicon-remove" name="' + data.delete_path  + '"></button>');
    })
    $('.comment_form').hide();
    $('.comment').show();
    $('.glyphicon-save').hide();
  });

  $(document).on('click', '.remove', function(event) {
    var $removeButton = $(this);
    event.preventDefault();
    var url = $removeButton.attr('name');
    $.ajax({
      url: url,
      method: 'DELETE',
      data: {}
    }).done(function() {
      $removeButton.prev('.each_comment').remove();
      $removeButton.remove();
    })
  })
});

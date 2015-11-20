$(function() {
  $.ajaxSetup({
    headers: {
      'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    }
  });
  $('.edit_description').hide();
  $('.edit').on('click', function(event) {
    event.preventDefault();
    $(this).parent().hide();
    $(this).parent().siblings('.edit_description').show();
  });

  $('.save').on('click', function(event) {
    var $saveButton = $(this);
    event.preventDefault();
    var $url = $(this).parent('form').attr('action');
    $.ajax({
      url: $url,
      method: 'PUT',
      data: {"picture": {"description": $(this).prev().val()}},
      dataType: "json"
    }).done(function(data) {
      $saveButton.parents('.edit_description').parents('.panel-footer').find('span.description').text(data.description)
    })
    $saveButton.parents('.edit_description').hide();
    $saveButton.parents('.edit_description').siblings('.icons').show();
  });

  $('.delete').on('click', function(event) {
    event.preventDefault();
    var $deleteButton = $(this);
    var $url = $(this).attr('name');
    console.log($url);
    $.ajax({
      url: $url,
      method: 'DELETE',
      data: {}
    }).done(function() {
      $deleteButton.parents('.panel').remove();
    })
  })

});

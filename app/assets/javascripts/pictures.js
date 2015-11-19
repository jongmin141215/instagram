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
    $(this).parent().next().show();
  })

  $('.save').on('click', function(event) {
    var $saveButton = $(this);
    event.preventDefault();
    var $url = $(this).parent('form').attr('action');
    $.ajax({
      url: $url,
      method: 'PUT',
      data: {description: $(this).prev().val()},
      dataType: "json"
    }).done(function(data) {
      $saveButton.parent().parent().prev().children('span.description').text(data.description)
    })
    $saveButton.parent().parent().hide();
    $saveButton.parent().parent().prev().show();
  })
})

$(function() {
  $('.glyphicon-thumbs-up').on('click', function(event) {
    $likeButton = $(this);
    event.preventDefault();
    $url = $(this).attr('name')
    $.ajax({
      url: $url,
      method: 'POST',
      data: {}
    }).done(function(data) {
      $likeButton.children('.like_count').text(data.count);
    })
  })
})

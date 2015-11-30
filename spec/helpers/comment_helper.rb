module CommentHelper
  def leave_comment(comment)
    find('.comment').click
    fill_in 'comment[content]', with: comment
    find('.glyphicon-save').click
  end
end

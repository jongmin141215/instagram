module SearchHelper
  def search(term)
    visit root_path
    fill_in 'user-search-txt', with: term
    page.execute_script %Q{ $('#user-search-txt').trigger("keydown")}
  end
end

def full_title page_title
  base_title = "22 Street"
  if page_title.empty?
    base_title
  else
    "#{base_title} | #{page_title}"
  end
end

def sign_in user
  visit signin_path
  fill_in "email",    with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
end

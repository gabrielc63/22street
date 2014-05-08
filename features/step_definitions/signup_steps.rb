Given(/^a user visits the signup page$/) do
  visit signup_path
end

When(/^they submit invalid signup information$/) do
  click_button "Sign up"
end

Then(/^they should see an error message$/) do
  expect(page).to have_selector('div.alert.alert-error')
end

When(/^the user submits valid signup information$/) do
  fill_in "Email",    with: @user.email
  fill_in "Password", with: @user.password
  click_button "Sign up"
end

Then(/^they should see their profile page$/) do
  expect(page).to have_title(@user.name)
end

Then(/^they should see a signout link$/) do
  expect(page).to have_link('Sign out', href: signout_path)
end

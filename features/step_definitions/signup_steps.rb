Given(/^I am on the signup page$/) do
  visit signup_path
end

When(/^I submit invalid signup information$/) do
  click_button "Create my account"
end

Then(/^I should see an error message$/) do
  expect(page).to have_content('error')
end

Given(/^I visit the signup page$/) do
  visit signup_path
end

When(/^I submit valid signup information$/) do
  fill_in "Name",         with: "Jhon Doe"
  fill_in "Username",     with: "jhond"
  fill_in "Email",        with: "jhon_d@myemail.com"
  fill_in "Password",     with: "asdasd"
  fill_in "Confirmation", with: "asdasd"
  attach_file "user_avatar", 'app/assets/images/ruby.png'
  click_button "Create my account"
end

Then(/^I should see my profile page$/) do
  page.should have_title("Jhon Doe")
end

Then(/^I should see a success message$/) do
  expect(page).to have_selector('div.alert.alert-success')
end

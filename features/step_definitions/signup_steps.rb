Given(/^a user visits the signup page$/) do
  visit signup_path
end

When(/^they submit invalid signup information$/) do
  click_button "Create my account"
end

Then(/^they should see an error message$/) do
  expect(page).to have_selector('div.alert')
end

When(/^the user submits valid signup information$/) do
  fill_in "Email",    with: "Jhon Doe"
  fill_in "Password", with: "asdasd"
  fill_in "Username", with: "jhon_d@myemail.com"
  fill_in "Name",     with: "jhon"
  click_button "Create my account"
end

Then(/^they should see their profile page$/) do
  expect(page).to have_title(@user.name)
end

Then(/^they should see a signout link$/) do
  expect(page).to have_link('Sign out', href: signout_path)
end

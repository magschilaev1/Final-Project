Given(/^there is a showcased user$/) do
  @showcase_user = User.create!(name: 'Pussy Galore', email: 'test@test.com', github_username: 'Geoff', uid: '2', provider: 'google')
end

When(/^I visit the user profile page$/) do
	visit '/user/fred'
  expect(page).to have_content('Profile')
end

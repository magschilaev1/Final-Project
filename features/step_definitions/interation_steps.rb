When(/^I click "(.*?)"$/) do |button|
  click_link button
end

Then(/^I press "(.*?)"$/) do |button|
  click_button button
end

Then(/^I fill in the following for the "([^\"]+)"$/) do |object, table|
  table.rows_hash.each do |name, value|
    fill_in "#{object}_#{name}", with: value
  end
end

Given(/^I choose "(.*?)" from "(.*?)"$/) do |option, select_box|
  select(option, :from => select_box)
end

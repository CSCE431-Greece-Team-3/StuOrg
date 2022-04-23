require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

module WithinHelpers
    def with_scope(locator)
        locator ? within(locator) { yield } : yield
    end
end
World(WithinHelpers)

Given /^(?:|I )am on (.+)$/ do |page_name|
    visit path_to(page_name)
end

When /^I press the "([^\"]*)" link$/ do |link|
    click_link(link)
end

When /^I press the "([^\"]*)" button$/ do |button|
    click_button(button)
end

Then /^(?:|I )should be on (.+)$/ do |page_name|
    visit path_to(page_name)
end

And /^(?:|I )should see "([^\"]*)"$/ do |button__text|
    page.should have_content(button__text)
end

Then /^I sign up with "(.*?)" username and "(.*?)" password$/ do |user, password|
    # find("#user_username").set(user_name)
    fill_in('user_username', with: user)
    fill_in('user_password', with: password)
    click_button("CREATE ACCCOUNT")
end

When /^I will sign up with "(.*?)" organization name, "(.*?)" username, and "(.*?)" password$/ do |organization_name, user, password|
    fill_in('user_first', with: organization_name)
    fill_in('user_username', with: user)
    fill_in('user_password', with: password)
    click_button("login-submit")
    # find("#user_username").set(user_name)
    
    
end

And /^I will sign up with "(.*?)" "(.*?)", "(.*?)" username, and "(.*?)" password$/ do |first_name, last_name, user, password|
    fill_in('member_first', with: first_name)
    fill_in('member_last', with: last_name)
    fill_in('member_username', with: user)
    fill_in('member_password', with: password)
    click_button("login-submit")
end

Then /^I log in with "(.*?)" username and "(.*?)" password$/ do |user, password|
    # find("#user_username").set(user_name)
    fill_in('session_username', with: user)
    fill_in('session_password', with: password)
    click_button("login-submit")
end

And(/^I attach the file "(.*?)" to "(.*?)"$/) do |field, file|
    page.attach_file(file, File.join(Rails.root, field))
end

When /^(?:|I )fill in "([^\"]*)" with "([^\"]*)"$/ do |field, text|
    fill_in(field, with: text)
end

When /^I select checkbox "(.*?)"$/ do |cb|
    check(cb)
end

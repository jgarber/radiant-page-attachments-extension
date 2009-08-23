require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

Given /^I am logged in as (.*)(?: user)?$/ do |username|
  visit login_path
  fill_in "Username", :with => username
  fill_in "Password",  :with => "password"
  click_button "Login"
end

Given /^I have a page$/ do
  @page = pages(:home)
end

Given /^I have a page with no attachments$/ do
  Given "I have a page"
  @page.attachments.destroy_all
  @page.reload.attachments.should be_empty
end

When /^I edit the page$/ do
  visit edit_admin_page_path(@page)
end

When /^I attach the Rails logo$/ do
  attach_file "file_input", "#{PageAttachmentsExtension.root}/spec/fixtures/rails.png", "image/png" 
end

When /^I save$/ do
  click_button "Save"
end

Then /^the page should have a new attachment$/ do
  @page.reload.attachments.should_not be_empty
end

Feature: add attachment
  As a content editor
  I should be able to add an attachment
  In order to upload a file to the page
  
  Background:
    Given I am logged in as admin
  
  Scenario: attach new file
    Given I have a page with no attachments
    When I edit the page
    And I attach the Rails logo
    And I save
    Then the page should have a new attachment 
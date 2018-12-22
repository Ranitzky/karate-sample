#Author: Rico Wilcke
Feature: Basic API Call

  Background: 
    * def endpoint = 'https://tbec-mock-advertiser-qa.dus.tcs.trivago.cloud'

  @request
  Scenario: I can make a availability request
    Given url endpoint
    And path '/api/v1/booking_availability'
    And header Authorization = 'Basic cWE6Y2FzZV9zdHVkeQ=='
    And request __arg
    When method post
    Then status 200
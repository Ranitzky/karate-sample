#Author: Rico Wilcke
Feature: Handling dates 

  Background: 
    * def endpoint = 'https://tbec-mock-advertiser-qa.dus.tcs.trivago.cloud'

  @date
  Scenario Outline: I verify, that the start date is before the end date
    * def body =
      """
      {
        api_version: 1,
      	hotel: {
          item_id: 5002,
          partner_reference: '5002'
        },
        start_date: '<startDate>',
        end_date: '<endDate>',
        party: [{
          adults: 2,
          children: [1]
        }],
        lang:'en_US',
        currency:'USD',
        user_country:'US'
      }
      """
    Given url endpoint
    And path '/api/v1/booking_availability'
    And header Authorization = 'Basic cWE6Y2FzZV9zdHVkeQ=='
    And request body
    When method post
    Then status 200
    And def startDate = response.start_date
    And def endDate = response.end_date
    And match startDate == '<startDate>'
    And match endDate == '<endDate>'
    * def a = new Date(startDate)
    * def b = new Date(endDate)
    * def result = a.getTime() < b.getTime()
    And match result == <expectedResult>

    Examples: 
      | startDate  | endDate    | expectedResult |
      | 2019-01-21 | 2019-01-23 | true           |
      | 2019-09-21 | 2019-08-23 | false          |
#Author: Rico Wilcke
Feature: Receiving rates

  Background: 
    * def endpoint = 'https://tbec-mock-advertiser-qa.dus.tcs.trivago.cloud'

  @rates
  Scenario Outline: I get rates for 3 short term stays
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
    * def rates = response.room_types_array.length
    And assert rates >= 1
  
  Examples: 
      | startDate  | endDate    |
      | 2019-01-21 | 2019-01-23 |
      | 2019-09-30 | 2019-10-02 |
      | 2019-12-31 | 2020-01-02 |

  @rates
  Scenario Outline: I get rates for 3 long term stays
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
    * def rates = response.room_types_array.length
    And assert rates >= 1
  
  Examples: 
      | startDate  | endDate    |
      | 2019-01-21 | 2019-02-23 |
      | 2019-09-30 | 2020-01-01 |
      | 2019-12-31 | 2020-06-30 |
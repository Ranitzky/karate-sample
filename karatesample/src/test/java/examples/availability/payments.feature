#Author: Rico Wilcke
Feature: Payments

  Background: 
    * def endpoint = 'https://tbec-mock-advertiser-qa.dus.tcs.trivago.cloud'

  @payment
  Scenario Outline: I get the correct payments for each item
    * def body =
      """
      {
        api_version: 1,
      	hotel: {
          item_id: <item>,
          partner_reference: '5002'
        },
        start_date: '2019-01-01',
        end_date: '2019-01-02',
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
    * def payment = response.room_types_array[0].payment_methods
    * match payment == '#array'
    * match response.room_types_array[0].payment_methods[0].options[*].code contains '<type>'

    Examples: 
      | item | type            |
      | 5001 | AmericanExpress |
      | 5002 | AmericanExpress |
      | 5003 | AmericanExpress |
      | 5004 | AmericanExpress |
      | 5008 | AmericanExpress |
      | 5008 | Discover        |
      | 5008 | JCB             |

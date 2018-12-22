#Author: Rico Wilcke
Feature: Customer support information

  Background: 
    * def endpoint = 'https://tbec-mock-advertiser-qa.dus.tcs.trivago.cloud'
    * def body =
      """
      {
        api_version: 1,
      	hotel: {
          item_id: 5002,
          partner_reference: '5002'
        },
        start_date: '2019-01-21',
        end_date: '2019-01-23',
        party: [{
          adults: 2,
          children: [1]
        }],
        lang:'en_US',
        currency:'USD',
        user_country:'US'
      }
      """

  @customer
  Scenario: I get valid customer support information on successful request
    Given url endpoint
    And path '/api/v1/booking_availability'
    And header Authorization = 'Basic cWE6Y2FzZV9zdHVkeQ=='
    And request body
    When method post
    Then status 200
    #
    # save details from response
    * def customer_support = response.customer_support
    #
    # validate response
    * match customer_support == '#object'
    * match customer_support.phone_numbers == '#array'
    * match each customer_support.phone_numbers contains {contact: '#notnull' }
    * match customer_support.emails == '#array'
    * match each customer_support.emails contains {contact: '#notnull' }
    * match customer_support.urls == '#array'
    * match each customer_support.urls contains {contact: '#notnull' }

  @customer
  Scenario: I get valid customer support information on faulty request
    Given url endpoint
    And path '/api/v1/booking_availability'
    And header Authorization = 'Basic cWE6Y2FzZV9zdHVkeQ=='
    And request ''
    When method post
    Then status 200
    #
    # save details from response
    * def customer_support = response.customer_support
    #
    # validate response
    * match customer_support == '#object'
    * match customer_support.phone_numbers == '#array'
    * match each customer_support.phone_numbers contains {contact: '#notnull' }
    * match customer_support.emails == '#array'
    * match each customer_support.emails contains {contact: '#notnull' }
    * match customer_support.urls == '#array'
    * match each customer_support.urls contains {contact: '#notnull' }

Feature: Availability Demo Call for Self Connect

  Background: 
    * def endpoint = 'https://tbec-mock-advertiser-qa.dus.tcs.trivago.cloud'

  Scenario: Get available rates for item
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
    Given url endpoint
    And path '/api/v1/booking_availability'
    And header Authorization = 'Basic cWE6Y2FzZV9zdHVkeQ=='
    And request body
    When method post
    Then status 200
    * def hotel_name = response.hotel_details.name
    * def hotel_address1 = response.hotel_details.address1
    * print 'Hotel Name is: ' + hotel_name
    * print 'Hotel Address is: ' + hotel_address1

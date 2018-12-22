Feature: Availability Call for Self Connect

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

  Scenario: I get valid hotel information from the advertiser
    Given url endpoint
    And path '/api/v1/booking_availability'
    And header Authorization = 'Basic cWE6Y2FzZV9zdHVkeQ=='
    And request body
    When method post
    Then status 200
    #
    # save details from response
    * def hotel_details = response.hotel_details
    * def hotel_name = hotel_details.name
    * def hotel_address1 = hotel_details.address1
    * def hotel_address2 = hotel_details.address2
    * def hotel_city = hotel_details.city
    * def hotel_state = hotel_details.state
    * def hotel_postal_code = hotel_details.postal_code
    * def hotel_country = hotel_details.country
    #
    # validate response
    * match hotel_name == '#regex (\?:[a-zA-Z]{2,15} \?\\b){2,3}'
    * match hotel_address1 == '#ignore'
    * match hotel_address2 == '#ignore'
    * match hotel_city == '#regex (\?:[a-zA-Z]{2,15} \?\\b){2,3}'
    * match hotel_state == '#regex [A-Z]{2,4}'
    * match hotel_postal_code == '#regex [0-9]{4,6}'
    * match hotel_country == '#regex [A-Z]{3}'
    #
    # Print address to console
    * print 'The hotel: ' + hotel_name
    * print 'is located in: '
    * print hotel_address1
    * print hotel_address2
    * print hotel_country + ' - ' + hotel_postal_code, hotel_city

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

  Scenario: I receive rates for the requested parameters

  Scenario: I verify, that the start date is before the end date
    Given url endpoint
    And path '/api/v1/booking_availability'
    And header Authorization = 'Basic cWE6Y2FzZV9zdHVkeQ=='
    And request body
    When method post
    Then status 200
    And def startDate = response.start_date
    And def endDate = response.end_date
    And match startDate == '2019-01-21'
    And match endDate == '2019-01-23'
    * def a = new Date(startDate)
		* def b = new Date(endDate)
		* def result = a.getTime() < b.getTime()
 		And match result == true

#  Scenario: I verify, that I receive an error, when end date is prior start date

#  Scenario: I get rates for 3 short term stays

#  Scenario: I get rates for 3 long term stays

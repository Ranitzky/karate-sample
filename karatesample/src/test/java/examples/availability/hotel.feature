#Author: Rico Wilcke
Feature: Hotel information

  @hotel
  Scenario: I get valid hotel information from the advertiser
		
		* json myReq = read('classpath:examples/availability/payload.json')
    * call read('classpath:examples/availability/request.feature') myReq
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
    * match hotel_postal_code == '#ignore'
    * match hotel_country == '#regex [A-Z]{3}'
    #
    # Print address to console
    * print 'The hotel: ' + hotel_name
    * print 'is located in: '
    * print hotel_address1
    * print hotel_address2
    * print hotel_country + ' - ' + hotel_postal_code, hotel_city

  
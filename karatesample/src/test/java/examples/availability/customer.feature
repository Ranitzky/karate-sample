#Author: Rico Wilcke
Feature: Customer support information

  @customer
  Scenario: I get valid customer support information on successful request

		* json myReq = read('classpath:examples/availability/payload.json')
    * call read('classpath:examples/availability/request.feature') myReq
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
  
		* json myReq = read('classpath:examples/availability/empty.json')
    * call read('classpath:examples/availability/request.feature') myReq
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

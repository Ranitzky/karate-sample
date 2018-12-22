#Author: Rico Wilcke
Feature: Payments

  Background: 
    * def endpoint = 'https://tbec-mock-advertiser-qa.dus.tcs.trivago.cloud'

  @payment
  Scenario Outline: I get the correct payments for each item
    * json myReq = read('classpath:examples/availability/request.json')
    * call read('classpath:examples/availability/request.feature') myReq
    * replace myReq
      | token   | value  |
      | ${item} | <item> |
    * match response.room_types_array[0].payment_methods == '#array'
    * match response.room_types_array[0].payment_methods[0].options == '#array'
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

#Author: Rico Wilcke
Feature: Receiving rates

  @rates
  Scenario Outline: I get rates for 3 short term stays
  	* json myReq = read('classpath:examples/availability/payload.json')
  	* set myReq $.start_date = "<startDate>"
  	* set myReq $.end_date = "<endDate>"
    * call read('classpath:examples/availability/request.feature') myReq
    * def rates = response.room_types_array.length
    And assert rates >= 1
  
  Examples: 
      | startDate  | endDate    |
      | 2019-01-21 | 2019-01-23 |
      | 2019-09-30 | 2019-10-02 |
      | 2019-12-31 | 2020-01-02 |

  @rates
  Scenario Outline: I get rates for 3 long term stays
  	* json myReq = read('classpath:examples/availability/payload.json')
  	* set myReq $.start_date = "<startDate>"
  	* set myReq $.end_date = "<endDate>"
    * call read('classpath:examples/availability/request.feature') myReq
    * def rates = response.room_types_array.length
    And assert rates >= 1
  
  Examples: 
      | startDate  | endDate    |
      | 2019-01-21 | 2019-02-23 |
      | 2019-09-30 | 2020-01-01 |
      | 2019-12-31 | 2020-06-30 |
#Author: Rico Wilcke
Feature: Handling dates 

  @date
  Scenario Outline: I verify, that the start date is before the end date
  	* json myReq = read('classpath:examples/availability/payload.json')
  	* set myReq $.start_date = "<startDate>"
  	* set myReq $.end_date = "<endDate>"
    * call read('classpath:examples/availability/request.feature') myReq
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
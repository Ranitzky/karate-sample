# karate-sample

## How to run

Build the docker image

```
docker build -t karate_sample .
```
and run it
```
docker run karate_sample
```

## Basic request, Payload and Re-Useability

### Import existing payload and calling other feature file

For re-useability the standard payload was saved as `payload.json` and the basic request as `request.feature`.
Import those two files, to reuse them.

```
    Scenario: I get valid hotel information from the advertiser
      * json myReq = read('classpath:examples/availability/payload.json')
      * call read('classpath:examples/availability/request.feature') myReq
```
_See a complete test: "Feature: Hotel information" (hotel.feature)._

### Modifying the payload before sending the request

Use `set` to change values from pre-defined payload.

```
    Scenario Outline: I request several items
      * json myReq = read('classpath:examples/availability/payload.json')
      * set myReq $.hotel.item_id = <item>
      * call read('classpath:examples/availability/request.feature') myReq

    Examples: 
      | item |
      | 5001 |
      | 5002 |
```      
_See a complete test: "Feature: Payments" (payments.feature)._
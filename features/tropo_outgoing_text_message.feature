Feature: Tropo Outgoing Text Message
  In order to send outgoing text messages
  I want to generate a JSON response for Tropo

  Scenario: An outgoing text message is received

    When a tropo_message is received with:
    """
    {
      "session":{
        "id":"00ed5ddc8d53c9a787b8d1b789f22f0a",
        "accountId":"12345",
        "timestamp":"2010-10-09T11:49:59.586Z",
        "userType":"NONE",
        "initialText":null,
        "callId":"1dff54394c5987ef5ba0961a35409d26",
        "parameters":{
          "msg":"yo",
          "to":"4075551212"
         }
      }
    }
    """

    Then the response should be:
    """
    {
      "tropo":[{
        "message":{
          "to":"4075551212",
          "channel":"TEXT",
          "network":"SMS",
          "say":[{
            "value":"yo"
          }]
        }
      }]
    }
    """


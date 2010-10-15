Feature: Tropo Outgoing Text Message
  In order to send outgoing text messages
  I want to generate a JSON response for Tropo

  Scenario: An outgoing text message is received

    When a tropo_message is received with:
    """
    {
      "session":{
        "id":"606c5f32c46dd3a7ae07c95ee68f8b79",
        "accountId":"12345",
        "timestamp":"2010-10-15T02:08:19.986Z",
        "userType":"NONE",
        "initialText":null,
        "callId":null,
        "parameters":{
          "text":"Hi%2C+please+verify+your+number+by+replying+with%3A+mn+v+%3Cyour+name%3E",
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
            "value":"Hi%2C+please+verify+your+number+by+replying+with%3A+mn+v+%3Cyour+name%3E"
          }]
        }
      }]
    }
    """


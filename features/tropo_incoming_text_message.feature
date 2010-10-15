Feature: Tropo Incoming Text Message
  In order to allow the main application to briefly go offline for maintenance
  I want to forward all incoming text messages from Tropo to the remote application as POST requests as standard form NVP data and save them for resubmission if the remote application is offline

  Scenario Outline: An incoming text message is received from Tropo
    Given the remote application is <up_or_down>

    When a tropo_message is received with query string: "tropo[authentication_key]=abc", body:
    """
    {
      "session":{
        "id":"fe9713e2658f5153911e077d795fabf8",
        "accountId":"12345",
        "timestamp":"2010-10-09T11:49:59.586Z",
        "userType":"HUMAN",
        "initialText":"What?",
        "callId":"1dff54394c5987ef5ba0961a35409d26",
        "to":{
          "id":"133123456789",
          "name":"unknown",
          "channel":"TEXT",
          "network":"SMS"
         },
        "from":{
          "id":"841234567890",
          "name":"unknown",
          "channel":"TEXT",
          "network":"SMS"
        },
        "headers":{
          "Max-Forwards":"70",
          "Content-Length":"124",
          "Contact":"<sip:10.6.93.101:5066;transport=udp>",
          "To":"<sip:9991454582@10.6.69.204:5061;to=13314314191>",
          "CSeq":"1 INVITE",
          "Via":"SIP/2.0/UDP 10.6.93.101:5066;branch=z9hG4bK2ztqtu",
          "Call-ID":"arfdz6",
          "Content-Type":"application/sdp",
          "From":"<sip:64EB6BAC-99DF-44C2-871DFBA75C319776@10.6.61.201;channel=private;user=841232894112;msg=What%3f;network=SMS;step=1>;tag=le9j4s"
        }
      }
    }
    """

    Then a POST request should have been made to the remote application to create a new incoming_text_message containing:
    """
    {
      'incoming_text_message' => {
        'session' => {
          'id' => 'fe9713e2658f5153911e077d795fabf8',
          'account_id' => '12345',
          'timestamp' => '2010-10-09 11:49:59 UTC',
          'user_type' => 'HUMAN',
          'initial_text' => 'What?',
          'call_id' => '1dff54394c5987ef5ba0961a35409d26',
          'to' => {
            'id' => '133123456789',
            'name' => 'unknown',
            'channel' => 'TEXT',
            'network' => 'SMS'
           },
          'from' => {
            'id' => '841234567890',
            'name' => 'unknown',
            'channel' => 'TEXT',
            'network' => 'SMS'
          },
          'headers' => {
            '_max-_forwards' => '70',
            '_content-_length' => '124',
            '_contact' => '<sip:10.6.93.101:5066;transport=udp>',
            '_to' => '<sip:9991454582@10.6.69.204:5061;to=13314314191>',
            '_c_seq' => '1 INVITE',
            '_via' => 'SIP/2.0/UDP 10.6.93.101:5066;branch=z9hG4bK2ztqtu',
            '_call-_i_d' => 'arfdz6',
            '_content-_type' => 'application/sdp',
            '_from' => '<sip:64EB6BAC-99DF-44C2-871DFBA75C319776@10.6.61.201;channel=private;user=841232894112;msg=What%3f;network=SMS;step=1>;tag=le9j4s'
          }
        },
        'authentication_key' => 'abc'
      }
    }
    """
    And a tropo_incoming_text_message <should_should_not> exist

    Examples:
      | up_or_down        | should_should_not |
      | up                | should not        |
      | down              | should            |

  Scenario: The resource url is hit without a payload
    When a tropo_message is received with:
    """
    """

    Then a tropo_incoming_text_message should not exist

  Scenario: The resource url is hit with a query string but without a payload
    When a tropo_message is received with query string: "hello=yes", body:
    """
    """

    Then a tropo_incoming_text_message should not exist

  Scenario: The resource url is hit with an invalid payload
    When a tropo_message is received with:
    """
    hello:yes:goodbye
    """

    Then a tropo_incoming_text_message should not exist


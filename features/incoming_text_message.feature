Feature: Incoming Text Message
  In order to allow the main application to briefly go offline for maintenance and to keep the remote application RESTful
  I want to forward all incoming text messages to the remote application as POST requests and save them for resubmission if the remote application is offline

  Scenario Outline: An incoming text message is received
    Given the remote application is <up_or_down>

    When an incoming_text_message is received with:
    """
    {
      'to'=>'61447100308',
      'from'=>'668123456789',
      'msg'=>'Edin knif lie km',
      'userfield'=>'123456',
      'date'=>'2010-05-13 23:59:58'
    }
    """

    Then a POST request should have been made to the remote application to create a new incoming_text_message containing:
    """
    {
      'incoming_text_message' => {
        'to'=>'61447100308',
        'from'=>'668123456789',
        'msg'=>'Edin knif lie km',
        'userfield'=>'123456',
        'date'=>'2010-05-13 23:59:58'
      }
    }
    """
    And an incoming_text_message <should_should_not> exist

    Examples:
      | up_or_down        | should_should_not |
      | up                | should not        |
      | down              | should            |


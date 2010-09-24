Feature: Text Message Delivery Receipt
  In order to allow the main application to briefly go offline for maintenance and to keep the remote application RESTful
  I want to forward all text message delivery receipts as POST requests and save them for resubmission if the remote application is offline

  Scenario Outline: A text message delivery receipt is received
    Given the remote application is <up_or_down>

    When a text_message_delivery_receipt is received with:
    """
    {
      'msgid'=>'6942744494999745',
      'dlrstatus'=>'DELIVRD',
      'dlr_err'=>'000',
      'donedate'=>'1005132312'
    }
    """

    Then a POST request should have been made to the remote application to create a new text_message_delivery_receipt containing:
    """
    {
      'text_message_delivery_receipt' => {
        'msgid'=>'6942744494999745',
        'dlrstatus'=>'DELIVRD',
        'dlr_err'=>'000',
        'donedate'=>'1005132312'
      }
    }
    """
    And a text_message_delivery_receipt <should_should_not> exist

    Examples:
      | up_or_down        | should_should_not |
      | up                | should not        |
      | down              | should            |


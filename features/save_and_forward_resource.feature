Feature: Save and forward resource
  In order to allow the main application to briefly go offline for maintenance and to keep the remote application RESTful
  I want to forward all incoming resources to the remote application as POST requests and save them for resubmission if the remote application is offline

  Scenario Outline: A resource is received and the remote application is up
    Given the remote application is up

    When a <resource> is received with: "<params>"

    Then a POST request should have been made to the remote application to create a new <resource> containing: "{'<resource>' => <params>}"
    And a <resource> should not exist

    Examples:
    | resource                      | params                                     |
    | incoming_text_message         | {'to'=>'61447100308', 'from'=>'66814822967', 'msg'=>'Edin knif lie km', 'userfield'=>'123456', 'date'=>'2010-05-13 23:59:58'} |
    | text_message_delivery_receipt | {'msgid'=>'6942744494999745', 'dlrstatus'=>'DELIVRD', 'dlr_err'=>'000', 'donedate'=>'1005132312'}              |
    | paypal_ipn                    | {'mc_gross'=>'54.00', 'protection_eligibility'=>'Eligible', 'for_auction'=>'true', 'address_status'=>'confirmed', 'item_number1'=>'12345790063', 'payer_id'=>'T23XXY2DVKA6J', 'tax'=>'0.00', 'address_street'=>'address', 'payment_date'=>'08:30:40 May 06, 2010 PDT', 'payment_status'=>'Completed', 'charset'=>'windows-1252', 'auction_closing_date'=>'08:27:08 Jun 05, 2010 PDT', 'address_zip'=>'98102', 'first_name'=>'Test', 'auction_buyer_id'=>'testuser_mehbuyer', 'mc_fee'=>'2.41', 'address_country_code'=>'US', 'address_name'=>'Test User', 'notify_version'=>'2.9', 'custom'=>'', 'payer_status'=>'verified', 'business'=>'seller@example.com', 'num_cart_items'=>'1', 'address_country'=>'United States', 'address_city'=>'city', 'quantity'=>'1', 'verify_sign'=>'Aa4P7UnWW85EE9W0YVKVAc7z1v8OAkejFXqE2AlDChXtbvZRHTHaiH4C', 'payer_email'=>'mehbuy_1272942317_per@gmail.com', 'txn_id'=>'45D21472YD1820048', 'payment_type'=>'instant', 'last_name'=>'User', 'item_name1'=>'Yet another piece of mank', 'address_state'=>'WA', 'receiver_email'=>'seller@example.com', 'payment_fee'=>'2.41', 'quantity1'=>'1', 'insurance_amount'=>'0.00', 'receiver_id'=>'8AYM8ZN48AARJ', 'txn_type'=>'web_accept', 'item_name'=>'Yet another piece of mank', 'mc_currency'=>'USD', 'item_number'=>'12345790063', 'residence_country'=>'AU', 'test_ipn'=>'1', 'transaction_subject'=>'Yet another piece of mank', 'payment_gross'=>'54.00', 'shipping'=>'20.00'}                   |

  Scenario Outline: An incoming text message delivery receipt is received but the remote application is down
    Given the remote application is down

    When a <resource> is received with: "<params>"

    Then a POST request should have been made to the remote application to create a new <resource> containing: "{'<resource>' => <params>}"
    And a <resource> should exist with params: "<params>"

    Examples:
    | resource                      | params                                     |
    | incoming_text_message         | {'to'=>'61447100308', 'from'=>'66814822967', 'msg'=>'Edin knif lie km', 'userfield'=>'123456', 'date'=>'2010-05-13 23:59:58'} |
    | text_message_delivery_receipt | {'msgid'=>'6942744494999745', 'dlrstatus'=>'DELIVRD', 'dlr_err'=>'000', 'donedate'=>'1005132312'}              |
    | paypal_ipn                    | {'mc_gross'=>'54.00', 'protection_eligibility'=>'Eligible', 'for_auction'=>'true', 'address_status'=>'confirmed', 'item_number1'=>'12345790063', 'payer_id'=>'T23XXY2DVKA6J', 'tax'=>'0.00', 'address_street'=>'address', 'payment_date'=>'08:30:40 May 06, 2010 PDT', 'payment_status'=>'Completed', 'charset'=>'windows-1252', 'auction_closing_date'=>'08:27:08 Jun 05, 2010 PDT', 'address_zip'=>'98102', 'first_name'=>'Test', 'auction_buyer_id'=>'testuser_mehbuyer', 'mc_fee'=>'2.41', 'address_country_code'=>'US', 'address_name'=>'Test User', 'notify_version'=>'2.9', 'custom'=>'', 'payer_status'=>'verified', 'business'=>'seller@example.com', 'num_cart_items'=>'1', 'address_country'=>'United States', 'address_city'=>'city', 'quantity'=>'1', 'verify_sign'=>'Aa4P7UnWW85EE9W0YVKVAc7z1v8OAkejFXqE2AlDChXtbvZRHTHaiH4C', 'payer_email'=>'mehbuy_1272942317_per@gmail.com', 'txn_id'=>'45D21472YD1820048', 'payment_type'=>'instant', 'last_name'=>'User', 'item_name1'=>'Yet another piece of mank', 'address_state'=>'WA', 'receiver_email'=>'seller@example.com', 'payment_fee'=>'2.41', 'quantity1'=>'1', 'insurance_amount'=>'0.00', 'receiver_id'=>'8AYM8ZN48AARJ', 'txn_type'=>'web_accept', 'item_name'=>'Yet another piece of mank', 'mc_currency'=>'USD', 'item_number'=>'12345790063', 'residence_country'=>'AU', 'test_ipn'=>'1', 'transaction_subject'=>'Yet another piece of mank', 'payment_gross'=>'54.00', 'shipping'=>'20.00'}                   |


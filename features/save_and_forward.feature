Feature: Save and Forward Incoming Text Messages
  In order to allow the main application to go offline for maintenance
  I want to store all incoming text messages and forward them to the main application when its available

  Scenario: An incoming text message is received
    When an incoming text message is received with: "{'to'=>'61447100308', 'from'=>'66814822967', 'msg'=>'Edin knif lie km', 'userfield'=>'123456', 'date'=>'2010-05-13 23:59:58'}"

    Then an incoming_text_message should exist with params: "{'to'=>'61447100308', 'from'=>'66814822967', 'msg'=>'Edin knif lie km', 'userfield'=>'123456', 'date'=>'2010-05-13 23:59:58'}"


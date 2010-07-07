# Start the server with dev_appserver .
# then run ruby curl_requests.rb

# create incoming text message
`curl "http://localhost:8080/incoming_text_messages?to=61447100308&from=66814822967&msg=Edin%20knif%20lie%20km&userfield=123456&date=2010-05-13%2023:59:58"`

# create text message delivery receipt
`curl "http://localhost:8080/text_message_delivery_receipts?msgid=>6942744494999745&dlrstatus=>DELIVRD&dlr_err=>000&donedate=>1005132312"`


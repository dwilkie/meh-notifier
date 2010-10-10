## Start the server with dev_appserver .
## then run ruby curl_requests.rb

# create incoming text message
`curl "http://localhost:8080/incoming_text_messages?to=61447100308&from=66814822967&msg=Edin%20knif%20lie%20km&userfield=123456&date=2010-05-13%2023:59:58"`

## create text message delivery receipt
`curl "http://localhost:8080/text_message_delivery_receipts?msgid=6942744494999745&dlrstatus=DELIVRD&dlr_err=000&donedate=1005132312"`

# create a tropo message
`curl -d '{"session":{"id":"fe9713e2658f5153911e077d795fabf8","accountId":"50469","timestamp":"2010-10-09T11:49:59.586Z","userType":"HUMAN","initialText":"What?","callId":"1dff54394c5987ef5ba0961a35409d26","to":{"id":"13314314191","name":"unknown","channel":"TEXT","network":"SMS"},"from":{"id":"841232894112","name":"unknown","channel":"TEXT","network":"SMS"},"headers":{"Max-Forwards":"70","Content-Length":"124","Contact":"<sip:10.6.93.101:5066;transport=udp>","To":"<sip:9991454582@10.6.69.204:5061;to=13314314191>","CSeq":"1 INVITE","Via":"SIP/2.0/UDP 10.6.93.101:5066;branch=z9hG4bK2ztqtu","Call-ID":"arfdz6","Content-Type":"application/sdp","From":"<sip:64EB6BAC-99DF-44C2-871DFBA75C319776@10.6.61.201;channel=private;user=841232894112;msg=What%3f;network=SMS;step=1>;tag=le9j4s"}}}' "http://localhost:8080/tropo_messages.json"`


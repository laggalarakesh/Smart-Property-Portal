public class SMSCalloutTest {
  public static void sendTestSMS() {
    HttpRequest req = new HttpRequest();
    req.setEndpoint('https://api.example.com/sms'); // Replace with your SMS API
    req.setMethod('POST');
    req.setHeader('Content-Type', 'application/json');
    req.setBody(
      '{"phone":"919812345678","message":"Test SMS from Salesforce"}'
    );

    Http http = new Http();
    try {
      HttpResponse res = http.send(req);
      System.debug('Response: ' + res.getBody());
    } catch (Exception e) {
      System.debug('Error: ' + e.getMessage());
    }
  }
}

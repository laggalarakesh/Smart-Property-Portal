public class SMSService {
  // Future method for asynchronous SMS sending (supports callouts)
  @future(callout=true)
  public static void sendSMSAsync(List<Id> visitIds) {
    if (visitIds == null || visitIds.isEmpty()) {
      return; // Nothing to send
    }

    // Query visits with Phone__c and required fields
    List<Visit__c> visits = [
      SELECT Id, Phone__c
      FROM Visit__c
      WHERE Id IN :visitIds
    ];

    for (Visit__c v : visits) {
      // Skip if Phone__c is blank
      if (String.isBlank(v.Phone__c)) {
        System.debug('Skipping visit ' + v.Id + ' due to empty phone number.');
        continue;
      }

      HttpRequest req = new HttpRequest();
      req.setEndpoint('https://api.example.com/sms');
      req.setMethod('POST');

      // Send phone as text to avoid integer/decimal issues
      req.setBody(
        '{"phone":"' + v.Phone__c + '","message":"Your visit is scheduled."}'
      );

      Http http = new Http();
      try {
        HttpResponse res = http.send(req);
        System.debug(
          'SMS sent to ' + v.Phone__c + ' | Status: ' + res.getStatus()
        );
      } catch (Exception e) {
        System.debug(
          'Error sending SMS for visit ' + v.Id + ': ' + e.getMessage()
        );
      }
    }
  }
}

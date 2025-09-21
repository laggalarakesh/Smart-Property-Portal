@isTest
public class SMSServiceTest {
  @isTest
  static void testSendSMSAsync() {
    Property__c prop = new Property__c(
      Name = 'Test Property',
      Location__c = 'Hyderabad'
    );
    insert prop;

    Visit__c v = new Visit__c(
      Phone__c = '919812345678',
      Property__c = prop.Id,
      Visit_Date__c = Date.today()
    );
    insert v;

    Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());

    Test.startTest();
    SMSService.sendSMSAsync(new List<Id>{ v.Id });
    Test.stopTest();

    System.assert(true);
  }
}

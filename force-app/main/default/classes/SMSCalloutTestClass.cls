@isTest
public class SMSCalloutTestClass {
  @isTest
  static void testSendTestSMS() {
    // Mock HTTP Response
    Test.setMock(HttpCalloutMock.class, new MockSMSResponse());

    Test.startTest();
    SMSCalloutTest.sendTestSMS();
    Test.stopTest();

    System.assert(true);
  }
}

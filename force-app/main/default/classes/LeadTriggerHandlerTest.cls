@isTest
public class LeadTriggerHandlerTest {
  @isTest
  static void testLeadTriggerHandler() {
    Lead l = new Lead(
      FirstName = 'Test',
      LastName = 'Lead',
      Company = 'Test Company',
      Email = 'test@test.com',
      Phone = '9999999999'
    );
    insert l;

    Test.startTest();
    update l;
    Test.stopTest();

    Opportunity opp = [
      SELECT Id, Lead_Reference__c
      FROM Opportunity
      WHERE Lead_Reference__c = :l.Id
      LIMIT 1
    ];
    System.assertNotEquals(null, opp);
  }
}

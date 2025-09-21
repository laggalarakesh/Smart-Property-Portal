@isTest
public class PropertyServiceTest {
  @isTest
  static void testAssignPropertyToLead() {
    Lead l = new Lead(
      FirstName = 'Test',
      LastName = 'Lead',
      Company = 'Test Company',
      Email = 'lead@test.com',
      Phone = '9999999999'
    );
    insert l;

    Property__c prop = new Property__c(
      Name = 'Test Property',
      Location__c = 'Hyderabad'
    );
    insert prop;

    Test.startTest();
    PropertyService.assignPropertyToLead(l.Id, prop.Id);
    Test.stopTest();

    Lead_Property__c lp = [
      SELECT Id, Lead__c, Property__c
      FROM Lead_Property__c
      WHERE Lead__c = :l.Id
      LIMIT 1
    ];
    System.assertEquals(prop.Id, lp.Property__c);
  }
}

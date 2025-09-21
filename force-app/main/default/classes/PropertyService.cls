public with sharing class PropertyService {
  // ✅ Get all available properties
  public static List<Property__c> getAvailableProperties() {
    return [
      SELECT Id, Name, Price__c, Status__c, Location__c
      FROM Property__c
      WHERE Status__c = 'Available'
    ];
  }

  // ✅ Assign property to a Lead (simple update of Status or linking via lookup)
  public static void assignPropertyToLead(Id leadId, Id propertyId) {
    // Example logic: mark property as "Assigned"
    Property__c prop = [
      SELECT Id, Status__c
      FROM Property__c
      WHERE Id = :propertyId
      LIMIT 1
    ];

    prop.Status__c = 'Assigned';
    update prop;

    // OPTIONAL: if you want to track assignment, you can create a junction object later
    // or add a Lead__c lookup field on Property__c
  }
}

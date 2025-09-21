public class HighValueLeadPublisher {
  public static void publishEvent(Lead newLead) {
    // Check if the lead qualifies as high-value
    if (
      newLead.EstimatedValue__c != null &&
      newLead.EstimatedValue__c >= 100000
    ) {
      High_Value_Lead_Event__e event = new High_Value_Lead_Event__e(
        LeadId__c = newLead.Id,
        LeadName__c = newLead.Name,
        LeadValue__c = newLead.EstimatedValue__c,
        LeadEmail__c = newLead.Email
      );
      Database.SaveResult sr = EventBus.publish(event);
      System.debug('Platform Event Published: ' + sr.isSuccess());
    }
  }
}

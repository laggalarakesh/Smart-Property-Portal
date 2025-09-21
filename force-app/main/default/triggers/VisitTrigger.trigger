trigger VisitTrigger on Visit__c(after insert, after update) {
  if (Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)) {
    List<Id> visitIds = new List<Id>();
    for (Visit__c v : Trigger.new) {
      visitIds.add(v.Id);
    }
    if (!visitIds.isEmpty()) {
      SMSService.sendSMSAsync(visitIds);
    }
  }
}

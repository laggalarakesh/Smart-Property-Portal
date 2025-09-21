trigger LeadConversionTrigger on Lead(before insert) {
  if (Trigger.isAfter && Trigger.isUpdate) {
    LeadTriggerHandler.afterUpdate(Trigger.new, Trigger.oldMap);
  }
}

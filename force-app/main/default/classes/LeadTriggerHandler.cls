public with sharing class LeadTriggerHandler {
  private static Boolean hasRun = false;

  public static void afterUpdate(List<Lead> newLeads, Map<Id, Lead> oldMap) {
    if (hasRun)
      return;
    hasRun = true;

    List<Opportunity> oppsToInsert = new List<Opportunity>();

    for (Lead ld : newLeads) {
      Lead oldLd = oldMap.get(ld.Id);
      if (oldLd == null)
        continue;

      // transition: not converted -> converted
      if (!oldLd.IsConverted && ld.IsConverted) {
        // If conversion did not create an Opportunity but did create an Account
        if (
          ld.ConvertedOpportunityId == null &&
          ld.ConvertedAccountId != null
        ) {
          Opportunity o = new Opportunity(
            Name = (String.isNotBlank(ld.Company)
              ? ld.Company + ' - Follow Up'
              : 'Follow Up Opportunity'),
            AccountId = ld.ConvertedAccountId,
            CloseDate = Date.today().addDays(30),
            StageName = 'Prospecting',
            Description = 'Auto-created from Lead Id: ' + ld.Id
          );
          oppsToInsert.add(o);
        }
      }
    }

    if (!oppsToInsert.isEmpty()) {
      insert oppsToInsert;
    }
  }
}

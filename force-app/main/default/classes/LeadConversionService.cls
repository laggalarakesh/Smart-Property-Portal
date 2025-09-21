public with sharing class LeadConversionService {
  public static void convertLead(
    Id leadId,
    Boolean createOpportunity,
    String opportunityName
  ) {
    if (leadId == null)
      return;
    Lead l = [SELECT Id, IsConverted FROM Lead WHERE Id = :leadId LIMIT 1];
    if (l.IsConverted)
      return;

    Database.LeadConvert lc = new Database.LeadConvert();
    lc.setLeadId(leadId);
    lc.setDoNotCreateOpportunity(!createOpportunity);
    if (createOpportunity && String.isNotBlank(opportunityName))
      lc.setOpportunityName(opportunityName);

    Database.LeadConvertResult result = Database.convertLead(lc);
    if (!result.isSuccess()) {
      throw new AuraHandledException('Lead conversion failed: ' + result);
    }
  }
}

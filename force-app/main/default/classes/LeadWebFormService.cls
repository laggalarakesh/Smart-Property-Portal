@RestResource(urlMapping='/LeadWebForm/*')
global with sharing class LeadWebFormService {
  @HttpPost
  global static String createLead(
    String firstName,
    String lastName,
    String email,
    String phone
  ) {
    Lead l = new Lead(
      FirstName = firstName,
      LastName = lastName,
      Company = 'WebForm Lead',
      Email = email,
      Phone = phone
    );
    insert l;
    return 'Lead Created: ' + l.Id;
  }
}

@isTest
private class MasterTestSetup {
  @testSetup
  static void setupData() {
    // Insert bypass flag for all tests
    Test_Config__c cfg = new Test_Config__c(Bypass_Automations__c = true);
    insert cfg;
  }
}

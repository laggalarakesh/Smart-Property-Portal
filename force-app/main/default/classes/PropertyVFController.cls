public with sharing class PropertyVFController {
  public String locationFilter { get; set; }
  public Decimal minPrice { get; set; }
  public Decimal maxPrice { get; set; }

  // Holds the list of properties to display
  public List<Property__c> properties { get; set; }

  // Constructor
  public PropertyVFController() {
    properties = [
      SELECT Id, Name, Price__c, Location__c, Status__c
      FROM Property__c
      WHERE Status__c = 'Available'
      ORDER BY Name
    ];
  }

  // Action method for filtering
  public void filterProperties() {
    String query = 'SELECT Id, Name, Price__c, Location__c, Status__c FROM Property__c WHERE Status__c = \'Available\'';

    if (locationFilter != null && locationFilter != '') {
      query +=
        ' AND Location__c LIKE \'%' +
        String.escapeSingleQuotes(locationFilter) +
        '%\'';
    }
    if (minPrice != null) {
      query += ' AND Price__c >= ' + minPrice;
    }
    if (maxPrice != null) {
      query += ' AND Price__c <= ' + maxPrice;
    }

    properties = Database.query(query);
  }
}

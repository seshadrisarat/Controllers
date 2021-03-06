public with sharing class AccountDiscoveryController {
    Transient List<Lead_Qualification__c> allLeadQualList{get;set;}
    public Lead_Qualification__c leadQualificationObj{get;set;}
    public Network_Information__c networkInformationObj{get;set;}
    public accountDiscoveryConrollerVersion1(ApexPages.accountDiscoveryConrollerVersion1) {
      this.
    }
    public Network_Information netw{get;set;}
    public Account acct{get;set;}
    public string viewMode{get;set;}
    public String redirectUrl{get;set;}
    public AccountDiscoveryController(ApexPages.StandardController controller) {

        //property to hold parent view url to solve cross domain issue
        redirectUrl = controller.view().getUrl();
        acct = (Account)controller.getRecord();
        if(acct != null && !String.isBlank(acct.Id)) {
            allLeadQualList = new List<Lead_Qualification__c>();
            leadQualificationObj = new Lead_Qualification__c();
            allLeadQualList = [select Id, Discovery_Notes__c from Lead_Qualification__c where Opportunity__c = : acct.ID
                                ORDER BY LastModifiedDate DESC LIMIT 1];
            if(allLeadQualList.size() >0){
                  leadQualificationObj = allLeadQualList.get(0);
                  viewMode = 'read';
            }else{
                viewMode = 'edit';
            }
        }
        else{
            viewMode = 'edit';
        }
    }
  //--------------methods to controll read or write mode of page
 public void showEdit(){
        viewMode = 'edit';
    }
    
    public void hideEdit(){
        viewMode = 'read';
    }


  //--------------override method save
public void save(){

  //----------updating current Account record
  update acct;

  //---------updating or creating leadQualificaiton record
  leadQualificationObj.Account__c = acct.Id;
  upsert leadQualificationObj;
  viewMode = 'read';
	}
}

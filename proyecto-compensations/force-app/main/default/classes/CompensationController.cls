public with sharing class CompensationController {
    @AuraEnabled
    public static List<Compensation__c> getCompensations(){
        return [Select Id, Name, Job_Category__c, RecordType.Name, Employee__r.Name, Employee__r.Birthdate, Location__c, Amount__c, Office__c, Status__c, Submitted__c from Compensation__c];
    }
    @AuraEnabled
    public static List<Compensation__c> getByRecordType(String type, String filterStatus){
        if(filterStatus =='all'){
            return [Select Id, Name, Job_Category__c, RecordType.Name, Employee__r.Name, Employee__r.Birthdate, Location__c, Amount__c, Office__c, Status__c, Submitted__c from Compensation__c Where RecordType.Name like :type];    
        }
        else{
            if(type=='all'){
   				return allType(filterStatus);
            }
            else{
            switch on filterStatus {
                when 'submitted' {       
                    
                    return [Select Id, Name, Job_Category__c, RecordType.Name, Employee__r.Name, Employee__r.Birthdate, Location__c, Amount__c, Office__c, Status__c, Submitted__c from Compensation__c Where RecordType.Name like :type and Status__c like :filterStatus];
                    
                }  
                when 'notSubmitted' { 
                    return [Select Id, Name, Job_Category__c, RecordType.Name, Employee__r.Name, Employee__r.Birthdate, Location__c, Amount__c, Office__c, Status__c, Submitted__c from Compensation__c Where RecordType.Name like :type and (NOT Status__c like 'SUBMITTED')];
                }
                when else {return new List<Compensation__c>();}
            }
            }
        }
    }
    @AuraEnabled
    public static List<Compensation__c> getByStatus(String status, String filterType){
        if(filterType =='all'){    
			return allType(status);
        }
        else{
            switch on status{
                when 'submitted' {
                    return [Select Id, Name, Job_Category__c, RecordType.Name, Employee__r.Name, Employee__r.Birthdate, Location__c, Amount__c, Office__c, Status__c, Submitted__c from Compensation__c Where RecordType.Name like :filterType and Status__c like :status];
                }
                when 'notSubmitted' {  return [Select Id, Name, Job_Category__c, RecordType.Name, Employee__r.Name, Employee__r.Birthdate, Location__c, Amount__c, Office__c, Status__c, Submitted__c from Compensation__c Where RecordType.Name like :filterType and (NOT Status__c like 'SUBMITTED')];
                                     
                                    }
                when 'all'{  return [Select Id, Name, Job_Category__c, RecordType.Name, Employee__r.Name, Employee__r.Birthdate, Location__c, Amount__c, Office__c, Status__c, Submitted__c from Compensation__c Where RecordType.Name like :filterType ];
                           
                          }
                when else {return new List<Compensation__c>();}
                
            }  
        }
    }
    @AuraEnabled
    public static List <Compensation__c> updateById(String[] ids){
        List <Compensation__c> comps= new List<Compensation__c>();
        for(Compensation__c c: [Select Id from Compensation__c Where Id in :ids]){
            c.Status__c= 'SUBMITTED';
            comps.add(c);
        }
        update comps;
        return comps;
    }
    
    public static List<Compensation__c> allType(String status){
                                switch on status {
                when 'submitted' {      
                    
                    return [Select Id, Name, Job_Category__c, RecordType.Name, Employee__r.Name, Employee__r.Birthdate, Location__c, Amount__c, Office__c, Status__c, Submitted__c from Compensation__c Where Status__c like :status];
                    
                }  
                when 'notSubmitted' { 
                    return [Select Id,  Name, Job_Category__c, RecordType.Name, Employee__r.Name, Employee__r.Birthdate, Location__c, Amount__c, Office__c, Status__c, Submitted__c from Compensation__c Where  (NOT Status__c like 'SUBMITTED')];
                }
                when else {return new List<Compensation__c>();}
            } 
    }
}
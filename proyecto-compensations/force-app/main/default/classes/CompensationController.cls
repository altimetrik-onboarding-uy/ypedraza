public with sharing class CompensationController {
    @AuraEnabled
    public static List<Compensation__c> getCompensations(){
        return [Select Id, Name, Job_Category__c, RecordType.Name, Employee__r.Name, Employee__r.Birthdate, Location__c, Amount__c, Office__c, Status__c, Submitted__c from Compensation__c];
    }
    @AuraEnabled
    public static List<Compensation__c> getByRecordType(String type){
        return [Select Id, Job_Category__c, RecordType.Name, Employee__r.Name, Employee__r.Birthdate, Location__c, Amount__c, Office__c, Status__c, Submitted__c from Compensation__c Where RecordType.Name like :type];
    }
}
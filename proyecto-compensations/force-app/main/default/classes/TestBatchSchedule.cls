@isTest
public class TestBatchSchedule {
    @isTest static void testSchedule(){
            Test.startTest();
        String CRON_EXP = '0 0 0 15 3 ? 2020';
        BatchSchedule bs = new BatchSchedule();
        System.schedule('ScheduledApexTest', CRON_EXP, new BatchSchedule());
        
        Test.stopTest();

    }
}
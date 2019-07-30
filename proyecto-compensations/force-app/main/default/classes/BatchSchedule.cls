global class BatchSchedule implements Schedulable{
    public BatchSchedule() {
           
    }
    global void execute(SchedulableContext SC) {
        SubmissionBatch sb= new SubmissionBatch();
        String sch = '0 0 0 1/1 * ? *';
        String jobID = system.schedule('Batch Job', sch, sb);

    }


}
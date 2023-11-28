public with sharing class AsyncSchedulable implements Schedulable {
    public static final String CRON_EXPRESSION = '0 0 13 * * ?';

    public void execute(SchedulableContext schedulableContext) {
        new AccountService().updateAccountValueField([SELECT Id, Value__c FROM Account], 1);
    }

    public static void scheduleMe() {
        System.schedule('AsyncSchedulable', CRON_EXPRESSION, new AsyncSchedulable());
    }


    public static void abortJob(String jobName) {
        List<CronTrigger> jobs = [SELECT Id FROM CronTrigger WHERE CronJobDetail.Name = :jobName];
        if (!jobs.isEmpty()) {
            for (CronTrigger job : jobs) {
                System.abortJob(job.Id);
            }
        }
    }
}

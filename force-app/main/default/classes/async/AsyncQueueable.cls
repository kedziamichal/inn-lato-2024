public with sharing class AsyncQueueable implements Queueable {
    private List<Account> accounts;

    public AsyncQueueable(List<Account> accounts) {
        this.accounts = accounts;
    }

    public void execute(QueueableContext param1) {
        System.debug('AsyncQueueable execute');
        new AccountService().updateAccountValueField(this.accounts, 50);
    }


//    public void execute(FinalizerContext ctx) {
//        String parentJobId = ctx.getAsyncApexJobId();
//        if (ctx.getResult() == ParentJobResult.SUCCESS) {
//            System.debug('Parent queueable job [' + parentJobId + '] completed successfully.');
//        } else {
//            System.debug('Parent queueable job [' + parentJobId + '] failed due to unhandled exception: ' + ctx.getException().getMessage());
//        }
//        System.debug('Completed: execution of finalizer attached to queueable job: ' + parentJobId);
//    }


//    private class AsyncQueueableChild implements Queueable {
//        private List<Account> accounts;
//        public AsyncQueueableChild(List<Account> accounts) {
//            this.accounts = accounts;
//        }
//        public void execute(QueueableContext param1) {
//            new AccountService().updateAccountValueField(accounts, 1000);
//        }
//    }
}

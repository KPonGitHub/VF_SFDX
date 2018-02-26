public class newOpportunityController {
    Account account;
    Contact contact;
    Opportunity opportunity;
    OpportunityContactRole role;
    
    public Account getAccount(){
        if(account == null) account = new Account();
        return account; 
    }

    public Contact getContact(){
        if(contact == null) contact = new Contact();
        return contact; 
    }

    public Opportunity getOpportunity(){
        if(opportunity == null) opportunity = new Opportunity();
        return opportunity; 
    }

    public OpportunityContactRole getRole(){
        if(role == null) role = new OpportunityContactRole();
        return role; 
    }
    
    public PageReference step1(){
        return Page.opptyStep1;
    }

    public PageReference step2(){
        return Page.opptyStep2;
    }

    public PageReference step3(){
        return Page.opptyStep3;
    }

    public PageReference cancel(){
        PageReference opportunityPage = new ApexPages.StandardController(new opportunity()).view();
        opportunityPage.setRedirect(true);
        return opportunityPage;
    }

    public Pagereference save(){
        account.phone = contact.phone;
        insert account;

        contact.AccountID = account.Id;
        insert contact;

        opportunity.accountId = account.Id;
        insert opportunity;

        role.opportunityId = opportunity.Id;
        role.contactId = contact.Id;
        insert role;

        Pagereference oppPage = new Apexpages.StandardController(opportunity).view();
        oppPage.setRedirect(true);
        return oppPage;
        
    }
}

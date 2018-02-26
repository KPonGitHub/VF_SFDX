public class retrieveCase {

    public List<Case> getCases() {
        return [select status,subject from Case where Contact.LastName='Contact' and status <> 'Closed'];
    }


    public String getContactName() {
        return 'Barbara Levy';
    }

}
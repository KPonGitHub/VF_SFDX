public with sharing class DynamicCustomizableListHandler {

    private Apexpages.StandardSetController controller;
    private Pagereference savePage;

    private Set<String> selectedNames = new Set<String>();
    private Set<String> unselectedNames = new Set<String>();
    private Set<String> inaccessibleNames = new Set<String>();

    public DynamicCustomizableListHandler(ApexPages.StandardSetController controller) {
        this.controller = controller;
        loadFieldsWithVisibility();
    }

    private void loadFieldsWithVisibility(){
        Map<String,Schema.SObjectField> fields = Schema.SObjectType.Account.fields.getMap();
        for(String s: fields.keySet()){
            if(s != 'Name'){
                unselectedNames.add(s);
            }
            if(!fields.get(s).getDescribe().isAccessible()){
                inaccessibleNames.add(s);
            }
        }
    }

    public List<String> getDisplayFields(){
        List<String> displayFields = new List<String>(selectedNames);
        displayFields.sort();
        return displayFields; 
    }

    public Pagereference customize(){
        savePage = Apexpages.currentPage();
        return Page.CustomizeDynamicList;
    }

    public Pagereference show(){
        controller.reset();
        controller.addFields(getDisplayFields());
        return savePage;
    }

    public List<SelectOption> getSelectedOptions(){
        return createSelectOptionsFromSet(selectedNames);
    }

    public List<SelectOption> getUnselectedOptions(){
        return createSelectOptionsFromSet(unselectedNames);
    } 

    private List<SelectOption> createSelectOptionsFromSet(Set<String> opts){
        List<String> optList = new List<String>(opts);
        optList.sort();
        List<SelectOption> optSelectList = new List<SelectOption>();

        for(String s: optList){
            optSelectList.add(
                new SelectOption(s,decorateName(s),inaccessibleNames.contains(s))
            );
        }
        return optSelectList;
    }

    private String decorateName(String name){
        return inaccessibleNames.contains(name) ? '*' + name : name;
    }

    public transient List<String> selected {get;set;}
    public transient List<String> unselected {get;set;}

    public void doAdd(){
        moveFields(selected, selectedNames, unselectedNames);
    }

    public void doRemove(){
        moveFields(unselected, unselectedNames, selectedNames);
    }

    private void moveFields(List<String> items, Set<String> moveTo, Set<String> removeFrom){
        for(String s : items){
            if(!inaccessibleNames.contains(s)){
                moveTo.add(s);
                removeFrom.remove(s);
            }
        }
    }

}

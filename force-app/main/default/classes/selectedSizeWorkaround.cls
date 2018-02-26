public with sharing class selectedSizeWorkaround {
    Apexpages.StandardSetController setCon;
    public selectedSizeWorkaround(Apexpages.StandardSetController controller){
        setCon = controller;
    }

    public Integer getMySelectedSize(){
        return setCon.getSelected().size();
    }

    public Integer getMyRecordsSize(){
        return setCon.getRecords().size();
    }
}

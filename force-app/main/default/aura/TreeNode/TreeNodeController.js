({
    toggleExpanded : function(component, event, helper){
        event.stopPropagation();
        component.set('v.isExpanded', component.get('v.isExpanded') == false);
        if(component.get('v.isExpanded') == false){
            $A.get('e.c:collapseTreeEvt').fire();
        }
    },
    collapseNode : function(component, event, helper){
        component.set('v.isExpanded', false);
    },
    stopPropagation : function(component, event, helper){
        event.stopPropagation();
    }

})
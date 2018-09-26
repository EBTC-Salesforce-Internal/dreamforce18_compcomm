({
	executeSearch : function(component, event, helper) {
		var searchTerm = component.get('v.searchString');

		if(searchTerm == null || searchTerm.length < component.get('v.minCharacters')){
			return;
		}

		var action = component.get('c.searchRecords');
        action.setParams({  
            'term':searchTerm,
            'objectTypes':component.get('v.objectTypes'),
            'objectFieldsString':JSON.stringify(component.get('v.objectFields')),
            'objectFiltersString':JSON.stringify(component.get('v.objectFilters'))
        });

        action.setCallback(this, function(response){
            if(response.getState() === 'SUCCESS'){
                var results = response.getReturnValue();
                console.log(results);
                component.set('v.results', results);
                component.set('v.focused', 0);
                
            }else{
                console.error('Something went wrong', response);
            }
        });

        $A.enqueueAction(action);
	}
})
({
	executeSearch : function(component, event, helper) {
		component.set('v.active', true);

		//Debounce server calls, delaying .5 seconds
		var timer = component.get('v.timer');
		clearTimeout(timer);
		timer = window.setTimeout(
			$A.getCallback(function(){
				helper.executeSearch(component, event, helper);
			}), 500);
	},
	select : function(component, event, helper){
		event.setParam('fieldName', component.get('v.name'));
		component.set('v.value', event.getParam('recordId'));
		component.set('v.searchString', event.getParam('record')[component.get('v.nameField')]);
		component.set('v.active', false);
	},
	setInactive : function(component, event, helper) {
		//This action is deferred because it clicking on the list element also blurs the input control, closing the modal.
		//Anything less than .3 seconds results in race conditions on some systems
		window.setTimeout(
			$A.getCallback(function(){
				component.set('v.active', false);
			}), 300);
	},
	reset : function(component, event, helper){
		//Reinit component state
		component.set('v.searchString', '');
		component.set('v.value', null);
		component.set('v.focused', 0);
		component.set('v.results', []);
	},
	focus : function(component, event, helper){
		component.find('searchInput').focus();
	},
	
})
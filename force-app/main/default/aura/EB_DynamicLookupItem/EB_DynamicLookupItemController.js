({
	doInit : function(component, event, helper) {
		var item = component.get('v.item');
		component.set('v.nameValue', item[component.get('v.nameField')]);

		var details = '';
		//TODO Make this dynamic for multiple object types
		component.get('v.displayFields').forEach(function(element){
			if(item[element]){
				details = details + item[element] + ' - ';
			}else if(element && element.includes('.')){
				var steps = element.split('.');
				var val = item;
				for (var i = 0; i < steps.length; i++) {
					val = val[steps[i]];
				}
				details = details + val + ' - ';
			}
		})
		details = details.slice(0, -3);
		component.set('v.displayValue', details);
	},
	select : function(component, event, helper) {
		//Fire the id and record data to be utilized by other components.

		var item = component.get('v.item');
		var event = component.getEvent('itemSelected');
		event.setParam('recordId', item.Id);
		event.setParam('record', item);
		event.fire();
	}
})
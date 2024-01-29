/// @description Insert description here
// You can write your code in this editor

employee_ids = ds_list_create();

// Returns the id of the employee with the least amount of tasks in their list
function find_least_tasks_employee() {
	
	// TODO: No employees edge case
	if (ds_list_size(employee_ids) > 0) {
	
		var _leastAmountOfTasks;
		var _leastAmountEmployeeId;
	
		var _numberOfTasks;
		var _employeeId;
	
		// Loop through for each employee
		for (var i = 0; i < ds_list_size(employee_ids); i++) {
			_employeeId = ds_list_find_value(employee_ids, i);
		
			// Ensure that the employee still exists
			if (is_valid_target(_employeeId)) {
				_numberOfTasks = ds_list_size(_employeeId.command_queue);
			
				// Update the employee with least amount of tasks
				// if they have the least amount of tasks
				if (i == 0) or (_numberOfTasks < _leastAmountOfTasks){
					_leastAmountOfTasks = _numberOfTasks;
					_leastAmountEmployeeId = _employeeId;
				}
			}
		}
	
		show_debug_message("Employee: " + string(_leastAmountEmployeeId) 
							+ " has the least amount of tasks at: " 
							+ string(_leastAmountOfTasks) + "tasks");
		
		return _leastAmountEmployeeId;
		
	} else {
		show_debug_message("No available employees");
	}
}

function request_task(_command, _target, _priority) {
	
	var _employeeIdToGiveTaskTo = find_least_tasks_employee();
	
	with(_employeeIdToGiveTaskTo) {
		queue_command(_command, _target, _priority);
	}
}
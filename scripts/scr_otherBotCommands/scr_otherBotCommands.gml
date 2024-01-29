// Puts a command at the top of the list
// This will usually be used to add a step/requirement to a command
function queue_command_top(_command, _target) {
	var _mapId = ds_map_create();
	ds_map_add(_mapId, "command", _command);
	ds_map_add(_mapId, "target", _target);
	ds_map_add(_mapId, "priority", 0);
	
	ds_list_insert(command_queue, 0, _mapId);
}

function queue_command(_command, _target, _priority) {
	
	var _mapId = ds_map_create();
	ds_map_add(_mapId, "command", _command);
	ds_map_add(_mapId, "target", _target);
	ds_map_add(_mapId, "priority", _priority)
	
	// Find where the command lies on the list of priorities
	for (var i = 0; i < ds_list_size(command_queue); i++) {
		
		// Get a command from the list
		var _nextCommandMap = ds_list_find_value(command_queue, i);
		
		// Find the command's priority
		var _nextCommandPriority = ds_map_find_value(_nextCommandMap, "priority");
		
		// If the command's priority is less than the new command's priority,
		// add the new command just above that one
		if (_priority > _nextCommandPriority) and (_nextCommandPriority != 0){
			ds_list_insert(command_queue, i, _mapId); // Insert the new command
			return
		}
	}
	
	// If the priority is equal to or less than the lowest priority on the list,
	// add it to the end
	ds_list_add(command_queue, _mapId);
}

function leave_or_enter_train(_id) {
	is_outdoors = !is_outdoors;
	return true;
}

function move_to_object(_id) {
	
	// Enter/leave the train if the task is on the other side
	if (_id.is_outdoors != is_outdoors) and (_id != obj_train) {
		queue_command_top(leave_or_enter_train, id); // We queue this one first in order for it to happen second
		queue_command_top(move_to_object, obj_train); // Go to the train to switch inside-outside
	}
	
	
	// Finish objective if close to target
	if (!too_far_from_target(_id))
		return true;
	
	// Move towards target
	var _directionToObject = point_direction(x, y, _id.x, _id.y);
	
	var _moveX = lengthdir_x(1, _directionToObject);
	var _moveY = lengthdir_y(1, _directionToObject);
	
	x += _moveX * walk_speed;
	y += _moveY * walk_speed;
	
	return false;
}

function mine_object(_id) {
	
	// If the target is too far to mine the object, 
	// queue a move command first to get closer
	if (too_far_from_target(_id))
		queue_command_top(move_to_object, _id);
	
	with (_id) {
		mine();
	}
	
	// Attempt to mine until the resource is broken or destroyed
	if (!instance_exists(_id))
		return true;
		
	return false;
}
// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

// Returns true if the bot is within range of the target
function too_far_from_target(_id) {
	if (distance_to_object(_id) > 10)
		return true;
	return false;
}

// Checks to make sure the target still exists
function is_valid_target(_id) {
	if (instance_exists(_id))
		return true;
	return false;
}
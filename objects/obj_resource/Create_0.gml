/// @description Insert description here
// You can write your code in this editor

resource_health = 100;

function mine() {
	resource_health--;
	
	if resource_health <= 0
		instance_destroy();
}
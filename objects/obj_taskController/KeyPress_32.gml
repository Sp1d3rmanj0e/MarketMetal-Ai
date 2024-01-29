/// @description Insert description here
// You can write your code in this editor

var _id = instance_create_layer(mouse_x, mouse_y, "Instances", obj_employee,
{
	profession : choose(E_TYPE.NONE, E_TYPE.ATTENDANT, E_TYPE.WORKER)
});
ds_list_add(employee_ids, _id);
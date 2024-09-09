extends Panel

@onready var p_name: Label = $VBoxContainer/HBoxContainer/Name
@onready var p_tasks: Label = $VBoxContainer/HBoxContainer/Tasks
@onready var p_description: Label = $VBoxContainer/HBoxContainer2/Description
@onready var p_deadline: Label = $VBoxContainer/HBoxContainer2/Deadline

var is_choosen: bool = false
var last_click: int = 0

func _on_button_pressed() -> void:
	if Time.get_ticks_msec() - last_click < 200:
		SaverBase._set_current_project(p_name.text)
		get_tree().change_scene_to_file("res://src/menu/task_manager/task_manager.tscn")
	last_click = Time.get_ticks_msec()
	if is_choosen:
		is_choosen = false
		self_modulate = Color("d3d3d3")
	else:
		is_choosen = true
		self_modulate = Color("1d1d1d")
	
func _on_button_mouse_entered() -> void:
	if !is_choosen:
		self_modulate = Color("d3d3d3")

func _on_button_mouse_exited() -> void:
	if !is_choosen:
		self_modulate = Color("ffffff")

func add_data(project_name: String, project_description: String, project_deadline: String, project_tasks: int):
	p_name.text = project_name
	p_tasks.text = str(project_tasks)
	if project_description != "":
		p_description.text = project_description
	else:
		p_description.hide()
	if project_deadline != "":
		p_deadline.text = project_deadline
	else:
		p_deadline.hide()

func _on_open_button_pressed() -> void:
	SaverBase._set_current_project(p_name.text)
	get_tree().change_scene_to_file("res://src/menu/TaskManager/task_manager.tscn")

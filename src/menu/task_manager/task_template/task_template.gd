extends Panel

@onready var p_name: Label = $VBoxContainer/HBoxContainer/Name
@onready var p_description: Label = $VBoxContainer/HBoxContainer2/Description
@onready var p_deadline: Label = $VBoxContainer/HBoxContainer2/Deadline
@onready var execute: TextureButton = $HBoxContainer/Execute
@onready var delete: TextureButton = $HBoxContainer/Delete

#var is_choosen: bool = false
#var last_click: int = 0

#func _on_button_pressed() -> void:
	#if is_choosen:
		#is_choosen = false
		#self_modulate = Color("d3d3d3")
	#else:
		#is_choosen = true
		#self_modulate = Color("1d1d1d")
	
#func _on_button_mouse_entered() -> void:
	#if !is_choosen:
		#self_modulate = Color("d3d3d3")
#
#func _on_button_mouse_exited() -> void:
	#if !is_choosen:
		#self_modulate = Color("ffffff")

func add_data(project_name: String, project_description: String, project_deadline: String):
	p_name.text = project_name
	if project_description != "":
		p_description.text = project_description
	else:
		p_description.hide()
	if project_deadline != "":
		p_deadline.text = project_deadline
	else:
		p_deadline.hide()

func _on_execute_mouse_entered() -> void:
	execute.modulate = Color.GREEN
	#if !is_choosen:
		#self_modulate = Color("d3d3d3")

func _on_execute_mouse_exited() -> void:
	execute.modulate = Color.WHITE

func _on_delete_mouse_entered() -> void:
	delete.modulate = Color.RED
	#if !is_choosen:
		#self_modulate = Color("d3d3d3")

func _on_delete_mouse_exited() -> void:
	delete.modulate = Color.WHITE

func _on_execute_pressed() -> void:
	SaverBase.delete_task(p_name.text)
	get_tree().reload_current_scene()

func _on_delete_pressed() -> void:
	SaverBase.delete_task(p_name.text)
	get_tree().reload_current_scene()

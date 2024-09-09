extends Control

@onready var v_box_container: VBoxContainer = $TaskPanel/ScrollContainer/VBoxContainer
@onready var project_name_lbl: Label = $ProjectName

const PROJECT_HBOX_CONTAINER = preload("res://src/menu/start/project_template/project_hbox_container.tscn")
const TASK_TEMPLATE = preload("res://src/menu/task_manager/task_template/task_template.tscn")

var project_name: String

func _ready() -> void:
	project_name = SaverBase._get_current_project()
	project_name_lbl.text = project_name
	fill_task_panel()
	
func fill_task_panel():
	var child_to_delete = v_box_container.get_children()
	for child in child_to_delete:
		child.queue_free()
	for task_data in SaverBase.open_tasks():
		var h_box = PROJECT_HBOX_CONTAINER.instantiate()
		v_box_container.add_child(h_box)
		var t_template = TASK_TEMPLATE.instantiate()
		h_box.add_child(t_template)
		t_template.add_data(task_data[0], task_data[1], task_data[2])

func _on_add_task_pressed() -> void:
	get_tree().change_scene_to_file("res://src/menu/task_creator/task_creator.tscn")

func _on_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://src/menu/start/start.tscn")

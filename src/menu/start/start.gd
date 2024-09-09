extends Control

@onready var add_projects: Button = $ButtonPanel/HBoxContainer/AddProject
@onready var delete_project: Button = $ButtonPanel/HBoxContainer/DeleteProject
@onready var v_box_container: VBoxContainer = $ProjectsPanel/ScrollContainer/VBoxContainer
@onready var deleting_confirmation: ConfirmationDialog = $DeletingConfirmation

const PROJECT_HBOX_CONTAINER = preload("res://src/menu/start/project_template/project_hbox_container.tscn")
const PROJECT_TEMPLATE = preload("res://src/menu/start/project_template/project_template.tscn")

var projects_links: Array = []

func _ready() -> void:
	fill_project_panel()

func _on_add_projects_pressed() -> void:
	get_tree().change_scene_to_file("res://src/menu/project_creator/project_creator.tscn")

func _on_delete_project_pressed() -> void:
	var to_delete: Array = []
	for project in projects_links:
		if project.is_choosen:
			to_delete.append(projects_links)
	if to_delete != []:
		deleting_confirmation.show()

func _on_deleting_confirmation() -> void:
	var projects_names_to_delete: Array = []
	for project in projects_links:
		if project.is_choosen:
			projects_names_to_delete.append(project.p_name.text)
	SaverBase.delete_projects(projects_names_to_delete)
	fill_project_panel()
	
func fill_project_panel():
	var child_to_delete = v_box_container.get_children()
	for child in child_to_delete:
		child.queue_free()
	for project_data in SaverBase.open_projects():
		var h_box = PROJECT_HBOX_CONTAINER.instantiate()
		v_box_container.add_child(h_box)
		var p_template = PROJECT_TEMPLATE.instantiate()
		h_box.add_child(p_template)
		p_template.add_data(project_data[0], project_data[1], project_data[2], project_data[3])
		projects_links.append(p_template)

extends Control

@onready var name_edit: LineEdit = $ProjectsPanel/ScrollContainer/VBoxContainer/HBoxContainer/NameEdit
@onready var description_edit: LineEdit = $ProjectsPanel/ScrollContainer/VBoxContainer/HBoxContainer2/DescriptionEdit
@onready var deadline_edit: LineEdit = $ProjectsPanel/ScrollContainer/VBoxContainer/HBoxContainer3/DeadlineEdit
@onready var name_edit_debug: Label = $ProjectsPanel/ScrollContainer/VBoxContainer/HBoxContainer/NameEditDebug

func _on_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://src/menu/start/start.tscn")

func _on_done_pressed() -> void:
	save_to_file()

func save_to_file():
	if name_edit.text != "":
		if name_edit.text.find(" ") == -1:
			SaverBase.create_project(name_edit.text, description_edit.text, deadline_edit.text)
			get_tree().change_scene_to_file("res://src/menu/start/start.tscn")
		else:
			name_edit.modulate = Color.RED
			name_edit.placeholder_text = "Name without space!"
			name_edit_debug.modulate = Color.RED
			name_edit_debug.text = "Name without space!"
	else:
		name_edit.modulate = Color.RED
		name_edit.placeholder_text = "We need name!"
		name_edit_debug.modulate = Color.RED
		name_edit_debug.text = "We need name!"

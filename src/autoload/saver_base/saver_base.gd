extends Node


var user_data_dir: String
var all_projects_dir: String

var current_project: String: set = _set_current_project, get = _get_current_project

func _ready() -> void:
	user_data_dir = OS.get_user_data_dir()
	all_projects_dir = user_data_dir + "/projects/"
	
func _set_current_project(project_name):
	current_project = project_name
	
func _get_current_project():
	return current_project
	
func create_task(new_task_name, new_task_description, new_task_deadline):
	var current_project_dir = all_projects_dir + "/" + current_project + "/"
	var new_task_path = current_project_dir + new_task_name + ".task"
		
	var task_file = FileAccess.open(new_task_path, FileAccess.WRITE)
	if task_file:
		task_file.store_string(new_task_description + "|" + new_task_deadline)
		task_file.close()
		
func open_tasks():
	var tasks: Array = []
	var current_project_dir = all_projects_dir + "/" + current_project + "/"
	var tasks_names_array = DirAccess.get_files_at(current_project_dir)
	tasks_names_array.remove_at(tasks_names_array.find(current_project + ".dat"))
	for task_name in tasks_names_array:
		var task_file = FileAccess.open(current_project_dir + task_name, FileAccess.READ)
		var task_file_text: String = task_file.get_as_text()
		var task_data = task_file_text.split("|")
		tasks.append([task_name, task_data[0], task_data[1]])
	return tasks
	
func delete_task(task_name):
	var task_path = all_projects_dir + current_project + "/" + task_name
	var command = "rm"
	var arguments = ["-rf", task_path]
	OS.execute(command, arguments)

func create_project(new_project_name, new_project_description, new_project_deadline):
	var current_project_dir = all_projects_dir + "/" + new_project_name + "/"
	var current_project_path = current_project_dir + new_project_name + ".dat"
	
	if DirAccess.dir_exists_absolute(all_projects_dir):
		DirAccess.make_dir_absolute(current_project_dir)
	else:
		DirAccess.make_dir_absolute(all_projects_dir)
		DirAccess.make_dir_absolute(current_project_dir)
		
	var project_file = FileAccess.open(current_project_path, FileAccess.WRITE)
	if project_file:
		project_file.store_string(new_project_description + "|" + new_project_deadline)
		project_file.close()

func open_projects():
	var projects: Array = []
	var projects_names_array = DirAccess.get_directories_at(all_projects_dir)
	for project_name in projects_names_array:
		var current_project_dir = all_projects_dir + "/" + project_name + "/"
		var project_file = FileAccess.open(current_project_dir + project_name + ".dat", FileAccess.READ)
		var project_file_text: String = project_file.get_as_text()
		var project_data = project_file_text.split("|")
		projects.append([project_name, project_data[0], project_data[1], DirAccess.get_files_at(current_project_dir).size() - 1]) 
	return projects
	
func delete_projects(projects_names_to_delete: Array):
	for project_name in projects_names_to_delete:
		var project_path = all_projects_dir + project_name
		var command = "rm"
		var arguments = ["-rf", project_path]
		OS.execute(command, arguments)

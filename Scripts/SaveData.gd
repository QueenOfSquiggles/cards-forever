extends Node

const PATH := "user://boards/"
const META_DATA_PATH := "user://meta_data.json"

var meta_data := {
	"last_loaded" : ""
}

func _ready() -> void:
	load_metadata()

func save_metadata() -> void:
	var file := File.new()
	var err_code := file.open(META_DATA_PATH, File.WRITE)
	if err_code != OK:
		return
	file.store_line(to_json(meta_data))
	file.close()

func load_metadata() -> void:
	var file := File.new()
	var err_code := file.open(META_DATA_PATH, File.READ)
	if err_code != OK:
		return
	var json := file.get_as_text()
	meta_data = parse_json(json)
	file.close()

func save_model() -> void:
	ensure_directory()
	var model := Model.model_data
	var save_data := to_json(model)
	var file := File.new()
	var err_code := file.open(PATH + get_viable_filename(model["name"]), File.WRITE)
	if err_code != OK:
		return
	file.store_line(save_data)
	file.close()

func load_model(path : String) -> void:
	var file := File.new()
	var err_code := file.open(path, File.READ)
	if err_code != OK:
		return
	var text := file.get_as_text()
	var model :Dictionary = parse_json(text)
	Model.set_model_data(model)
	meta_data.last_loaded = path
	file.close()
	save_metadata()

func get_viable_filename(name : String) -> String:
	#if name.is_valid_filename():
	#	return name
	return name + ".json"

func get_available_files() -> Array:
	ensure_directory()
	var dir := Directory.new()
	var err_code := dir.open(PATH)
	if err_code != OK:
		dir.close()
		return []
	var files := []
	dir.list_dir_begin(true, true)
	var filename := dir.get_next()
	while filename:
		if filename.ends_with("json"):
			files.append(filename)
		filename = dir.get_next()	
	dir.list_dir_end()
	dir.close()
	return files

func ensure_directory() -> void:
	var dir := Directory.new()
	dir.make_dir_recursive(PATH)
	dir.close()

extends Control

onready var save := $SaveData

func _ready() -> void:
	if not save.meta_data.last_loaded.empty():
		# if there is a previously loaded board, open that one
		save.load_model(save.meta_data.last_loaded)

func _input(event: InputEvent) -> void:
	pass

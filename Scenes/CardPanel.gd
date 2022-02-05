extends PanelContainer

onready var lbl_title : Button = $VBoxContainer/Title
onready var lbl_tags : Label = $VBoxContainer/Tags
onready var lbl_description : Label = $VBoxContainer/Description

signal edit_pressed

var data := {}

func _ready() -> void:
	lbl_title.connect("pressed", self, "emit_signal", ["edit_pressed"]) # pass button signal up a level

func set_data(data : Dictionary) -> void:
	self.data = data
	lbl_title.text = data["name"]
	lbl_tags.text = str(data["tags"])
	lbl_description.text = data["description"]

func get_index() -> int:
	return data["index"]

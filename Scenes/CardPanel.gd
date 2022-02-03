extends PanelContainer

onready var lbl_title : Button = $VBoxContainer/Title
onready var lbl_tags : Label = $VBoxContainer/Tags
onready var lbl_description : Label = $VBoxContainer/Description

signal edit_pressed

func _ready() -> void:
	lbl_title.connect("pressed", self, "emit_signal", ["edit_pressed"]) # pass button signal up a level

func set_data(title : String, tags : Array, description : String) -> void:
	lbl_title.text = title
	lbl_tags.text = str(tags)
	lbl_description.text = description

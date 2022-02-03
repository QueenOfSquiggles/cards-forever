extends PanelContainer

export (NodePath) var card_list_path : NodePath

onready var title_button := $"VBoxContainer/CategoryHeader/CategoryTitle"


signal edit_category_pressed(category_name)
signal edit_card_pressed(category_name, card_name)

func _ready() -> void:
	pass

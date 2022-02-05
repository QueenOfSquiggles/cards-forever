extends PanelContainer

export (NodePath) var card_list_path : NodePath
export (PackedScene) var card_scene : PackedScene

onready var title_button := $"VBoxContainer/CategoryHeader/CategoryTitle"


signal edit_category_pressed(category_name)
signal edit_card_pressed(category_name, card_name)

var data := {}

func set_category_data(data : Dictionary) -> void:
	print("Creating panel with data ", data)
	self.data = data
	self.name = get_name()
	var root := get_node(card_list_path)
	for c in root.get_children():
		root.remove_child(c)
	var cards : Array = data["cards"]
	for c in cards:
		var card := card_scene.instance()
		root.add_child(card)
		card.set_data(c)
	for c in root.get_children():
		var i :int = c.get_index()
		root.move_child(c, i)
	title_button.text = get_name()

func get_data() -> Dictionary:
	return data

func get_index() -> int:
	return data["index"]

func get_name() -> String:
	return data["name"]

func _on_BtnAddCard_pressed() -> void:
	Model.add_card(get_name())


func _on_CategoryTitle_pressed() -> void:
	emit_signal("edit_category_pressed", get_name())

extends Control

onready var save := $SaveData

func _ready() -> void:
	if not save.meta_data.last_loaded.empty():
		# if there is a previously loaded board, open that one
		save.load_model(save.meta_data.last_loaded)
	Model.connect("on_model_changed", self, "refresh_view")

"""
---------------------------------------
	VIEW
---------------------------------------
"""
export (NodePath) var category_list : NodePath
export (PackedScene) var category_scene : PackedScene


func refresh_view() -> void:
	var root := get_node(category_list)
	for i in root.get_children():
		if not i is Button:
			root.remove_child(i)
	var categories := Model.get_categories()
	for c in categories:
		var cat := category_scene.instance()
		root.add_child(cat)
		cat.name = c["name"]
		cat.set_category_data(c)
	for c in root.get_children():
		if c is Button:
			root.move_child(c, root.get_child_count()-1)
		else:
			root.move_child(c, c.get_index())
			(c as PanelContainer).connect("mouse_entered", self, "set_mouseover_panel", [c])
			(c as PanelContainer).connect("mouse_exited", self, "set_mouseover_panel", [null])
			

"""
---------------------------------------
	CONTROLLER
---------------------------------------
"""

var mouse_current_panel : Control
var mouse_current_card : Control

func set_mouseover_panel(panel : Control) -> void:
	mouse_current_panel = panel
	if mouse_current_panel != null:
		print("Current mouseover panel : ", panel.name)

func set_mouseover_card(card : Control) -> void:
	mouse_current_card = card

func _on_BtnAddCategory_pressed() -> void:
	Model.add_category()

func _on_MenuButton_pressed() -> void:
	pass

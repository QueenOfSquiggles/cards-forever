extends Node

const SAVE_DIR := "user://boards/"

signal on_model_changed

var model_data := {
	"name" : "_",
	"categories" : []
}

const CATEGORY_DATA := {
	"name" : "Category Name",
	"Description" : "...",
	"index" : 0,
	"cards" : []
}

const CARD_DATA := {
	"name" : "Card Name",
	"description" : "...",
	"index" : 0,
	"tags" : []
}

"""
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	CARDS
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
"""


func add_card(category_name : String) -> void:
	var cat_index := find_category(category_name)
	if cat_index != -1:
		model_data["categories"][cat_index]["cards"].append(CARD_DATA)
		emit_signal("on_model_changed")

func modify_card(category_name : String, card_name : String, data : Dictionary) -> void:
	var indices := find_card(category_name, card_name)
	if not indices.empty():
		var cat :int= indices[0]
		var card :int=indices[1]
		model_data["categories"][cat]["cards"][card] = data
		emit_signal("on_model_changed")

func remove_card(category_name : String, card_name : String) -> void:
	var indices := find_card(category_name, card_name)
	if not indices.empty():
		var cat :int= indices[0]
		var card :int=indices[1]
		model_data["categories"][cat]["cards"].remove(card)
		emit_signal("on_model_changed")

func find_card(category_name : String, card_name : String) -> Array:
	var cat_index := find_category(category_name)
	if cat_index != -1:
		for i in range(model_data["categories"][cat_index]["cards"].size()):
			var card :Dictionary = model_data["categories"][cat_index]["cards"][i]
			if card["name"] == card_name:
				return [cat_index, i]
	return []

"""
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	CATEGORIES
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
"""

func add_category() -> void:
	model_data["categories"].append(CATEGORY_DATA.duplicate())
	emit_signal("on_model_changed")
	
func modify_category(name : String, data : Dictionary) -> void:
	var index := find_category(name)
	if index != -1:
		model_data["categories"][index] = data
		emit_signal("on_model_changed")

func remove_category(name : String) -> void:
	var index := find_category(name)
	if index != -1:
		model_data["categories"].remove(index)
		emit_signal("on_model_changed")

func find_category(name : String) -> int:
	for i in range(model_data["categories"].size()):
		var entry : Dictionary = model_data["categories"][i]
		if entry.name == name:
			return i
	return -1
"""
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	MODEL
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
"""

func set_model_data(data : Dictionary) -> void:
	model_data = data
	emit_signal("on_model_changed")

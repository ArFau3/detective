extends Control

signal close_answer()
signal pick_item()

@onready var who_input: RichTextLabel = $NinePatchRect/VBoxContainer/Who/WhoInput
@onready var why_input: RichTextLabel = $NinePatchRect/VBoxContainer/Why/WhyInput
@onready var how_input: RichTextLabel = $NinePatchRect/VBoxContainer/How/HowInput
@onready var who_button: Button = $NinePatchRect/VBoxContainer/Who/WhoButton
@onready var why_button: Button = $NinePatchRect/VBoxContainer/Why/WhyButton
@onready var how_button: Button = $NinePatchRect/VBoxContainer/How/HowButton

var answer
var who: bool
var why: bool
var how: bool
var form

func _on_close_pressed() -> void:
	who_input.text = ""
	who_button.icon = null
	why_input.text = ""
	why_button.icon = null
	how_input.text = ""
	how_button.icon = null
	Global.game_mode = Global.GAMEMODE.NORMAL
	
	close_answer.emit()

func proses_question(levelInt)->void:
	var levelPath:String = "./Main/Level"+str(levelInt)
	answer = get_tree().get_root().get_node(levelPath).answer

func _on_submit_pressed() -> void:
	if proses_answer():
		Global.gold += answer[0]["reward"]
		_on_close_pressed()
	else:
		_on_close_pressed()
	
func proses_answer()->bool:
	if who and why and how: 
		return true
	else:
		return false

func _on_who_button_pressed() -> void:
	Global.game_mode = Global.GAMEMODE.ANSWER
	form = who_input
	pick_item.emit()

func _on_why_button_pressed() -> void:
	Global.game_mode = Global.GAMEMODE.ANSWER
	form = why_input
	pick_item.emit()

func _on_how_button_pressed() -> void:
	Global.game_mode = Global.GAMEMODE.ANSWER
	form = how_input
	pick_item.emit()

func setting_answer(item:Item)->void:
	if Global.game_mode == Global.GAMEMODE.NORMAL:return
	
	match form:
		who_input:
			who_input.text = item.belongTo
			who = item.rightWho
			who_button.icon = item.texture
			Global.game_mode = Global.GAMEMODE.NORMAL
		why_input:
			if item.reason:
				why_input.text = item.reason
			else:
				why_input.text = "to get "+item.name
			why = item.rightWhy
			why_button.icon = item.texture
			Global.game_mode = Global.GAMEMODE.NORMAL
		how_input:
			if item.how:
				how_input.text = item.how
			else:
				how_input.text = "using "+item.name
			how = item.rightHow
			how_button.icon = item.texture
			Global.game_mode = Global.GAMEMODE.NORMAL

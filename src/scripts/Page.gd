extends Control

signal return_to_menu

func _ready():
	pass

func _on_Button_pressed():
	emit_signal("return_to_menu")

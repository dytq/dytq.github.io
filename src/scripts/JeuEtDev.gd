extends Control

signal return_to_menu

func _ready():
	pass

func _process(delta):
	if(get_window().size.x < 600):
		$ScrollContainer/GridContainer/GridContainer.columns = 1
	else:
		$ScrollContainer/GridContainer/GridContainer.columns = 2


func _on_Button_pressed():
	emit_signal("return_to_menu")


func _on_ButtonSQL_pressed():
	OS.shell_open("https://github.com/dytq/Reserve-ta-place")


func _on_ButtonTkinter_pressed():
	OS.shell_open("https://github.com/dytq/Projet-Space-Adventure")


func _on_ButtonSOD_pressed():
	OS.shell_open("https://github.com/dytq/Projet-Sea-Of-Devs")

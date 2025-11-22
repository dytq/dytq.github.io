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


func _on_Button2_pressed():
	OS.shell_open("https://github.com/dytq/Morpion-IA")


func _on_Button3_pressed():
	OS.shell_open("https://github.com/dytq/Fast-Metro")


func _on_Button4_pressed():
	OS.shell_open("https://github.com/dytq/Table-de-Routage")


func _on_ButtonIA_pressed():
	OS.shell_open("https://github.com/Carcassonne-IA-Version-Deux-Joueurs")

extends Control

# example page
var test_page = load("res://scenes/Test.tscn")

# my pages
var ia_page = load("res://Pages/IA.tscn")
var secu_page = load("res://Pages/Securite.tscn")
var dev_page = load("res://Pages/JeuEtDev.tscn")
var reseau_page = load("res://Pages/ReseauEtSystem.tscn")

var current_scn = null

func _ready():
	pass

func return_to_menu():
	$SubViewportContainer.set_undisplay(Vector2(get_window().size.x,0))
	

func remove_viewport_scene():
	if(current_scn != null):
		$GridContainer/GridContainer2/SubViewportContainer/SubViewport.remove_child(current_scn)
		current_scn.queue_free()

func _process(delta):
	if(get_window().size.x < 600):
		$ScrollContainer/GridContainer/Body.columns = 1
	else:
		$ScrollContainer/GridContainer/Body.columns = 2

# URL
func _on_ButtonCodinGame_pressed():
	OS.shell_open("https://www.codingame.com/profile/9225aa702270c7aeae544e96f72dd7b51131513")

func _on_Buttonrootme_pressed():
	OS.shell_open("https://www.root-me.org/dytq?lang=fr#0d377b7ef72617e4dfeae258abfcf389")

func _on_Buttongithub_pressed():
	OS.shell_open("https://github.com/dytq")

func _on_Buttontryhackme_pressed():
	OS.shell_open("https://tryhackme.com/p/dytq")
	
# Pages 
func _on_Button_pressed():
	var ia = ia_page.instantiate()
	ia.connect("return_to_menu", Callable(self, "return_to_menu"))
	$SubViewportContainer/SubViewport.add_child(ia)
	$SubViewportContainer.set_display(Vector2(0,0),Vector2(get_window().size.x,0))

func _on_ButtonSecurite_pressed():
	var secu = secu_page.instantiate()
	secu.connect("return_to_menu", Callable(self, "return_to_menu"))
	$SubViewportContainer/SubViewport.add_child(secu)
	$SubViewportContainer.set_display(Vector2(0,0),Vector2(get_window().size.x,0))

func _on_ButtonReseauSysteme_pressed():
	var reseau = reseau_page.instantiate()
	reseau.connect("return_to_menu", Callable(self, "return_to_menu"))
	$SubViewportContainer/SubViewport.add_child(reseau)
	$SubViewportContainer.set_display(Vector2(0,0),Vector2(get_window().size.x,0))

func _on_ButtonJeuetDev_pressed():
	var dev = dev_page.instantiate()
	dev.connect("return_to_menu", Callable(self, "return_to_menu"))
	$SubViewportContainer/SubViewport.add_child(dev)
	$SubViewportContainer.set_display(Vector2(0,0),Vector2(get_window().size.x,0))

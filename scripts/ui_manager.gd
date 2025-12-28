extends Node

const BUILD_SCENE_PATH = "server_builder.tscn"

@onready var sub_menus = get_node("%SubMenus")
@onready var close_btn = get_node("%CloseButton")
@onready var desktop_content = get_node("%DesktopContent")
@onready var ui_container = get_node("%UIContainer")

func _ready():
	ResourceLoader.load_threaded_request(BUILD_SCENE_PATH)

func toggle_computer():
	back_to_desktop()
	%UIContainer.visible = !%UIContainer.visible;
	%PlayerBody2D.blocked = %UIContainer.visible;

func open_build_scene():
	get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(BUILD_SCENE_PATH))
	
func open_sub_menu(menu: String):
	%CloseButton.visible = false
	%DesktopContent.visible = false
	%BackButton.visible = true
	%SubMenus.visible = true
	get_node("%" + menu + "Content").visible = true
	
func change_sub_menu(menu: String):
	for n in %SubMenus.get_children():
		n.visible = false
	%BackButton.visible = true
	get_node("%" + menu + "Content").visible = true

func open_tutorial():
	%TutorialContent.visible = true
	%UIContainer.visible = true
	%PlayerBody2D.blocked = true
	for content in sub_menus.get_children():
		content.visible = false
	sub_menus.visible = false
	desktop_content.visible = false
	close_btn.visible = false

func start_tutorial():
	%TutorialCheckContainer.visible = true
	open_tutorial()

func back_to_desktop():
	for content in sub_menus.get_children():
		content.visible = false;
	sub_menus.visible = false;
	desktop_content.visible = true;
	close_btn.visible = true;

func refresh_coins():
	%CoinsLabel.text = str(JsonLoader.money)

func refresh_level():
	%LevelLabel.text = "Level " + str(JsonLoader.level)

func open_popup(type: String):
	%PopupTitle.text = type
	for n in %PopupContainer.get_children():
		if n is VBoxContainer:
			n.visible = false
	get_node("%" + type + "Content").visible = true
	%PopupWindow.visible = true

func hide_popup():
	%PopupTitle.text = "none"
	%PopupWindow.visible = false

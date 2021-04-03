extends Node2D

const ShopC = preload("res://DialogTest/Shop.gd");

var money = 10000;

var dialog;

var O2BottleLevel = 0;
var lampLevel = 0;
var diveSuitLevel = 0;

var shop;

func _ready():
	shop = ShopC.new();
	_on_startDialog("OpenShop");

func _on_Dialogic_Signal(event):
	print(event);
	if(event == "UpgradeO2Bottle"):
		O2BottleLevel += 1;
	if(event == "UpgradeLamp"):
		lampLevel += 1;
	if(event == "UpgradeDiveSuit"):
		diveSuitLevel += 1;
	setDialogVariables();
	
func _on_Event_Start(action, event):
	pass
#	print(action);
#	if(action == "choice"):
##		print(action);
##		print(event.choice)
##		print(event.question_id)

func _on_startDialog(timeline):
	setDialogVariables();
	
	#dialog = Dialogic.start(timeline);
	dialog = Dialogic.start(timeline, false, "res://addons/dialogic/Dialog.tscn", false)
	dialog.connect("dialogic_signal", self, "_on_Dialogic_Signal");
	dialog.connect("event_start", self, "_on_Event_Start")
	$CanvasLayer.add_child(dialog);
	
func setDialogVariables():
	print(Dialogic.get_definitions())
	Dialogic.set_variable("Money", money)
	Dialogic.set_variable("O2Bottle_Max_Level", O2BottleLevel == 3);
	Dialogic.set_variable("O2Bottle_Upgrade_Price", shop.upgradePrices[O2BottleLevel]);
	Dialogic.set_variable("Lamp_Upgrade_Price", shop.upgradePrices[lampLevel]);
	Dialogic.set_variable("DiveSuit_Upgrade_Price", shop.upgradePrices[diveSuitLevel]);

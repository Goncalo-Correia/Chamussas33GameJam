extends Node2D

var money = 2000;
var upgradePrices = [1000, 3000, 10000, INF];

var dialog;

var O2BottleLevel = 0;
var lampLevel = 0;
var diveSuitLevel = 0;

var shop;

func _ready():
	_on_startDialog("OpenShop");

func _on_Dialogic_Signal(event):
	print(event);
	if(event == "UpgradeO2Bottle"):
		money -= shop.upgradePrices[O2BottleLevel];
		O2BottleLevel += 1;
	if(event == "UpgradeLamp"):
		lampLevel += 1;
	if(event == "UpgradeDiveSuit"):
		diveSuitLevel += 1;
	setDialogVariables();
	
func _on_Event_Start(action, event):
	print("ACTION:");
	print(action)
	print("EVENT:")
	print(event)

func _on_startDialog(timeline):
	dialog = Dialogic.start(timeline, false, "res://addons/dialogic/Dialog.tscn", false)
	setDialogVariables();
	dialog.connect("dialogic_signal", self, "_on_Dialogic_Signal");
	dialog.connect("event_start", self, "_on_Event_Start")
	$CanvasLayer.add_child(dialog);
	
func setDialogVariables():
	Dialogic.set_variable("money", money)
	Dialogic.set_variable("O2Bottle_Max_Level", O2BottleLevel == 3);
	Dialogic.set_variable("O2Bottle_Upgrade_Price", upgradePrices[O2BottleLevel]);
	Dialogic.set_variable("lamp_Max_Level", lampLevel == 3);
	Dialogic.set_variable("lamp_Upgrade_Price", upgradePrices[lampLevel]);
	Dialogic.set_variable("diveSuit_Max_Level", diveSuitLevel == 3);
	Dialogic.set_variable("diveSuit_Upgrade_Price", upgradePrices[diveSuitLevel]);
#	print(Dialogic.get_definitions());

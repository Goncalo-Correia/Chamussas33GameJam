extends Node2D

var message = "";
var money = 2000;
var upgradePrices = [1000, 3000, 10000, INF];

var dialog;

var O2BottleLevel = 0;
var lampLevel = 0;
var diveSuitLevel = 0;
var netsAmmout = 0;
var harpoonsAmmout = 0;

var shop;

func _ready():
	_on_message("Test test");
#	startDialog("OpenShop");

func _on_Dialogic_Signal(event):
	print(event);
	if(event == "UpgradeO2Bottle"):
		money -= upgradePrices[O2BottleLevel];
		O2BottleLevel += 1;
	elif(event == "UpgradeLamp"):
		money -= upgradePrices[lampLevel];
		lampLevel += 1;
	elif(event == "UpgradeDiveSuit"):
		money -= upgradePrices[diveSuitLevel];
		diveSuitLevel += 1;
	elif(event == "BuyFishingNet"):
		netsAmmout += 1;
		money -= 50;
	elif(event == "BuyHarpoon"):
		harpoonsAmmout += 1;
		money -= 100;
		
	setDialogVariables();
	
func _on_Event_Start(action, event):
	pass
#	print("ACTION:");
#	print(action)
#	print("EVENT:")
#	print(event)

func _on_message(text):
	message = text;
	startDialog("Message");

func startDialog(timeline):
	dialog = Dialogic.start(timeline, false, "res://addons/dialogic/Dialog.tscn", false)
	setDialogVariables();
	dialog.connect("dialogic_signal", self, "_on_Dialogic_Signal");
	dialog.connect("event_start", self, "_on_Event_Start")
	$CanvasLayer.add_child(dialog);
	
func setDialogVariables():
	Dialogic.set_variable("money", money)
	Dialogic.set_variable("message", message)
	Dialogic.set_variable("O2Bottle_Max_Level", O2BottleLevel == 3);
	Dialogic.set_variable("O2Bottle_Upgrade_Price", upgradePrices[O2BottleLevel]);
	Dialogic.set_variable("lamp_Max_Level", lampLevel == 3);
	Dialogic.set_variable("lamp_Upgrade_Price", upgradePrices[lampLevel]);
	Dialogic.set_variable("diveSuit_Max_Level", diveSuitLevel == 3);
	Dialogic.set_variable("diveSuit_Upgrade_Price", upgradePrices[diveSuitLevel]);
	print(Dialogic.get_definitions());

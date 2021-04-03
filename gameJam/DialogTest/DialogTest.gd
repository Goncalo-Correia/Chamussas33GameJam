extends Node2D

var money = 101;

var newDialog;

func _ready():
	_on_startDialog("OpenShop");

func _on_Dialogic_Signal(event):
	print(event);

func _on_Event_Start(action, event):
	pass
#	print(action);
#	if(action == "choice"):
##		print(action);
##		print(event.choice)
##		print(event.question_id)

func _on_startDialog(timeline):
	Dialogic.set_variable("money", money);
	
	newDialog = Dialogic.start(timeline);
	newDialog.connect("dialogic_signal", self, "_on_Dialogic_Signal");
	newDialog.connect("event_start", self, "_on_Event_Start")
	$CanvasLayer.add_child(newDialog);

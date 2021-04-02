extends Node2D

var newDialog;

func _ready():
	newDialog = Dialogic.start("TestTimeline");
	newDialog.connect("dialogic_signal", self, "_on_Dialogic_Signal");
	newDialog.connect("event_start", self, "_on_Event_Start")
	$CanvasLayer.add_child(newDialog);

func _on_Dialogic_Signal(event):
	print(event);

func _on_Event_Start(action, event):
	if(action == "choice"):
		print(action);
		print(event.choice)
		print(event.question_id)


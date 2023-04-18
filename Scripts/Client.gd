extends Control

func _ready():
	get_tree().connect("network_peer_connected", self, '_client_connected')
	get_tree().connect("network_peer_connected", self, '_client_disconnected')
	
	get_tree().connect("connected_to_server", self, "_connected_ok")
	get_tree().connect("connection_failed", self, "_connected_fail")
	get_tree().connect("server_disconnected", self, "_server_disconnected")

func _client_connected(id):
	print('>> Um novo client entrou: ', id)

func _client_disconnected(id):
	print('-- O  client ', id, ' saiu')

func _connected_ok():
	$Chat/Label.text = ""

func _connected_fail():
	pass

func _server_disconnected():
	pass


func _on_Connect_pressed():
#	var peer = NetworkedMultiplayerENet.new()
#	peer.create_client($NetworkHUD/Address.text, GameValues.SERVER_PORT)
#	get_tree().network_peer = peer
	
	_connect_hud_ok(false)

func _on_Disconnect_pressed():
	get_tree().network_peer = null
	
	_connect_hud_ok(true)

func _connect_hud_ok(value : bool):
	$NetworkHUD/Connect.visible = value
	$NetworkHUD/Connect/Address.editable = value
	$NetworkHUD/Connect/Connect.disabled = not value
	
	$NetworkHUD/Disconnect.visible = not value
	$NetworkHUD/Disconnect/Disconnect.disabled = value

func _on_Send_pressed():
	var msg = $Chat/Message.text
	rpc("add_message", msg)

remotesync func add_message(message : String):
	var who = get_tree().get_rpc_sender_id()
	$Chat/Label.text += str(who) + ": " + message + "\n"

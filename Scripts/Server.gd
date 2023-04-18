extends Node2D

func _ready():
	get_tree().connect("network_peer_connected", self, '_client_connected')
	get_tree().connect("network_peer_connected", self, '_client_disconnected')
	
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(GameValues.SERVER_PORT, GameValues.MAX_CLIENTS)
	get_tree().network_peer = peer

func _client_connected(id):
	print('>> Um novo client entrou: ', id)
	
func _client_disconnected(id):
	print('-- O  client ', id, ' saiu')

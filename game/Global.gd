extends Node

signal coin_collected(coint)

var can_move = false
var can_attack = false
var is_dialogue_open = false
var can_open_shop = false
var paused = false


@onready var ket_hit = $ket_hit
@onready var hammer_hit = $hammer_hit

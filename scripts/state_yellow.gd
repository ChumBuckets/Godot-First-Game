extends Node

@onready var state_1: AnimatableBody2D = $State1
@onready var state_2: AnimatableBody2D = $State2
@onready var state_3: AnimatableBody2D = $State3
@onready var state_4: AnimatableBody2D = $State4

func call_states():
	state_2.state_swap()
	state_4.state_swap()

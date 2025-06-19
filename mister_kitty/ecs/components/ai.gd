class_name AI
extends Node

enum BehaviorType { idle, chase, patrol }

var behavior: BehaviorType = BehaviorType.idle
var target: Node2D = null

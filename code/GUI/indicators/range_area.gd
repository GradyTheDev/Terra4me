extends ColorRect

const IndicatorRangeColor = GlobalEnums.IndicatorRangeColor

const ORDERING_INDEX_MAP = {
	IndicatorRangeColor.RED: 1,
	IndicatorRangeColor.ORANGE: 2,
	IndicatorRangeColor.GREEN: 3,
}

@export var color_red: Color
@export var color_orange: Color
@export var color_green: Color

var indicator_color: IndicatorRangeColor:
	set(new):
		indicator_color = new
		if not is_node_ready():
			await self.ready
		self.color = color_dict[indicator_color]
		self.z_index = ORDERING_INDEX_MAP[indicator_color]

@onready var color_dict = {
	IndicatorRangeColor.RED: color_red,
	IndicatorRangeColor.ORANGE: color_orange,
	IndicatorRangeColor.GREEN: color_green,
}

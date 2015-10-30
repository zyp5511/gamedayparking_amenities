function sort_by_low_cost(a, b) {
	if (a.cost < b.cost)
		return -1;
	else if (a.cost > b.cost)
		return 1;
	return 0
}

function sort_by_high_cost(a, b) {
	if (a.cost < b.cost)
		return 1;
	else if (a.cost > b.cost)
		return -1;
	return 0
}

function sort_by_low_distance(a, b) {
	if (a.distance < b.distance)
		return -1;
	else if (a.distance > b.distance)
		return 1;
	return 0
}

function sort_by_high_distance(a, b) {
	if (a.distance < b.distance)
		return 1;
	else if (a.distance > b.distance)
		return -1;
	return 0
}


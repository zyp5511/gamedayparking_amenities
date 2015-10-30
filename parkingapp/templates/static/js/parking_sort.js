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

function filter_by_bathroom(a) {
    return a.amenities.bathroom;
}
function filter_by_yard(a) {
    return a.amenities.yard;
}
function filter_by_grill(a) {
    return a.amenities.grill;
}
function filter_by_electricity(a) {
    return a.amenities.electricity;
}
function filter_by_table(a) {
    return a.amenities.table;
}

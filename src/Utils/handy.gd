extends Node
## Miscellaneous helper functions


## `map` takes a function and a list and returns the list
## created by calling that function on the elements of that list
static func map(f: Callable, l: Array) -> Array:
	var result = []
	for e in l:
		result.push_back(f.call(e))
	return result

## `mapv` takes a function and a list of arg lists and returns the list
## created by calling that function with each arg list in the list
static func mapv(f: Callable, ll: Array) -> Array:
	var result = []
	for el in ll:
		result.push_back(f.callv(el))
	return result

## `walk` takes two values and returns an increasing 
## range between them. Optional third argument to set inclusive
## e.g. walk(3, 0) and walk(0, 3) -> range(0, 3)
static func walk(a, b, inclusive : bool = false) -> Array:
	var l = a if a <= b else b
	var r = b if l == a else b
	
	if inclusive:
		r += 1
	
	return range(l, r)

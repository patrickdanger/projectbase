###

	example.coffee
	
	included as part of the projectbase repo to show how coffee scripts can
	be easily dropped into (or created within) the src/coffee directory and
	become immediately available to the included webserver.
	
	if you're running the webserver included in projectbase, simply point
	your browser at http://localhost:8080/example.coffee to see how the 
	server will compile and serve this coffee-script.
	
	if you want to learn more about CoffeeScript and why it's triple-a boss
	money game, i encourage you to spend some time on the incredible helpful
	site that Jeremy put together at:
	
		http://jashkenas.github.com/coffee-script/#overview
	
	this example is ripped straight from: 

		http://jashkenas.github.com/coffee-script/#overview

###

# Assignment:
number   = 42
opposite = true

# Conditions:
number = -42 if opposite

# Functions:
square = (x) -> x * x

# Arrays:
list = [1, 2, 3, 4, 5]

# Objects:
math =
  root:   Math.sqrt
  square: square
  cube:   (x) -> x * square x

# Splats:
race = (winner, runners...) ->
  print winner, runners

# Existence:
alert "I knew it!" if elvis?

# Array comprehensions:
cubes = (math.cube num for num in list)
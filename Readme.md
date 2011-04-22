# projectbase

Standard node.js basic project setup with included webserver that dynamically
compiled [jade][1], [stylus][2] and [CoffeeScript][3] source files on request.

Basically, this whole project was an effort to put together a basic environment
in which I could go start prototyping immediately and easily debug without
worrying about setting up the various watch commands to monitor source changes.
Projectbase, with it's built-in webserver and dynamic source compilation, 
allows get to the business of doing your business with as little friction as
possible.

[1]: http://jade-lang.com/
[2]: http://learnboost.github.com/stylus/
[3]: http://jashkenas.github.com/coffee-script/

### Installation

Check out projectbase:

	git://github.com/patrickdanger/projectbase.git
	
Change into the projectbase directory:

	$: cd projectbase

Run the server:

	$: bin/server
	
Open the following in your browser to verify:

	http://localhost:8080/index.html
	
That's it.


### Using dynamically compiled source files

The included webserver supports dynamic compilation of jade, stylus
and CoffeeScript source at request time.  When the server receives 
a request for files of these types (.jade, .styl, .coffee) it 
automatically translates the path of the request into the respective
source directories, compiles the requested source (if found) and 
returns the result of the compilation with the correct mimetype.

	type		directory		mimetype
	----------------------------------------------------
	.jade		src/jade/		text/html
	.styl		src/stylus/		text/css
	.coffee		src/coffee/		application/x-javascript

#### Caveat

Currently, the include path is not set for files in these directories
that include other files, ie: stylus @import url's or CoffeeScript 
require() calls.  These paths must be set relative to the directory
you are running the server command from, ie: projectbase/.

I'm working on it.


### Todo

*	Add the query string to the local environment passed to jade
	source at compilation.
*	Add the appropriate directory root to the local environment
	at compile time, so that relative includes in source files
	are considered relative to the source file itself, rather than
	where the server command was executed.
* 	Build out a configuration file and command-line argument pattern
	to allow changing ports, setting webroot and srcroot
*	Pull the server into it's own object
*	Add dynamic file type to mimetype resolution
*	Add support for automatic index file resolution, ie: currently
	when you request a directory you get an error, I want to add
	in support for resolution to index.extension files.
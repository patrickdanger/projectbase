
url		= require 'url'
fs 		= require 'fs'
path 	= require 'path'
jade	= require 'jade'
stylus	= require 'stylus'
coffee 	= require 'coffee-script'

###
	//	FileFactory
	//
	//	builds out File objects based on the type (if it can be determined) from
	//	the file path provided.  Also provides facilities for setting base paths
	//	for raw markup and source files.
	//
	//	if you have a lot of different directories, scattered about for these types
	//	of files, it's recommended to instantiate more factories, ie: one factory
	//	for development, one factory for staging, etc.
###
exports.FileFactory = class FileFactory
	constructor:	(webroot = "webroot", srcroot = "src") ->
		@webroot = webroot
		@srcroot = srcroot
	file:			(filepath) ->
		type = path.extname(filepath).substr 1, path.extname(filepath).length
		switch type
			when 'html' 	then new HtmlFile path.join(@webroot, filepath), 'text/html'
			when 'css'		then new CssFile path.join(@webroot, filepath), 'text/css'
			when 'js'		then new JavaScriptFile path.join(@webroot, filepath), 'application/x-javascript'
			when 'styl'		then new StylusFile path.join(@srcroot, 'stylus', filepath), 'text/css'
			when 'coffee'	then new CoffeeFile path.join(@srcroot, 'coffee', filepath), 'application/x-javascript'
			when 'jade'		then new JadeFile path.join(@srcroot, 'jade', filepath), 'text/html'
			when 'otf'		then new FontFile path.join(@webroot, filepath), 'font/opentype'
			else			new File path.join(@webroot, filepath), null

###
	//	File
	//	The base file object.  If there's a filetype we don't know how to deal with, 
	//	this object will provide basic support for rendering to buffer.
###		
exports.File = class File
	constructor: 	(@filepath, @type) -> @name = path.basename @filepath
	toString:		() -> "#{@filepath}"
	render: 		(buffer) ->
		fs.readFile @filepath, (err, data) ->
			if err then buffer "#{err}"
			else buffer data


###
	// 	File Objects
	//
	// 	If there's a file type that requires special processing before rendering out
	//	out to buffer, you can subclass File and override the render(buffer) 
	//	function (where buffer is a stream to which strings can be written).
###
exports.HtmlFile 		= class HtmlFile extends File
	render: 		(buffer) ->		fs.readFile @filepath, 'utf8', (err, data) ->
										if err then buffer "#{err}"
										else buffer data
										
exports.CssFile 		= class CssFile extends File
	render: 		(buffer) ->		fs.readFile @filepath, 'utf8', (err, data) ->
										if err then buffer "#{err}"
										else buffer data
										
exports.JavaScriptFile 	= class JavaScriptFile extends File
	render: 		(buffer) ->		fs.readFile @filepath, 'utf8', (err, data) ->
										if err then buffer "#{err}"
										else buffer data

exports.FontFile 		= class FontFile extends File
	render:			(buffer) ->		fs.readFile @filepath, (err, data) ->
										if err then buffer "#{err}"
										else buffer data

exports.StylusFile 		= class StylusFile extends CssFile
	render: 		(buffer) ->		fs.readFile @filepath, 'utf8', (err, data) ->
										if err then buffer "#{err}"
										else 
											stylus(data)
												.set('paths', [__dirname + '/../src/stylus'])
												.render (err, css) ->
													if err then buffer "#{err}"
													else buffer css

exports.CoffeeFile 		= class CoffeeFile extends JavaScriptFile
	render: 		(buffer) ->		fs.readFile @filepath, 'utf8', (err, data) ->
										if err then buffer "#{err}"
										else buffer coffee.compile data

exports.JadeFile 		= class JadeFile extends HtmlFile
	render: 		(buffer, req) -> 	fs.readFile @filepath, 'utf8', (err, data) ->
											if err then buffer "#{err}"
											else
												fn = jade.compile data
												buffer fn { query: url.parse(req.url, yes).query }
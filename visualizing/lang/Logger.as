import lang.*

class lang.Logger {
	private static var allAppenders: Object = new Object()
	
	private var appenders: Array
	
	function Logger(name: String) {
		name = name.toLowerCase()
		if (allAppenders[name] == undefined)
			allAppenders[name] = new Array()
			
		appenders = allAppenders[name]
	}
	
	function info(s: String) {
		log(s)
	}
	
	private function log() { 
		for (var i = 0; i < appenders.length; i++) {  
			appenders[i].apply(null, arguments)
		}
	}
	
	
	function addAppender(f: Function) {
		appenders.push(f)
	}
	
}
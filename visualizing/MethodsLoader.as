import lang.*

class MethodsLoader {
	private static var _lol = new FuncInvoker(init)
	private static function init() {
		_global.setInterval(load, 3000)
		_global.setTimeout(load, 0)
	}
	
	static function load(onLoad: Function) { 
		_global._rootUrl.request("methods", function(s){ return s.split("\n") })
			.send(function(methods){ 
				if (!Objects.equals(methods, _global._methods)) { 
					new Logger("stage").trace(methods.length + " methods available")
					_global._methods = methods 
					onLoad() 
				}
			})
	}
}
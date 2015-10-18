import lang.*

class MethodsLoader {
	static function load(onLoad: Function) {
		_global._rootUrl.request("methods", function(s){ return s.split("\n") })
			.send(function(methods){ 
				if (!Objects.equals(methods, _global._methods)) { 
					new Logger("stage").trace("New methods available")
				}
				_global._methods = methods 
				onLoad() 
			})
	}
}
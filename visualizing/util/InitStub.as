import lang.*

class util.InitStub {
	static function watch(obj: Object, prop: String): Void {
		var calls = new Array()
		if (obj[prop] != undefined) return
		
		function(s: Function, name: String) {
			if (name != prop) return s(name)
			return function() {
				calls.push(arguments)
			}
		}.override(obj, "__resolve")
		
		obj.watch(prop, function(name, oldVal, newVal){ 
			if (newVal != undefined) {
				obj.unwatch(name)
				new Stream(calls).forEachArg(function(args){ newVal.apply(obj, args) })
			}
			return newVal
		})
	}
	
	static function laterCall(obj: Object, prop: String): Function {
		var calls = new Array()
		var old = obj[prop]
		
		obj[prop] = function() {
			calls.push(arguments)
		}
		
		return function(){ 
			new Stream(calls).forEachArg(function(args){ old.apply(obj, args) })
			obj[prop] = old
		}
	}
	
}
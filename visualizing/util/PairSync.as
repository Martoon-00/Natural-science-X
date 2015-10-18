import lang.*
import globals.*

class util.PairSync {
	private var r1: Reference
	private var r2: Reference
	
	private var value: Object
	
	function PairSync(r1: Reference, r2: Reference, initValue: Object) {
		this.r1 = r1;
		this.r2 = r2;
		
		value = Optional.of(initValue).orElse(r1.get())
		Timing.addEnterFrame(function(){ trace(0) })
	}
	
	
	
	
	
}
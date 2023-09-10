package haxeal.bindings;

import haxe.macro.Compiler;
import haxe.macro.Context;
import haxe.macro.Expr;

using haxe.macro.Tools;
using StringTools;

class EFXBuilder {
    public static macro function buildFunctions():Array<Field> {
        var fields:Array<Field> = Context.getBuildFields();
		var newFields:Array<Field> = [];
		trace(macro untyped __cpp__('({1})alGetProcAddress ({0})', 'swag', 'int'));
        
		var efxFuncs:Map<String, String> = [];
        for(field in fields) {
            var ignoreField:Bool = true;
            var alFuncName:String = '';

			newFields.push(field);
            for (data in field.meta) {
				if (data.name != 'efxFunc')
					continue;

				ignoreField = false; // Hooray, our field has the efxFunc annotation
                alFuncName = data.params[0].getValue();
			}

			if (ignoreField) continue;
			
			var args:Array<ComplexType> = [];
			var retType:ComplexType;
			switch(field.kind) {
				case FFun(f):
					for(arg in f.args) args.push(arg.type); // Get original function arguments

					retType = f.ret ?? macro : Void; // Get original function return type
				default:
			}

			newFields.remove(field); // Remove old function field, now replace with a variable function

			// Create fake variable function that will host our efx function address
			//var expr = macro $i{field.name} = cast $p{["HaxeAL", "getProcAddress"]}($v{alFuncName});
			var funField:Field = {
				name: field.name,
				access: [AStatic, APublic],
				kind: FVar(TFunction(args, retType), null), // Insert original function args and ret, we leave out the expr
				pos: Context.currentPos()
			};

			efxFuncs.set(field.name, alFuncName);
			newFields.push(funField);

			// !! IDEA:
			/*
			Setup a function that uses the ${i} identifier reification and try and call it in the same context?? i dont know this is destroying my brain
			*/
        }

		// THIS ONLY WORKS BECAUSE THE MACRO IS INVOKED SEPERATELY OUTSIDE OF THE FOR LOOP!! OTHERWISE THE VARIABLES WOULDNT BE RECOGNIZED!!
		var casts = [ for(name=>alAddress in efxFuncs) macro $i{name} = cast $p{["HaxeAL", "getProcAddress"]}($v{alAddress}) ];
		var initFun = macro function setupEfx() {
			$b{casts}; // Create a block out of the different cast expressions
			trace('Set up EFX properly!');
		};

		var rawFunc = switch (initFun.expr) {
			case EFunction(kind, fun): fun;
			default: throw '';
		};

		final funcField:Field = {
			name: 'setupEFX',
			kind: FFun(rawFunc),
			pos: Context.currentPos(), // This will do
			access: [AStatic, APublic]
		};
		newFields.push(funcField);

        return newFields;
    }

	//public static macro function setupEFX() {
		/*var variables = Context.getLocalVars();
		for (name=>type in variables) {
			$i{name} = cast $i{'HaxeAL.getProcAddress'};
		}

		return macro function _();*/
	//}
}
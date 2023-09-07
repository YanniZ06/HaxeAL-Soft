package haxeal.bindings;

import haxe.macro.Compiler;
import haxe.macro.Context;
import haxe.macro.Expr;

using haxe.macro.Tools;
using StringTools;

class EFXBuilder {
    public static macro function buildFunctions():Array<haxe.macro.Field> {
        var fields:Array<Field> = Context.getBuildFields();
        
        for(field in fields) {
            var ignoreField:Bool = true;
            var alFuncName:String = '';

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

			fields.remove(field); // Remove old function field, now replace with a variable function

			// Create fake variable function that will host our efx function address
			var funField:Field = {
				name: field.name,
				access: [AStatic, APublic],
				kind: FVar(TFunction(args, retType), null), // Insert original function args and ret, expr doesnt need to be set
				pos: Context.currentPos()
			};

			// !! IDEA:
			/*
			Setup a function that uses the ${i} identifier reification and try and call it in the same context?? i dont know this is destroying my brain
			*/


            /*
			final fName:String = 'set_${field.name}';
			final type = cast(field.kind.getParameters()[0], ComplexType).getParameters()[0].name;
			var func = macro function $fName(val : Dynamic):Dynamic {
				$i{field.name} = val;
                $i{'changeParam'}($v{fxID}, val); //Very trippy
				return val;
			};

			// I happened to switch to patterns here just to spare me the constant parameter getting.
			var rawFunction:Function = func.expr.getParameters()[1];
			switch (rawFunction.ret) { // Turn return type to proper type
				case TPath(pth):
					pth.name = type;
				default:
			}
			switch (rawFunction.args[0].type) { // Turn setter argument type to proper type
				case TPath(pth):
					pth.name = type;
				default:
			}

            var setAccess = field.access.copy();
            if(setAccess != null) setAccess.remove(APublic); //Avoid it showing up on vsCode completion
			final funcField:Field = {
				name: fName,
				kind: FFun(rawFunction),
				pos: Context.currentPos(), // This will do
				access: setAccess
			};

			fields.push(funcField);

			final oldkind = field.kind;
			field.kind = FProp('default', 'set', oldkind.getParameters()[0], oldkind.getParameters()[1]);
            */
        }
        return fields;
    }

	public static macro function setupEFX() {
		/*var variables = Context.getLocalVars();
		for (name=>type in variables) {
			$i{name} = cast $i{'HaxeAL.getProcAddress'};
		}

		return macro function _();*/
	}
}
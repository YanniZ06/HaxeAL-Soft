package haxeal.bindings;

import haxe.macro.Compiler;
import haxe.macro.Context;
import haxe.macro.Expr;

using haxe.macro.ExprTools;
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

				ignoreField = false; // Hooray, our field has the fxParam annotation
                alFuncName = data.params[0].getValue();
			}

			if (ignoreField)
				continue;

            trace(alFuncName);

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
}
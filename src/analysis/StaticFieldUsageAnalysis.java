package analysis;

import soot.*;
import soot.jimple.StaticFieldRef;
import java.util.Map;
import java.util.*;



// Intra-procedural static analysis
public class StaticFieldUsageAnalysis extends SceneTransformer {

	@Override
	protected void internalTransform(String phasename, Map<String, String> options) {
		Set<SootField> staticFields = new HashSet<>();
		Set<SootField> usedStaticFields = new HashSet<>();

			// 1. Collect all static fields
			for (SootClass sc : Scene.v().getApplicationClasses()) {
				for (SootField f : sc.getFields()) {
					if (f.isStatic()) {
						staticFields.add(f);
					}
				}
			}

			// 2. Scan all methods to see which static fields are used
			for (SootClass sc : Scene.v().getApplicationClasses()) {
				for (SootMethod method : sc.getMethods()) {
					if (!method.isConcrete()) continue;

					Body body = method.retrieveActiveBody();
					for (Unit unit : body.getUnits()) {
						for (ValueBox vb : unit.getUseBoxes()) {
							Value v = vb.getValue();
							if (v instanceof StaticFieldRef) {
								SootField f = ((StaticFieldRef) v).getField();
								usedStaticFields.add(f);
							}
						}
					}
				}
			}

			// 3. Print results
			System.out.println("  Total static fields: " + staticFields.size());
			System.out.println("  Used static fields: " + usedStaticFields.size());
			System.out.println("  Unused static fields: " + (staticFields.size() - usedStaticFields.size()));
	}
}


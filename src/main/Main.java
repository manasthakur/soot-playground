package main;

import soot.*;
import soot.options.Options;
import soot.jimple.*;
import soot.toolkits.scalar.*;
import soot.toolkits.graph.*;

import java.util.*;
import analysis.StaticFieldUsageAnalysis;

public class Main {

	public static void main(String[] args) {

		// Initialize Soot arguments
		GetSootArgs g = new GetSootArgs();
		String[] sootArgs = g.get(args);

		if (sootArgs == null) {
			System.out.println("Unable to generate args for soot!");
			return;
		}
		
		//kafka
		 Scene.v().addBasicClass("scala.runtime.java8.JFunction1$mcJJ$sp",SootClass.HIERARCHY);
		 Scene.v().addBasicClass("scala.runtime.java8.JFunction1$mcZJ$sp",SootClass.HIERARCHY);
		 Scene.v().addBasicClass("scala.runtime.java8.JFunction0$mcD$sp",SootClass.HIERARCHY);
		 Scene.v().addBasicClass("scala.runtime.java8.JFunction2$mcZII$sp",SootClass.HIERARCHY);
		 Scene.v().addBasicClass("scala.runtime.java8.JFunction1$mcVD$sp",SootClass.HIERARCHY);
				
		// h2o
		Scene.v().addBasicClass("water.codegen.CodeGenerator",SootClass.HIERARCHY);

		System.out.println("\nPerforming Analysis: ");
		System.out.println("========================");
		
		// Inter-procedural static analysis
		StaticFieldUsageAnalysis sfa = new StaticFieldUsageAnalysis();
		PackManager.v().getPack("wjtp").add(new Transform("wjtp.staticFieldUsage", sfa));

		Options.v().parse(sootArgs);
		Scene.v().loadNecessaryClasses();
		Scene.v().loadDynamicClasses();
		PackManager.v().runPacks();
		// soot.Main.main(sootArgs);

	}
}
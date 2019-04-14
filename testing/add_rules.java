// Internal action code for project connect4.mas2j

package testing;

import jason.*;
import jason.asSemantics.*;
import jason.asSyntax.*;

import java.io.File;
import java.io.FileNotFoundException;

public class add_rules extends DefaultInternalAction {

	private String test_file_path = "player.asl";
	
    @Override
    public Object execute(TransitionSystem ts, Unifier un, Term[] args) throws Exception {
        
		Agent ag = ts.getAg();
		File test_source_file;
		
		//First we eliminate all previous rules
		ag.getLogger().info("Deleting previous rules...");
		ag.getBB().clear();
		ag.addInitialBelsInBB();
		ag.getLogger().info("Rules deleted.");
		
		
		//First we eliminate all previous rules
		ag.getLogger().info("Adding new rules...");
		test_source_file = new File(test_file_path);
		
		
		//Check if the source file exists and is not a directory
		if (test_source_file.exists() && !test_source_file.isDirectory()) {
			ag.parseAS(test_source_file);
			ag.addInitialBelsInBB();
			ag.getLogger().info("Rules added.");
		}
		else {	// If the file doesn't exist or is a directory
			ag.getLogger().info("Source file for rules not valid, check source path: "
				+ test_file_path);
		}
		
		
        // everything ok, so returns true
        return true;
    }
}


/*
 * Add the scripts and build folders to your environment variable.
 * Then you can use the command `temp <location> <name> <project type>`
 */

#include <iostream>
#include <vector>

// Struct to define the Template type 
struct Template {
	std::string type;
	std::string path_to_script;
	Template(std::string type, std::string path_to_script): type(type), path_to_script(path_to_script){}
};

// params(list of Templates, type, and path_to_script)
void push_to_template_list(std::vector<Template*> *template_list, std::string type, std::string path_to_script) {
	template_list->push_back(new Template(type, path_to_script));
}

// Find the template to coresponding to the input type
std::string match_input_to_template(std::vector<Template*> template_list, std::string type) {
	for (auto temp : template_list)
		if (temp->type == type)
			return temp->path_to_script;
	return "";
}

int main(int argc, char **argv) {

	// Initialize a template vector and push an element
	std::vector<Template*> temp;
	push_to_template_list(&temp, "c-lang", "new_project_c.sh");
	push_to_template_list(&temp, "cpp-lang", "new_project_cpp.sh");
	push_to_template_list(&temp, "express", "new_project_expressjs.sh");
	push_to_template_list(&temp, "p5", "new_project_p5js.sh");


	// Error handling for bad arguments input
	if (argc == 1) {
		puts("Usage: temp <location> <name> <language/framework>");
		exit(1);
	}

	// TODO Add `help` command
	if (argc == 2) {
		std::string help = argv[1];
		if (help == "help") {
			// Handle help command
			puts("Usage: temp <location> <name> <language>");
			puts("\nWhere:");
			puts("\n <location> - the location on your computer where you want to make the templated project");
			puts("\n <name> - the name of the folder containing the templated project");
			puts("\n <language> - one of [c-lang, cpp-lang, express, p5]");	
			puts("\nExample: temp ./Projects name-project c-lang");
			exit(2);
			return 2;
		}
	}

	// Get the path to the appropriate script and end the program if no match is found
	std::string path = match_input_to_template(temp, argv[3]);
	if (path == "" || path.size() == 0) {
		puts("Incorrect template type. Types: ['c-lang', 'cpp-lang', 'express', 'p5']");
		exit(3);
		return 3;
	}

	// Change specified name to c++ string
	std::string name = argv[2];

	// Change directory into specified path
	std::string directory = argv[1];

	// Format the script and run it
	std::string script = "bash " + path + " " + directory + " " + name;
	system(script.c_str());
	return 0;
}

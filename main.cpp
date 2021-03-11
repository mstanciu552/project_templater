#include <iostream>
#include <vector>

// Struct to define a type 
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
	push_to_template_list(&temp, "c-lang", "scripts/new_project_c.sh");

	// Error handling for bad arguments input
	if (argc == 1) {
		puts("Usage: temp <location> <language/framework>");
		exit(1);
	}

	// Get the path to the appropriate script and end the program if no match is found
	std::string path = match_input_to_template(temp, argv[2]);
	if (path == "" || path.size() == 0) {
		puts("Incorrect template type. Types: ['c-lang']");
		exit(2);
		return 2;
	}

	// Change directory into specified path
	std::string directory = argv[1];

	// Format the script and run it
	std::string script = "bash " + path + " " + directory;
	system(script.c_str());
	return 0;
}
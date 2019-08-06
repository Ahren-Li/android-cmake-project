#include <iostream>
#include <fstream>

int main(int argc, char** argv) {
    if(argc < 1) return -1;

    std::ifstream infile(argv[1]);
    std::string line;
    while (std::getline(infile, line)){
        if(line.find("//") != std::string::npos){
            continue;
        }
        std::cout << line << std::endl;
    }
    infile.close();
    return 0;
}
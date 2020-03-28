#include <iostream>
#include <fstream>

#define debug 0

int main(int argc, char** argv) {
    if(argc < 1) return -1;

    std::ifstream infile(argv[1]);
    std::string line;
    while (std::getline(infile, line)){
#if debug
        std::cout << "1:" << line << std::endl;
#endif
        line.erase(0,line.find_first_not_of(' '));
        line.erase(line.find_last_not_of(' ') + 1);
#if debug
        std::cout << "2:" << line << std::endl;
#endif
        size_t index = line.find("//");
#if debug
        std::cout << "3:index=" << std::to_string(index) << std::endl;
#endif
        if(index == 0){
            continue;
        }else if( index != std::string::npos){
            line.erase(index, line.length());
        }
        std::cout << line << std::endl;
    }
    infile.close();
    return 0;
}
#include <iostream>
#include <fstream>
#include <vector>
#include <algorithm>
#include <string>
#include <sstream>

std::vector<double> read_csv(const std::string& filename) {
    std::ifstream data(filename);
    std::string line;
    std::vector<double> rainfall;

    while(std::getline(data, line)) {
        std::stringstream lineStream(line);
        std::string cell;

        std::getline(lineStream, cell, ','); // Skip the date/identifier
        std::getline(lineStream, cell, ','); // Get the rainfall data

        rainfall.push_back(std::stod(cell));
    }

    return rainfall;
}

void calculate_deciles(const std::vector<double>& data) {
    std::vector<double> sorted_data(data);
    std::sort(sorted_data.begin(), sorted_data.end());

    std::cout << "Deciles:\n";
    for (int i = 1; i <= 9; ++i) {
        int idx = int(i * (sorted_data.size() - 1) / 10.0);
        std::cout << "Decile " << i << ": " << sorted_data[idx] << "\n";
    }
}

int main() {
    std::string filename;
    std::cout << "Enter CSV filename: ";
    std::cin >> filename;

    std::vector<double> rainfall_data = read_csv(filename);
    calculate_deciles(rainfall_data);

    return 0;
}


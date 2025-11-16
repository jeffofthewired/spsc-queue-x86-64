#include <iostream>
#include <cstdint>
#include "spsc_queue.h"

int main() {
    uint64_t buffer[2048];
    spsc_queue q{buffer, 2048};
    std::cout << "hello world" << std::endl;
}


#include <iostream>
#include <cstdint>
#include "spsc_queue.h"

int main() {
    uint64_t buffer[2048];
    spsc_queue q{buffer, 2048};
    std::cout << "hello world" << std::endl;
    q.size();

    // dump all the member variables
    std::cout << "capacity: " << q.capacity_ << std::endl;
    std::cout << "push_cursor: " << q.push_cursor_ << std::endl;
    std::cout << "pop_cursor: " << q.pop_cursor_ << std::endl;
    std::cout << "cached_push_cursor: " << q.cached_push_cursor_ << std::endl;
    std::cout << "cached_pop_cursor: " << q.cached_pop_cursor_ << std::endl;
}


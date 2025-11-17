#include <iostream>
#include <cstdint>
#include "spsc_queue.h"

int main() {
    uint64_t buffer[2048];
    spsc_queue q{buffer, 2048};
    std::cout << "hello world" << std::endl;
    q.push(67);
    q.push(420);
    q.push(69);
    q.push(21);
    q.push(187);

    uint64_t popped1;
    uint64_t popped2;
    q.pop(popped1);
    q.pop(popped2);
    std::cout << "popped1: " << popped1 << std::endl;
    std::cout << "popped2: " << popped2 << std::endl;

    // dump all the member variables
    std::cout << "BEGIN MEMBER VARIABLE DUMP" << std::endl;
    std::cout << "capacity: " << q.capacity_ << std::endl;
    std::cout << "push_cursor: " << q.push_cursor_ << std::endl;
    std::cout << "pop_cursor: " << q.pop_cursor_ << std::endl;
    std::cout << "cached_push_cursor: " << q.cached_push_cursor_ << std::endl;
    std::cout << "cached_pop_cursor: " << q.cached_pop_cursor_ << std::endl;
    std::cout << "END MEMBER VARIABLE DUMP" << std::endl;

    // dump some of the buffer
    std::cout << "BEGIN BUFFER DUMP" << std::endl;
    for (int i = 0; i < 10; ++i) {
        std::cout << buffer[i] << std::endl;
    }
    std::cout << "END BUFFER DUMP" << std::endl;
}


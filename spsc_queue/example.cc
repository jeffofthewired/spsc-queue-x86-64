#include <iostream>
#include <cstdint>
#include <vector>
#include <thread>
#include <numeric>
#include <algorithm>
#include "spsc_queue.h"

int main() {
    constexpr std::size_t k_buffer_size = 2048;
    constexpr std::size_t k_seq_length = 10000;

    // setting up the queue
    uint64_t buffer[k_buffer_size];
    spsc_queue q{buffer, k_buffer_size};

    // producer
    std::vector<uint64_t> input(k_seq_length, 0);
    std::iota(input.begin(), input.end(), 1);
    auto producer = [](spsc_queue *q_ptr, std::vector<uint64_t> *input_ptr){
        auto& q = *q_ptr;
        auto& input = *input_ptr;

        auto it = input.cbegin();
        while (it != input.cend()) {
            if (q.push(*it)) ++it;
        }
    };

    // consumer
    std::vector<uint64_t> output(k_seq_length, 0);
    auto consumer = [](spsc_queue *q_ptr, std::vector<uint64_t> *output_ptr){
        auto& q = *q_ptr;
        auto& output = *output_ptr;

        auto it = output.begin();
        int fails_in_a_row = 0;
        while (it != output.end()) {
            auto success = q.pop(*it);
            if (success) {
                ++it;

            // TIMEOUT mechanism
                fails_in_a_row = 0;
            } else {
                ++fails_in_a_row;
                if (fails_in_a_row > 1000000) {
                    std::cout << "TIMED OUT" << std::endl;
                    break;
                }
            }
        }
    };

    // run concurrently
    std::thread p(producer, &q, &input);
    std::thread c(consumer, &q, &output);
    p.join();
    c.join();

    // check for inconsistencies in input and output
    for (std::size_t i = 0; i < k_buffer_size; ++i) {
        if (input[i] != output[i]) {
            std::cout << "Inconsistency found at index: " << i << std::endl;
            std::cout << "BUFFER DUMP: " << std::endl;

            std::size_t dump_start = i-50 > 0 ? i-50 : 0;
            for (auto j = dump_start; j < dump_start + 100 && j < k_buffer_size; ++j) {
                if (j == i) std::cout << std::endl;
                std::cout << "[" << j << "]:\t\t" << input[j] << ", " << output[j] << std::endl;
                if (j == i) std::cout << std::endl;
            }
            break;
        }
    }

    std::cout << "Test done!" << std::endl;
}

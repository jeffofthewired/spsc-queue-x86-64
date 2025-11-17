#include <gtest/gtest.h>
#include <cstdint>
#include <vector>
#include <thread>
#include <numeric>
#include "spsc_queue.h"

TEST(Concurrency, Stuff) {
    constexpr std::size_t k_buffer_size = 2048;
    constexpr std::size_t k_seq_length = 10000;


    // setting up the queue
    uint64_t buffer[k_buffer_size];
    spsc_queue q{buffer, k_buffer_size};

    // producer
    std::vector<uint64_t> input(k_seq_length, 0);
    std::iota(input.begin(), input.end(), 1);
    auto producer = [](spsc_queue& q, std::vector<uint64_t>& input){

    };

    // consumer
    std::vector<uint64_t> output(k_seq_length, 0);
    auto consumer = [](spsc_queue& q, std::vector<uint64_t>& output){

    };

    // run concurrently
    std::thread p(producer, q, input);
    std::thread c(consumer, q, output);
    p.join();
    c.join();

    // assert that input == output
    EXPECT_EQ(1, 1);
}

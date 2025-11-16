#pragma once

#include <cstdint>

constexpr uint64_t cache_line_size = 64;

// struct is aligned to 64 bytes (cache_line_size)
class spsc_queue {
public:
    using size_type = uint64_t;
    using value_type = uint64_t;

public:
    // no vptr
    
    // bytes [0, 0+8)
    value_type *buffer_;
    // bytes [8, 8+8)
    size_type capacity_;

    // all cursors are initialized to zero
    // bytes [64, 64+8)
    alignas(cache_line_size) size_type push_cursor_;
    // bytes [72, 72+8)
    size_type cached_pop_cursor_;
    // bytes [128, 128+8)
    alignas(cache_line_size) size_type pop_cursor_;
    // bytes [136, 136+8)
    size_type cached_push_cursor_;

public:
    // special member functions "structors"
    spsc_queue(value_type *buffer, size_type capacity);
    ~spsc_queue();

    // member functions
    auto push(value_type val) -> bool;
    auto pop(value_type& ret_val) -> bool;
    auto size() const -> size_type;
    auto empty() -> bool;
    auto full() -> bool;
};

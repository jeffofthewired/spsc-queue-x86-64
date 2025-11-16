#pragma once

#include <cstdint>

constexpr uint64_t cache_line_size = 64;

// struct is aligned to 64 bytes (cache_line_size)
class spsc_queue {
public:
    using size_type = uint64_t;
    using value_type = uint64_t;

private:
    // no vptr
    // bytes [0, 0+8)
    value_type *buffer_;
    // bytes [8, 8+8)
    size_type capacity_;
    // bytes [64, 64+8)
    alignas(cache_line_size) size_type size_; // init 0

    // bytes [128, 128+8)
    alignas(cache_line_size) size_type push_cursor_; // init 0
    // bytes [136, 136+8)
    size_type cached_pop_cursor_; // init 0

    // bytes [192, 192+8)
    alignas(cache_line_size) size_type pop_cursor_; // init 0
    // bytes [200, 200+8)
    size_type cached_push_cursor_; // init 0

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

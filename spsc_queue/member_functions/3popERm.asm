; Exports
global _ZN10spsc_queue3popERm

; Offsets into spsc_queue
%define o_buffer                    0
%define o_capacity                  8
%define o_push_cursor               64
%define o_cached_pop_cursor         72
%define o_pop_cursor                128
%define o_cached_push_cursor        136

section .text

; Function Definition
; auto spsc_queue::pop(uint64_t& ret_val) -> bool;
; rdi   this
; rsi   &ret_val
_ZN10spsc_queue3popERm:
        mov     rax, 0
        ret

; Exports
global _ZNK10spsc_queue4sizeEv

; Offsets into spsc_queue
%define o_buffer                    0
%define o_capacity                  8
%define o_push_cursor               64
%define o_cached_pop_cursor         72
%define o_pop_cursor                128
%define o_cached_push_cursor        136

section .text

; Function Definition
_ZNK10spsc_queue4sizeEv:
        ; TODO: check carefully
        mov     rax, qword [rdi+o_push_cursor]
        sub     rax, qword [rdi+o_pop_cursor]
        ret

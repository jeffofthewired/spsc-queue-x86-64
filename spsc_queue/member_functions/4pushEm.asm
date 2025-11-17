; Exports
global  _ZN10spsc_queue4pushEm

; Imports
extern  _ZN10spsc_queue4fullEv

; Offsets into spsc_queue
%define o_buffer                    0
%define o_capacity                  8
%define o_push_cursor               64
%define o_cached_pop_cursor         72
%define o_pop_cursor                128
%define o_cached_push_cursor        136
; Other constants
%define k_scale                     8

section .text

; Function Definition
; auto spsc_queue::push(uint64_t value) -> bool;
;       rdi     this
;       rsi     value
_ZN10spsc_queue4pushEm:
        ; determine if queue is full with this->full()
        call    _ZN10spsc_queue4fullEv ; ABI violation
        test    rax, rax
        jne     case_full
        ;       rdx == push_cursor_ thanks to ABI violation
        mov     rax, rdx 

        case_not_full:
        ; insert the value at the push_cursor
        xor     rdx, rdx
        ;       rcx == capacity_ thanks to ABI violation
        div     rcx
        ;       rdx is now the modulo
        mov     r8, [rdi+o_buffer]
        mov     [r8+rdx*k_scale], rsi

        ; increment the push cursor
        inc     qword [rdi+o_push_cursor]

        ; return true;
        mov     rax, 1
        ret

        case_full:
        mov     rax, 0
        ret

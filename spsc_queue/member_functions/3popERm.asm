; Exports
global  _ZN10spsc_queue3popERm

; Imports
extern  _ZN10spsc_queue5emptyEv

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
; auto spsc_queue::pop(uint64_t& ret_val) -> bool;
;       rdi     this
;       rsi     &ret_val
_ZN10spsc_queue3popERm:
        ; determine if queue is empty with this->empty()
        call    _ZN10spsc_queue5emptyEv ; ABI violation
        test    rax, rax
        jne     case_empty
        ;       rdx == pop_cursor_ thanks to ABI violation
        mov     rax, rdx 

        case_not_empty:
        ; extract the value at the pop_cursor
        xor     rdx, rdx
        ;       rcx == capacity_ thanks to ABI violation
        div     rcx
        ;       rdx is now the modulo
        mov     r8, [rdi+o_buffer]
        mov     r9, [r8+rdx*k_scale]
        mov     [rsi], r9

        ; increment the pop_cursor
        inc     qword [rdi+o_pop_cursor]

        ; return true;
        mov     rax, 1
        ret

        case_empty:
        mov     rax, 0
        ret

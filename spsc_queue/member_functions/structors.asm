; Exports
global _ZN10spsc_queueC1EPmm
global _ZN10spsc_queueC2EPmm
global _ZN10spsc_queueD1Ev
global _ZN10spsc_queueD2Ev

; Offsets into spsc_queue
%define o_buffer                    0
%define o_capacity                  8
%define o_push_cursor               64
%define o_cached_pop_cursor         72
%define o_pop_cursor                128
%define o_cached_push_cursor        136

section .text

; Constructor Definition
_ZN10spsc_queueC1EPmm:
_ZN10spsc_queueC2EPmm:
        ; get address to object (rdi)
        ; initialize buffer_ with param: buffer (rsi)
        mov     qword [rdi+o_buffer], rsi
        ; initialize capacity_ with param: capacity (rdx)
        mov     qword [rdi+o_capacity], rdx
        ; initialize all the cursors to zero
        mov     qword [rdi+o_push_cursor], 0
        mov     qword [rdi+o_cached_pop_cursor], 0
        mov     qword [rdi+o_pop_cursor], 0
        mov     qword [rdi+o_cached_push_cursor], 0

        ret

; Destructor Definition
_ZN10spsc_queueD1Ev:
_ZN10spsc_queueD2Ev:
        ret

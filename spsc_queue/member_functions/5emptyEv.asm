; Exports
global  _ZN10spsc_queue5emptyEv

; Offsets into spsc_queue
%define o_buffer                    0
%define o_capacity                  8
%define o_push_cursor               64
%define o_cached_pop_cursor         72
%define o_pop_cursor                128
%define o_cached_push_cursor        136

section .text

; Function Definition
; auto spsc_queue::empty() -> bool;
;       rdi   this

; Intentional violations of SysV ABI:
;       rcx     returns capacity
;       rdx     returns pop_cursor
_ZN10spsc_queue5emptyEv:
        mov     rdx, [rdi+o_pop_cursor]
        mov     rcx, [rdi+o_capacity]
        mov     r8, rdx
        sub     r8, [rdi+o_cached_push_cursor]
        je      case_maybe_empty

case_not_empty:
        mov     rax, 0
        ret

case_maybe_empty:
        ; update the cached_push_cursor
        mov     r9, [rdi+o_push_cursor]
        mov     [rdi+o_cached_push_cursor], r9
        ; now do the same comparison
        mov     r8, rdx
        sub     r8, r9
        jne     case_not_empty

        ; certainly empty
        mov     rax, 1
        ret

; Exports
global  _ZN10spsc_queue4fullEv

section .text

; Function Definition
; auto spsc_queue::full() -> bool;
;       rdi   this

; Intentional violations of SysV ABI:
;       rcx     returns capacity
;       rdx     returns push_cursor
_ZN10spsc_queue4fullEv:
        mov     rdx, [rdi+o_push_cursor]
        mov     rcx, [rdi+o_capacity]
        mov     r8, rdx
        sub     r8, [rdi+o_cached_pop_cursor]
        cmp     r8, rcx
        je      case_maybe_full

case_not_full:
        mov     rax, 0
        ret

case_maybe_full:
        ; update the cached_pop_cursor
        mov     r9, [rdi+o_pop_cursor]
        mov     [rdi+o_cached_pop_cursor], r9
        ; now do the same comparison
        mov     r8, rdx
        sub     r8, r9
        cmp     r8, rcx
        jne     case_not_full

        ; certainly full
        mov     rax, 1
        ret

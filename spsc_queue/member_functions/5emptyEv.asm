; Exports
global  _ZN10spsc_queue5emptyEv

section .text

; Function Definition
; auto spsc_queue::empty() -> bool;
;       rdi   this

; Intentional violations of SysV ABI:
;       rcx     returns capacity
;       rdx     returns pop_cursor
_ZN10spsc_queue5emptyEv:
        ret

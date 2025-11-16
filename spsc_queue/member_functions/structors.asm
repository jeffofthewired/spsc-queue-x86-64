; Exports
global _ZN10spsc_queueC1EPmm
global _ZN10spsc_queueC2EPmm
global _ZN10spsc_queueD1Ev
global _ZN10spsc_queueD2Ev

section .text

; Constructor Definition
_ZN10spsc_queueC1EPmm:
_ZN10spsc_queueC2EPmm:
        ; get address to object (rdi)
        ; initialize buffer_ with param: buffer (rsi)
        mov     qword [rdi], rsi
        ; initialize capacity_ with param: capacity (rdx)
        mov     qword [rdi+8], rsi
        ; initialize all the cursors to zero
        mov     qword [rdi+64], 0
        mov     qword [rdi+128], 0
        mov     qword [rdi+136], 0
        mov     qword [rdi+192], 0
        mov     qword [rdi+200], 0

        ret

; Destructor Definition
_ZN10spsc_queueD1Ev:
_ZN10spsc_queueD2Ev:
        ret

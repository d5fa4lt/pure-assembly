    ; RCX => Parm1
    ; RDX => Parm2
    ; R8  => Parm3
    ; R9  => Parm4


CREATE_ALWAYS = 2
GENERIC_ALL = 10000000h


externdef CreateFileA:PROC
externdef WriteFile:PROC
externdef CloseHandle:PROC

.data 
string1 DB "H", 0, "e", 0, "l", 0, "l", 0, "o", 0, 0, 0

filename BYTE "C:\temp\helloworld.txt",0   ;change it this 
WritternBytes DWORD  ?


.code 
main PROC
	push rbp
	mov rbp, rsp
	sub rsp, 64


	lea rcx, filename
	mov rdx, GENERIC_ALL
	xor r8, r8
	xor r9, r9
	mov rax, CREATE_ALWAYS
	mov [rsp+32], rax
	xor rax, rax 
	mov [rsp+24], rax
	mov [rsp+16], rax

	call CreateFileA
	test eax, eax
	js exiting

	mov rbx,rax 


	mov rcx, rax
	lea rdx, string1
	mov r8, 12
	lea r9, WritternBytes
	xor rax, rax
	mov [rsp+32], rax

	call WriteFile
	test eax, eax
	jz exiting


	mov rcx, rbx
	call CloseHandle


exiting:
	mov rsp, rbp
	pop rbp
	ret 
main ENDP
end 
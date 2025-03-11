[ORG 0x7C00] ;; boot sector baslangici

mov ah, 0x0E ;; metin yazdirmak icin teletype modu
mov si, bootMsg

printBootMsg:
    lodsb
    cmp al, 0
    je loadKernel
    int 0x10
    jmp printBootMsg

loadKernel:
    mov ah, 0x02 ;; disk okuma
    mov al, 10
    mov ch, 0
    mov dh, 0
    mov cl, 2
    mov bx, 0x1000 ; kerneli yukleme adresi
    int 0x13 ; diskten okuma komutu
    ;; disk okuma bitis

    jc diskError ; eger hata varsa ekrana bas
    jmp 0x1000 ; kerneli yukleme adresine atla

diskError:
    mov si, errorMsg
    call printString
    jmp $

printString:
    lodsb
    cmp al, 0
    je return
    int 0x10
    jmp printString
return:
    ret

bootMsg db "Booting Kernel...", 0
errorMsg db "Disk Okuma Hatasi!", 0

times 510-($-$$) db 0
dw 0xAA55 ; boot sector imzasi
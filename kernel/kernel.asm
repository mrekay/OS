[ORG 0x1000] ; belirttigimiz kernel yukleme adresi

mov ah, 0x0E ;; teletype modu
mov si, kernelMsg

printKernelMsg:
    lodsb
    cmp al, 0 ; eger null karakter gelirse
    je done ; islemi bitir
    int 0x10
    jmp printKernelMsg

done:
    jmp $

kernelMsg db "Kernel Yuklendi!", 0 ; yazdiracagimiz metin sonrasi null karakter gonderiyoruz
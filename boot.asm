[ORG 0x7C00] ;; BOOT SECTOR ADRESİ

mov ah, 0x0E ;; Teletype moduna geçiyoruz...
mov bp, 0x8000 ;; Boot sector'den uzaga stack'i ayarliyoruz
mov sp, bp

mov si, mesaj ; yazdirilacak metin

display:
    lodsb ;si degerini AL'ye yukletiyoruz
    cmp al, 0 ; null geldiginde islemi bitir
    je done
    int 0x10 ; karakteri ekrana yazdirma kodu
    jmp display ; dongu halinde devam et

done:
    jmp $ ; sonsuz dongu

mesaj db "Merhaba Dunya", 0 ; null karakterle bitiriyoruz

times 510-($-$$) db 0 ; boot sektörü dolduruyoruz
dw 0xAA55 ;; boot sektörü bitti imzasi
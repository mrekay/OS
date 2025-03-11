boot_dongusu:
    jmp boot_dongusu

times 510-($-$$) db 0 ; geri kalan alani doldur.
dw 0xaa55 ;boot sectorun bitisi
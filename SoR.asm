          dc.l  $FFFF00,    EntryPoint, ErrorTrap,  ErrorTrap 
          dc.l  ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
          dc.l  ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
          dc.l  ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
          dc.l  ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
          dc.l  ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
          dc.l  ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
          dc.l  ErrorTrap, ErrorTrap, VBlank, ErrorTrap
          
          
          
          
          
          
          
          
          
VBlank:                                 ; $19D16
          movem.l d0-d7/a0-a6,-(sp)     ; Store registers except a7 to the stack.
          tst.w   ($FFFFFA00).w          
          beq.w   loc_1A088             
          move.b  #0,($FFFFFA00).w
          lea     ($C00004).l,a0        ; Load VDP control port to a0.
          lea     ($C00000).l,a1        ; Load VDP data port to a1.
          move.w  (a0),d0               ; Move VDP's status register value to d0.
          cmpi.b  #$2,d1
          beq.w   loc_1A07C
          move.l  #$40000010,($C00004).l ; Set VDP to VSRAM write.
          move.w  ($FFFFE00E).w,(a1)
          move.w  ($FFFFE10E).w,(a1)
          bclr    #0,($FFFFFA01).w      ; Disable CRAM DMA flag.
          beq.s   loc_19D86             ; If it wasn't on, branch.
          move.w  #$100,($A11100).l     ; Stop the Z80.
          lea     ($C00004).l,a6        ; Load VDP control port to a6.
          move.l  #$93409400,(a6)       ; Set DMA length ($0080/2 = $0040).
          move.w  #$9500,(a6)           ; Set DMA low byte  - $XXXX00.
          move.w  #$96FA,(a6)           ; Set DMA mid byte  - $XXFA00.
          move.w  #$977F,(a6)           ; Set DMA high byte - $7FFA00*2 = $FFF400.
          move.l  #$C0000080,(a6)       ; Set VDP to CRAM DMA $80 bytes from $FFF400.
          move.w  #0,($A11100).l        ; Start the Z80.
          move.w  ($FFFFFF06).w,d0      ; Load VBlank routine value into d0.
          add.w   d0,d0                 ; Double it.
          add.w   d0,d0                 ; Quadruple it to handle tables 4 bytes long.
          jmp     VBlank_RoutineTables(pc,d0.w) ; Jump to the appropriate routine.
; ----------------------------------------------------------------------------------------
VBlank_RoutineTables:
          bra.w   loc_1A01E             ; $0
; ----------------------------------------------------------------------------------------
          bra.w   loc_19FDA             ; $1
; ----------------------------------------------------------------------------------------
          bra.w   loc_19DC4             ; $2
; ----------------------------------------------------------------------------------------
          bra.w   loc_19F5C             ; $3
; ----------------------------------------------------------------------------------------
          bra.w   loc_19F42             ; $4
; ----------------------------------------------------------------------------------------
loc_19DA6:
          move.l  #$74000003,($C00004).l  ; Set VDP to VRAM write, $F400.
          move.w  ($FFFFE002).w,d0        
          neg.w   d0
          move.w  d0,(a1)
          move.w  ($FFFFE102).w,d0
          neg.w   d0
          move.w  d0,(a1)
          jmp     loc_196A4(pc)
; ----------------------------------------------------------------------------------------
loc_19DC4:
          moveq   #0,d0
          move.b  ($FFFFFA0E).w
          add.w   d0,d0
          move.w  loc_19DD4(pc,d0.w),d0
          jmp     loc_19DD4(pc,d0.w)
; ----------------------------------------------------------------------------------------
loc_19DD4:
          dc.w    loc_19DDE-loc_19DD4, loc_19DE2-loc_19DD4
          dc.w    loc_19E1E-loc_19DD4

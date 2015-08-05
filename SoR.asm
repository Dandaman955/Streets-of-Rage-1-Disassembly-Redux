          dc.l  $FFFF00,    EntryPoint, ErrorTrap,  ErrorTrap 
          dc.l  ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
          dc.l  ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
          dc.l  ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
          dc.l  ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
          dc.l  ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
          dc.l  ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
          dc.l  ErrorTrap, ErrorTrap, VBlank, ErrorTrap
          
          
          
          
          
ErrorTrap:

          nop
          nop
          bra.w     EntryPoint
          
ErrorTrap:
          tst.l     ($A10008).l         
          bne.w     $00000308
          tstw      ($A1000C).l
          bne.s     $0000020e
          lea       0x000002a4(pc),a5   ; Load setup values address into a5.
          movem.l   (a5)+,d5-a4
          move.b    -$10FF(a1),%d0      ; Load version register IO port.
          andib     #$F,%d0             ; Get hardware version.
          beq.s     SkipSecurity
          move.l    #$'SEGA',$2F00(a1)
SkipSecurity:
          move.w    (a4),d0
          moveq     #0,d0
          movea.l   d0,a6
          move.l    a6,usp
          moveq     #17,d1
0000023e 1a 1d                            moveb %a5@+,%d5
00000240 38 85                            movew %d5,%a4@
00000242 da 47                            addw %d7,%d5
00000244 51 c9 ff f8                      dbf %d1,0x0000023e
00000248 28 bc 40 00 00 80                movel #1073741952,%a4@
0000024e 36 80                            movew %d0,%a3@
00000250 32 87                            movew %d7,%a1@
00000252 34 87                            movew %d7,%a2@
00000254 01 11                            btst %d0,%a1@
00000256 66 fc                            bnes 0x00000254
00000258 74 27                            moveq #39,%d2
0000025a 10 dd                            moveb %a5@+,%a0@+
0000025c 51 ca ff fc                      dbf %d2,0x0000025a
00000260 34 80                            movew %d0,%a2@
00000262 32 80                            movew %d0,%a1@
00000264 34 87                            movew %d7,%a2@
00000266 2d 00                            movel %d0,%fp@-
00000268 51 ce ff fc                      dbf %d6,0x00000266
0000026c 28 bc 81 04 8f 02                movel #-2130407678,%a4@
00000272 28 bc c0 00 00 00                movel #-1073741824,%a4@
00000278 76 1f                            moveq #31,%d3
0000027a 26 80                            movel %d0,%a3@
0000027c 51 cb ff fc                      dbf %d3,0x0000027a
00000280 28 bc 40 00 00 10                movel #1073741840,%a4@
00000286 78 13                            moveq #19,%d4
00000288 26 80                            movel %d0,%a3@
0000028a 51 cc ff fc                      dbf %d4,0x00000288
0000028e 7a 03                            moveq #3,%d5
00000290 17 5d 00 11                      moveb %a5@+,%a3@(17)
00000294 51 cd ff fa                      dbf %d5,0x00000290
00000298 34 80                            movew %d0,%a2@
0000029a 4c d6 7f ff                      moveml %fp@,%d0-%fp
0000029e 46 fc 27 00                      movew #9984,%sr
000002a2 60 64                            bras 0x00000308

000002a4: 00 00 80 00                      orib #0,%d0
000002a8 00 00 3f ff                      orib #-1,%d0
000002ac 00 00 01 00                      orib #0,%d0
000002b0 00 a0 00 00 00 a1                oril #161,%a0@-
000002b6 11 00                            moveb %d0,%a0@-
000002b8 00 a1 12 00 00 c0                oril #301990080,%a1@-
000002be 00 00 00 c0                      orib #-64,%d0
000002c2 00 04 04 14                      orib #20,%d4
000002c6 30 3c 07 6c                      movew #1900,%d0
000002ca 00 00 00 00                      orib #0,%d0
000002ce ff 00                            .short 0xff00
000002d0 81 37 00 01                      orb %d0,%sp@(0000000000000001,%d0:w)
000002d4 01 00                            btst %d0,%d0
000002d6 00 ff                            .short 0x00ff
000002d8 ff 00                            .short 0xff00
000002da 00 80 af 01 d7 1f                oril #-1358833889,%d0
000002e0 11 29 00 21                      moveb %a1@(33),%a0@-
000002e4 28 00                            movel %d0,%d4
000002e6 f9 77                            .short 0xf977
000002e8 ed b0                            roxll %d6,%d0
000002ea dd e1                            addal %a1@-,%fp
000002ec fd e1                            .short 0xfde1
000002ee ed 47                            aslw #6,%d7
000002f0 ed 4f                            lslw #6,%d7
000002f2 08 d9 f1 c1                      bset #-63,%a1@+
000002f6 d1 e1                            addal %a1@-,%a0
000002f8 08 d9 f1 d1                      bset #-47,%a1@+
000002fc e1 f9 f3 ed 56 36                aslw 0xf3ed5636
00000302 e9 e9                            .short 0xe9e9
00000304 9f bf                            .short 0x9fbf
00000306 df ff                            .short 0xdfff
00000308 10 39 00 a1 00 01                moveb 0x00a10001,%d0
0000030e 1e 00                            moveb %d0,%d7
00000310 02 00 00 0f                      andib #15,%d0
00000314 67 0a                            beqs 0x00000320
00000316 23 fc 53 45 47 41 00 a1 40 00    movel #1397049153,0x00a14000
00000320 08 39 00 06 00 a1 00 0d          btst #6,0x00a1000d
00000328 66 44                            bnes 0x0000036e
0000032a 20 7c 00 00 02 00                moveal #512,%a0
00000330 22 7c 00 00 01 a4                moveal #420,%a1
00000336 20 11                            movel %a1@,%d0
00000338 74 00                            moveq #0,%d2
0000033a d4 58                            addw %a0@+,%d2
0000033c b0 88                            cmpl %a0,%d0
0000033e 64 fa                            bccs 0x0000033a
00000340 22 7c 00 00 01 8e                moveal #398,%a1
00000346 b4 51                            cmpw %a1@,%d2
00000348 66 00 00 c8                      bnew 0x00000412
0000034c 43 f8 ff 40                      lea 0xffffffffffffff40,%a1
00000350 72 00                            moveq #0,%d1
00000352 4e b9 00 01 03 d0                jsr 0x000103d0
00000358 4e b9 00 01 03 f0                jsr 0x000103f0
0000035e 11 c7 ff 44                      moveb %d7,0xffffffffffffff44
00000362 4e b9 00 01 28 32                jsr 0x00012832
00000368 4e b9 00 01 19 92                jsr 0x00011992
0000036e 43 f9 00 ff 00 00                lea 0x00ff0000,%a1
00000374 72 00                            moveq #0,%d1
00000376 3e 3c 01 f9                      movew #505,%d7
0000037a 4e b9 00 01 03 d0                jsr 0x000103d0
00000380 51 cf ff f8                      dbf %d7,0x0000037a
00000384 43 f8 ff 00                      lea 0xffffffffffffff00,%a1
00000388 4e b9 00 01 03 f0                jsr 0x000103f0
0000038e 4e ba 7b c0                      jsr %pc@(0x00007f50)
00000392 4e ba 7c 24                      jsr %pc@(0x00007fb8)
00000396 4e b9 00 01 06 1c                jsr 0x0001061c
0000039c 4e b9 00 01 19 9e                jsr 0x0001199e
000003a2 70 00                            moveq #0,%d0
000003a4 30 38 ff 00                      movew 0xffffffffffffff00,%d0
000003a8 d0 40                            addw %d0,%d0
000003aa 20 3b 00 0e                      movel %pc@(0x000003ba,%d0:w),%d0
000003ae 20 40                            moveal %d0,%a0
000003b0 4e 90                            jsr %a0@
000003b2 4e b9 00 01 05 02                jsr 0x00010502
000003b8 60 e8                            bras 0x000003a2

          
          
          
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

DEFINT A-Z

TYPE RegTypeX
     AX    AS INTEGER
     BX    AS INTEGER
     cx    AS INTEGER
     dx    AS INTEGER
     bp    AS INTEGER
     si    AS INTEGER
     di    AS INTEGER
     flags AS INTEGER
     ds    AS INTEGER
     ES    AS INTEGER
END TYPE

DECLARE SUB InterruptX (intnum AS INTEGER, inreg AS RegTypeX, outreg AS RegTypeX)
DECLARE FUNCTION VectorAvailable (InterruptNr)

FOR InterruptNr = &H0 TO &HFF
 IF VectorAvailable(InterruptNr) THEN PRINT USING "0x\\ "; HEX$(InterruptNr);
NEXT InterruptNr

FUNCTION VectorAvailable (InterruptNr)
DIM Registers AS RegTypeX

 Registers.AX = &H3500 OR InterruptNr
 InterruptX &H21, Registers, Registers

 VectorAvailable = (Registers.ES = &H0 AND Registers.BX = &H0)
END FUNCTION


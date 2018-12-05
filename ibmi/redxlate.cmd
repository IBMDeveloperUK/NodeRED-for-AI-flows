             CMD
             PARM       KWD(TEXT) TYPE(*CHAR) LEN(512)
             PARM       KWD(SRC) TYPE(*CHAR) LEN(2) RSTD(*YES) +
                          DFT(EN) VALUES(EN ES NL FR DE) +
                          PROMPT('SOURCE LANGUAGE')
             PARM       KWD(TGT) TYPE(*CHAR) LEN(2) RSTD(*YES) +
                          DFT(NL) VALUES(EN ES NL FR DE) +
                          PROMPT('TARGET LANGUAGE')

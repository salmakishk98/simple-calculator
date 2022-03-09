
_err:

;calculator.c,19 :: 		void err()
;calculator.c,21 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;calculator.c,22 :: 		lcd_out_cp("error");
	MOVLW      ?lstr1_calculator+0
	MOVWF      FARG_Lcd_Out_CP_text+0
	CALL       _Lcd_Out_CP+0
;calculator.c,23 :: 		while(allowed!= 13){
L_err0:
	MOVF       _allowed+0, 0
	XORLW      13
	BTFSC      STATUS+0, 2
	GOTO       L_err1
;calculator.c,24 :: 		allowed = keypad_key_click();
	CALL       _Keypad_Key_Click+0
	MOVF       R0+0, 0
	MOVWF      _allowed+0
;calculator.c,25 :: 		}
	GOTO       L_err0
L_err1:
;calculator.c,26 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;calculator.c,28 :: 		}
L_end_err:
	RETURN
; end of _err

_take_input:

;calculator.c,30 :: 		int  take_input()
;calculator.c,32 :: 		int f = 0;
	CLRF       take_input_f_L0+0
	CLRF       take_input_f_L0+1
;calculator.c,33 :: 		for(i = 0 ; i < 4; i++)
	CLRF       _i+0
	CLRF       _i+1
L_take_input2:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__take_input51
	MOVLW      4
	SUBWF      _i+0, 0
L__take_input51:
	BTFSC      STATUS+0, 0
	GOTO       L_take_input3
;calculator.c,34 :: 		num[i] = 0;
	MOVF       _i+0, 0
	ADDLW      _num+0
	MOVWF      FSR
	CLRF       INDF+0
;calculator.c,33 :: 		for(i = 0 ; i < 4; i++)
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;calculator.c,34 :: 		num[i] = 0;
	GOTO       L_take_input2
L_take_input3:
;calculator.c,35 :: 		for(i = 0 ; i < 4; i++)
	CLRF       _i+0
	CLRF       _i+1
L_take_input5:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__take_input52
	MOVLW      4
	SUBWF      _i+0, 0
L__take_input52:
	BTFSC      STATUS+0, 0
	GOTO       L_take_input6
;calculator.c,37 :: 		while(num[i]== 0){
L_take_input8:
	MOVF       _i+0, 0
	ADDLW      _num+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_take_input9
;calculator.c,38 :: 		num[i] = keypad_key_click();
	MOVF       _i+0, 0
	ADDLW      _num+0
	MOVWF      FLOC__take_input+0
	CALL       _Keypad_Key_Click+0
	MOVF       FLOC__take_input+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;calculator.c,39 :: 		}
	GOTO       L_take_input8
L_take_input9:
;calculator.c,40 :: 		while(num[i]!= 15 && i==3&&num[i]!=13)
L_take_input10:
	MOVF       _i+0, 0
	ADDLW      _num+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      15
	BTFSC      STATUS+0, 2
	GOTO       L_take_input11
	MOVLW      0
	XORWF      _i+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__take_input53
	MOVLW      3
	XORWF      _i+0, 0
L__take_input53:
	BTFSS      STATUS+0, 2
	GOTO       L_take_input11
	MOVF       _i+0, 0
	ADDLW      _num+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      13
	BTFSC      STATUS+0, 2
	GOTO       L_take_input11
L__take_input47:
;calculator.c,42 :: 		num[i] = keypad_key_click();
	MOVF       _i+0, 0
	ADDLW      _num+0
	MOVWF      FLOC__take_input+0
	CALL       _Keypad_Key_Click+0
	MOVF       FLOC__take_input+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;calculator.c,43 :: 		}
	GOTO       L_take_input10
L_take_input11:
;calculator.c,45 :: 		if(num[i]==1) num[i] =  '7';
	MOVF       _i+0, 0
	ADDLW      _num+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_take_input14
	MOVF       _i+0, 0
	ADDLW      _num+0
	MOVWF      FSR
	MOVLW      55
	MOVWF      INDF+0
L_take_input14:
;calculator.c,46 :: 		if(num[i]==2) num[i] =  '8';
	MOVF       _i+0, 0
	ADDLW      _num+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_take_input15
	MOVF       _i+0, 0
	ADDLW      _num+0
	MOVWF      FSR
	MOVLW      56
	MOVWF      INDF+0
L_take_input15:
;calculator.c,47 :: 		if(num[i]==3) num[i] =  '9';
	MOVF       _i+0, 0
	ADDLW      _num+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_take_input16
	MOVF       _i+0, 0
	ADDLW      _num+0
	MOVWF      FSR
	MOVLW      57
	MOVWF      INDF+0
L_take_input16:
;calculator.c,48 :: 		if(num[i]==4) num[i] = '/' ;
	MOVF       _i+0, 0
	ADDLW      _num+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      4
	BTFSS      STATUS+0, 2
	GOTO       L_take_input17
	MOVF       _i+0, 0
	ADDLW      _num+0
	MOVWF      FSR
	MOVLW      47
	MOVWF      INDF+0
L_take_input17:
;calculator.c,49 :: 		if(num[i]==5) num[i] =  '4';
	MOVF       _i+0, 0
	ADDLW      _num+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      5
	BTFSS      STATUS+0, 2
	GOTO       L_take_input18
	MOVF       _i+0, 0
	ADDLW      _num+0
	MOVWF      FSR
	MOVLW      52
	MOVWF      INDF+0
L_take_input18:
;calculator.c,50 :: 		if(num[i]==6) num[i] =  '5';
	MOVF       _i+0, 0
	ADDLW      _num+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      6
	BTFSS      STATUS+0, 2
	GOTO       L_take_input19
	MOVF       _i+0, 0
	ADDLW      _num+0
	MOVWF      FSR
	MOVLW      53
	MOVWF      INDF+0
L_take_input19:
;calculator.c,51 :: 		if(num[i]==7) num[i] =  '6';
	MOVF       _i+0, 0
	ADDLW      _num+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      7
	BTFSS      STATUS+0, 2
	GOTO       L_take_input20
	MOVF       _i+0, 0
	ADDLW      _num+0
	MOVWF      FSR
	MOVLW      54
	MOVWF      INDF+0
L_take_input20:
;calculator.c,52 :: 		if(num[i]==8) num[i] =  '*';
	MOVF       _i+0, 0
	ADDLW      _num+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      8
	BTFSS      STATUS+0, 2
	GOTO       L_take_input21
	MOVF       _i+0, 0
	ADDLW      _num+0
	MOVWF      FSR
	MOVLW      42
	MOVWF      INDF+0
L_take_input21:
;calculator.c,53 :: 		if(num[i]==9) num[i] =  '1';
	MOVF       _i+0, 0
	ADDLW      _num+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      9
	BTFSS      STATUS+0, 2
	GOTO       L_take_input22
	MOVF       _i+0, 0
	ADDLW      _num+0
	MOVWF      FSR
	MOVLW      49
	MOVWF      INDF+0
L_take_input22:
;calculator.c,54 :: 		if(num[i]==10) num[i] =  '2';
	MOVF       _i+0, 0
	ADDLW      _num+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      10
	BTFSS      STATUS+0, 2
	GOTO       L_take_input23
	MOVF       _i+0, 0
	ADDLW      _num+0
	MOVWF      FSR
	MOVLW      50
	MOVWF      INDF+0
L_take_input23:
;calculator.c,55 :: 		if(num[i]==11) num[i] =  '3';
	MOVF       _i+0, 0
	ADDLW      _num+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      11
	BTFSS      STATUS+0, 2
	GOTO       L_take_input24
	MOVF       _i+0, 0
	ADDLW      _num+0
	MOVWF      FSR
	MOVLW      51
	MOVWF      INDF+0
L_take_input24:
;calculator.c,56 :: 		if(num[i]==12) num[i] =  '-';
	MOVF       _i+0, 0
	ADDLW      _num+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      12
	BTFSS      STATUS+0, 2
	GOTO       L_take_input25
	MOVF       _i+0, 0
	ADDLW      _num+0
	MOVWF      FSR
	MOVLW      45
	MOVWF      INDF+0
L_take_input25:
;calculator.c,57 :: 		if(num[i]==13) {lcd_cmd(_LCD_CLEAR); f = 1; break;}
	MOVF       _i+0, 0
	ADDLW      _num+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      13
	BTFSS      STATUS+0, 2
	GOTO       L_take_input26
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
	MOVLW      1
	MOVWF      take_input_f_L0+0
	MOVLW      0
	MOVWF      take_input_f_L0+1
	GOTO       L_take_input6
L_take_input26:
;calculator.c,58 :: 		if(num[i]==14) num[i] =  '0';
	MOVF       _i+0, 0
	ADDLW      _num+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      14
	BTFSS      STATUS+0, 2
	GOTO       L_take_input27
	MOVF       _i+0, 0
	ADDLW      _num+0
	MOVWF      FSR
	MOVLW      48
	MOVWF      INDF+0
L_take_input27:
;calculator.c,59 :: 		if(num[i]==15) num[i] =  '=';
	MOVF       _i+0, 0
	ADDLW      _num+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      15
	BTFSS      STATUS+0, 2
	GOTO       L_take_input28
	MOVF       _i+0, 0
	ADDLW      _num+0
	MOVWF      FSR
	MOVLW      61
	MOVWF      INDF+0
L_take_input28:
;calculator.c,60 :: 		if(num[i]==16) num[i] =  '+';
	MOVF       _i+0, 0
	ADDLW      _num+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      16
	BTFSS      STATUS+0, 2
	GOTO       L_take_input29
	MOVF       _i+0, 0
	ADDLW      _num+0
	MOVWF      FSR
	MOVLW      43
	MOVWF      INDF+0
L_take_input29:
;calculator.c,61 :: 		lcd_chr(1,i+1,num[i]);
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	INCF       _i+0, 0
	MOVWF      FARG_Lcd_Chr_column+0
	MOVF       _i+0, 0
	ADDLW      _num+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;calculator.c,35 :: 		for(i = 0 ; i < 4; i++)
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;calculator.c,62 :: 		}
	GOTO       L_take_input5
L_take_input6:
;calculator.c,63 :: 		return f;
	MOVF       take_input_f_L0+0, 0
	MOVWF      R0+0
	MOVF       take_input_f_L0+1, 0
	MOVWF      R0+1
;calculator.c,64 :: 		}
L_end_take_input:
	RETURN
; end of _take_input

_parse:

;calculator.c,66 :: 		int  parse()
;calculator.c,68 :: 		if(num[0]<'0'||num[0]>'9'||num[2]<'0'||num[2]>'9') return 1;
	MOVLW      48
	SUBWF      _num+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L__parse48
	MOVF       _num+0, 0
	SUBLW      57
	BTFSS      STATUS+0, 0
	GOTO       L__parse48
	MOVLW      48
	SUBWF      _num+2, 0
	BTFSS      STATUS+0, 0
	GOTO       L__parse48
	MOVF       _num+2, 0
	SUBLW      57
	BTFSS      STATUS+0, 0
	GOTO       L__parse48
	GOTO       L_parse32
L__parse48:
	MOVLW      1
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	GOTO       L_end_parse
L_parse32:
;calculator.c,69 :: 		if(num[1]=='+')
	MOVF       _num+1, 0
	XORLW      43
	BTFSS      STATUS+0, 2
	GOTO       L_parse33
;calculator.c,72 :: 		res = (num[0]-'0')+(num[2]-'0');
	MOVLW      48
	SUBWF      _num+0, 0
	MOVWF      R2+0
	CLRF       R2+1
	BTFSS      STATUS+0, 0
	DECF       R2+1, 1
	MOVLW      48
	SUBWF      _num+2, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSS      STATUS+0, 0
	DECF       R0+1, 1
	MOVF       R2+0, 0
	ADDWF      R0+0, 1
	MOVF       R2+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
;calculator.c,73 :: 		FloatToStr(res,res_text);
	CALL       _Int2Double+0
	MOVF       R0+0, 0
	MOVWF      FARG_FloatToStr_fnum+0
	MOVF       R0+1, 0
	MOVWF      FARG_FloatToStr_fnum+1
	MOVF       R0+2, 0
	MOVWF      FARG_FloatToStr_fnum+2
	MOVF       R0+3, 0
	MOVWF      FARG_FloatToStr_fnum+3
	MOVLW      _res_text+0
	MOVWF      FARG_FloatToStr_str+0
	CALL       _FloatToStr+0
;calculator.c,74 :: 		return 0;
	CLRF       R0+0
	CLRF       R0+1
	GOTO       L_end_parse
;calculator.c,75 :: 		}
L_parse33:
;calculator.c,76 :: 		else if(num[1]=='-')
	MOVF       _num+1, 0
	XORLW      45
	BTFSS      STATUS+0, 2
	GOTO       L_parse35
;calculator.c,79 :: 		res = (num[0]-'0')-(num[2]-'0');
	MOVLW      48
	SUBWF      _num+0, 0
	MOVWF      R2+0
	CLRF       R2+1
	BTFSS      STATUS+0, 0
	DECF       R2+1, 1
	MOVLW      48
	SUBWF      _num+2, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSS      STATUS+0, 0
	DECF       R0+1, 1
	MOVF       R0+0, 0
	SUBWF      R2+0, 0
	MOVWF      R0+0
	MOVF       R0+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      R2+1, 0
	MOVWF      R0+1
;calculator.c,80 :: 		FloatToStr(res,res_text);
	CALL       _Int2Double+0
	MOVF       R0+0, 0
	MOVWF      FARG_FloatToStr_fnum+0
	MOVF       R0+1, 0
	MOVWF      FARG_FloatToStr_fnum+1
	MOVF       R0+2, 0
	MOVWF      FARG_FloatToStr_fnum+2
	MOVF       R0+3, 0
	MOVWF      FARG_FloatToStr_fnum+3
	MOVLW      _res_text+0
	MOVWF      FARG_FloatToStr_str+0
	CALL       _FloatToStr+0
;calculator.c,81 :: 		return 0;
	CLRF       R0+0
	CLRF       R0+1
	GOTO       L_end_parse
;calculator.c,82 :: 		}
L_parse35:
;calculator.c,83 :: 		else if(num[1]=='*')
	MOVF       _num+1, 0
	XORLW      42
	BTFSS      STATUS+0, 2
	GOTO       L_parse37
;calculator.c,86 :: 		res = (num[0]-'0')*(num[2]-'0');
	MOVLW      48
	SUBWF      _num+0, 0
	MOVWF      R4+0
	CLRF       R4+1
	BTFSS      STATUS+0, 0
	DECF       R4+1, 1
	MOVLW      48
	SUBWF      _num+2, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSS      STATUS+0, 0
	DECF       R0+1, 1
	CALL       _Mul_16x16_U+0
;calculator.c,87 :: 		FloatToStr(res,res_text);
	CALL       _Int2Double+0
	MOVF       R0+0, 0
	MOVWF      FARG_FloatToStr_fnum+0
	MOVF       R0+1, 0
	MOVWF      FARG_FloatToStr_fnum+1
	MOVF       R0+2, 0
	MOVWF      FARG_FloatToStr_fnum+2
	MOVF       R0+3, 0
	MOVWF      FARG_FloatToStr_fnum+3
	MOVLW      _res_text+0
	MOVWF      FARG_FloatToStr_str+0
	CALL       _FloatToStr+0
;calculator.c,88 :: 		return 0;
	CLRF       R0+0
	CLRF       R0+1
	GOTO       L_end_parse
;calculator.c,89 :: 		}
L_parse37:
;calculator.c,90 :: 		else if(num[1]=='/')
	MOVF       _num+1, 0
	XORLW      47
	BTFSS      STATUS+0, 2
	GOTO       L_parse39
;calculator.c,93 :: 		tmp = (num[0]-'0');
	MOVLW      48
	SUBWF      _num+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSS      STATUS+0, 0
	DECF       R0+1, 1
	CALL       _Int2Double+0
	MOVF       R0+0, 0
	MOVWF      FLOC__parse+0
	MOVF       R0+1, 0
	MOVWF      FLOC__parse+1
	MOVF       R0+2, 0
	MOVWF      FLOC__parse+2
	MOVF       R0+3, 0
	MOVWF      FLOC__parse+3
	MOVF       FLOC__parse+0, 0
	MOVWF      _tmp+0
	MOVF       FLOC__parse+1, 0
	MOVWF      _tmp+1
	MOVF       FLOC__parse+2, 0
	MOVWF      _tmp+2
	MOVF       FLOC__parse+3, 0
	MOVWF      _tmp+3
;calculator.c,94 :: 		res = tmp/(num[2]-'0');
	MOVLW      48
	SUBWF      _num+2, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSS      STATUS+0, 0
	DECF       R0+1, 1
	CALL       _Int2Double+0
	MOVF       R0+0, 0
	MOVWF      R4+0
	MOVF       R0+1, 0
	MOVWF      R4+1
	MOVF       R0+2, 0
	MOVWF      R4+2
	MOVF       R0+3, 0
	MOVWF      R4+3
	MOVF       FLOC__parse+0, 0
	MOVWF      R0+0
	MOVF       FLOC__parse+1, 0
	MOVWF      R0+1
	MOVF       FLOC__parse+2, 0
	MOVWF      R0+2
	MOVF       FLOC__parse+3, 0
	MOVWF      R0+3
	CALL       _Div_32x32_FP+0
;calculator.c,95 :: 		FloatToStr(res,res_text);
	MOVF       R0+0, 0
	MOVWF      FARG_FloatToStr_fnum+0
	MOVF       R0+1, 0
	MOVWF      FARG_FloatToStr_fnum+1
	MOVF       R0+2, 0
	MOVWF      FARG_FloatToStr_fnum+2
	MOVF       R0+3, 0
	MOVWF      FARG_FloatToStr_fnum+3
	MOVLW      _res_text+0
	MOVWF      FARG_FloatToStr_str+0
	CALL       _FloatToStr+0
;calculator.c,96 :: 		return 0;
	CLRF       R0+0
	CLRF       R0+1
	GOTO       L_end_parse
;calculator.c,97 :: 		}
L_parse39:
;calculator.c,98 :: 		else  return 1;
	MOVLW      1
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
;calculator.c,99 :: 		}
L_end_parse:
	RETURN
; end of _parse

_print_result:

;calculator.c,101 :: 		void print_result()
;calculator.c,103 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;calculator.c,104 :: 		lcd_out_cp(res_text);
	MOVLW      _res_text+0
	MOVWF      FARG_Lcd_Out_CP_text+0
	CALL       _Lcd_Out_CP+0
;calculator.c,105 :: 		while(allowed!= 13){
L_print_result41:
	MOVF       _allowed+0, 0
	XORLW      13
	BTFSC      STATUS+0, 2
	GOTO       L_print_result42
;calculator.c,106 :: 		allowed = keypad_key_click();
	CALL       _Keypad_Key_Click+0
	MOVF       R0+0, 0
	MOVWF      _allowed+0
;calculator.c,107 :: 		}
	GOTO       L_print_result41
L_print_result42:
;calculator.c,108 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;calculator.c,109 :: 		}
L_end_print_result:
	RETURN
; end of _print_result

_main:

;calculator.c,110 :: 		void main() {
;calculator.c,111 :: 		lcd_init();
	CALL       _Lcd_Init+0
;calculator.c,112 :: 		keypad_init();
	CALL       _Keypad_Init+0
;calculator.c,113 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;calculator.c,114 :: 		lcd_cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;calculator.c,115 :: 		while(1)
L_main43:
;calculator.c,117 :: 		allowed = 0;
	CLRF       _allowed+0
;calculator.c,118 :: 		if(take_input()) {lcd_cmd(_LCD_CLEAR);continue;}
	CALL       _take_input+0
	MOVF       R0+0, 0
	IORWF      R0+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main45
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
	GOTO       L_main43
L_main45:
;calculator.c,119 :: 		if(parse()) {err();continue;}
	CALL       _parse+0
	MOVF       R0+0, 0
	IORWF      R0+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main46
	CALL       _err+0
	GOTO       L_main43
L_main46:
;calculator.c,120 :: 		print_result();
	CALL       _print_result+0
;calculator.c,121 :: 		}
	GOTO       L_main43
;calculator.c,122 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

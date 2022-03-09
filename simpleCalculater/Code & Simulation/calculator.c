//configuration for lcd
sbit LCD_RS at RB4_bit;
sbit LCD_EN at RB5_bit;
sbit LCD_D7 at RB3_bit;
sbit LCD_D6 at RB2_bit;
sbit LCD_D5 at RB1_bit;
sbit LCD_D4 at RB0_bit;
sbit LCD_RS_Direction at TRISB4_bit;
sbit LCD_EN_Direction at TRISB5_bit;
sbit LCD_D7_Direction at TRISB3_bit;
sbit LCD_D6_Direction at TRISB2_bit;
sbit LCD_D5_Direction at TRISB1_bit;
sbit LCD_D4_Direction at TRISB0_bit;
// define keypad at port D
char keypadport at portD;
//global variable
char num[5], res_text[5], allowed; int i = 0;  float tmp;
// print error
void err()
{
     lcd_cmd(_LCD_CLEAR); 
     lcd_out_cp("error");
     while(allowed!= 13){
         allowed = keypad_key_click();
     }
     lcd_cmd(_LCD_CLEAR);

}
// take number and operation
int  take_input()
{
       int f = 0;
       for(i = 0 ; i < 4; i++)
             num[i] = 0;
       for(i = 0 ; i < 4; i++)
       {
             while(num[i]== 0){
                 num[i] = keypad_key_click();
             }
             while(num[i]!= 15 && i==3&&num[i]!=13)
             {
                num[i] = keypad_key_click();
             }
             // define buttons
             if(num[i]==1) num[i] =  '7';
             if(num[i]==2) num[i] =  '8';
             if(num[i]==3) num[i] =  '9';
             if(num[i]==4) num[i] = '/' ;
             if(num[i]==5) num[i] =  '4';
             if(num[i]==6) num[i] =  '5';
             if(num[i]==7) num[i] =  '6';
             if(num[i]==8) num[i] =  '*';
             if(num[i]==9) num[i] =  '1';
             if(num[i]==10) num[i] =  '2';
             if(num[i]==11) num[i] =  '3';
             if(num[i]==12) num[i] =  '-';
             if(num[i]==13) {lcd_cmd(_LCD_CLEAR); f = 1; break;}
             if(num[i]==14) num[i] =  '0';
             if(num[i]==15) num[i] =  '=';
             if(num[i]==16) num[i] =  '+';
             lcd_chr(1,i+1,num[i]);
       }
       return f;
}
// calc result
int  parse()
{
     if(num[0]<'0'||num[0]>'9'||num[2]<'0'||num[2]>'9') return 1;
     if(num[1]=='+')
        {
           int res;
           res = (num[0]-'0')+(num[2]-'0');
           FloatToStr(res,res_text);
           return 0;
        }
        else if(num[1]=='-')
        {
           int res;
           res = (num[0]-'0')-(num[2]-'0');
           FloatToStr(res,res_text);
           return 0;
        }
       else if(num[1]=='*')
        {
           int res;
           res = (num[0]-'0')*(num[2]-'0');
           FloatToStr(res,res_text);
           return 0;
        }
        else if(num[1]=='/')
        {
           float res;
           tmp = (num[0]-'0');
           res = tmp/(num[2]-'0');
           FloatToStr(res,res_text);
           return 0;
        }
        else  return 1;
}
// print result
void print_result()
{
    lcd_cmd(_LCD_CLEAR);
    lcd_out_cp(res_text);
    while(allowed!= 13){
         allowed = keypad_key_click();
    }
   lcd_cmd(_LCD_CLEAR);
}
void main() {
     lcd_init();
     keypad_init();
     lcd_cmd(_LCD_CLEAR);
     lcd_cmd(_LCD_CURSOR_OFF);
     while(1)
     {
        allowed = 0;
        if(take_input()) {lcd_cmd(_LCD_CLEAR);continue;}
        if(parse()) {err();continue;}
        print_result();
     }
}
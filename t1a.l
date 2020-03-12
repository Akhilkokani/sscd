%{
    int num=0, oprt=0, p=0, idn=0, flag=1;
%}
%x OPRT TRAP OB CB
digit [0-9]
letter [a-zA-Z]
number {digit}+
id {letter}({letter}|{digit})*
operator "+"|"-"|"*"|"/"
%%
"("                 {flag = 1; p++; BEGIN OB;}
{id}                {flag = 1; idn++; BEGIN OPRT;}
{number}            {flag = 1; num++; BEGIN OPRT;}
.                   {flag = 0; BEGIN TRAP;}
<OB>{id}            {idn++; BEGIN OPRT;}
<OB>{number}        {num++; BEGIN OPRT;}
<OB>"("             {p++; BEGIN 0;}
<OPRT>{operator}    {flag=0; oprt++; BEGIN 0;}
<OPRT>")"           {if(p >= 0) p--; BEGIN CB;}
<CB>{operator}      {oprt++; BEGIN 0;}
<CB>")"             {if(p >= 0) p--; BEGIN OPRT;}
<CB>.               {flag = 0; BEGIN TRAP;}
<OPRT>.             {flag = 0; BEGIN TRAP;}
<TRAP>.
%%

int main() {
	yylex();
	if (flag && p == 0) {
	    printf("Valid Expression: \n");
	    printf("No. of operators: %d\n", oprt);
	    printf("No. of identifiers: %d\n", idn);
	    printf("No. of constants: %d\n", num);
	} else {
	    printf("Invalid Expression.\n");
	}
	return 0;
}

%{
	int mlc = 0, slc = 0;
%}
%x MLC SLC    // Declaring states
%%
"/*" { BEGIN MLC; }   // When '/*' is found, MLC state is activated
"//" { BEGIN SLC; }
<MLC>.    // Any character
<MLC>\n   // Include new line as well, because '.' does not include it
<MLC>"*/" {mlc++; BEGIN 0;}
<SLC>.
<SLC>\n   {slc++; BEGIN 0;}
%%
int main() {
	yyin = fopen("input.c", "r");
	yyout = fopen("output.c", "w");
	yylex();
	printf("MLC: %d\n", mlc);
	printf("SLC: %d\n", slc);
}

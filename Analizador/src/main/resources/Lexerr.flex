package codigo;
import static codigo.Token.*;
import java_cup.runtime.Symbol;

%%
%class Lexer
%type  java_cup.runtime.Symbol
%line 
%column
%full
%cup 

L=[a-zA-z]+
N=[1-9]+
D=[0-9]+
E=[^]
espacio=[ \t\r\n]

%{
    private Symbol symbol(int type, Object value){
    	return new Symbol(type, yyline, yycolumn, value);
    }
    private Symbol symbol(int type){
    	return new Symbol(type, yyline, yycolumn);
    }
%}

%%

"//".* {/*Ignore*/}
"-" {return new Symbol(sym.RESTA, yyline, yycolumn, yytext());}
"+" {return new Symbol(sym.SUMA, yyline, yycolumn, yytext());}
"*" {return new Symbol(sym.MULTI, yyline, yycolumn, yytext());}
"/" {return new Symbol(sym.DIV, yyline, yycolumn, yytext());}
"{" {return new Symbol(sym.OPENBRACE, yyline, yycolumn, yytext());}
"}" {return new Symbol(sym.CLOSEBRACE, yyline, yycolumn, yytext());}
"(" {return new Symbol(sym.OPENPAR, yyline, yycolumn, yytext());}
")" {return new Symbol(sym.CLOSEPAR, yyline, yycolumn, yytext());}
"]" {return new Symbol(sym.OPENBRACKET, yyline, yycolumn, yytext());}
"[" {return new Symbol(sym.CLOSEBRACKET, yyline, yycolumn, yytext());}
";" {return new Symbol(sym.SEMICOLON, yyline, yycolumn, yytext());}
":" {return new Symbol(sym.COLON, yyline, yycolumn, yytext());}
"," {return new Symbol(sym.COMA, yyline, yycolumn, yytext());}
"barras" {return new Symbol(sym.BARRAS, yyline, yycolumn, yytext());}
"pie" {return new Symbol(sym.PIE, yyline, yycolumn, yytext());}
"titulo" {lexema=yytext();return new Symbol(sym.TITULO, yyline, yycolumn, yytext());}
"ejeX" {return new Symbol(sym.EJEX, yyline, yycolumn, yytext());}
"ejeY" {return new Symbol(sym.EJEY, yyline, yycolumn, yytext());}
"etiquetas" {return new Symbol(sym.TAG, yyline, yycolumn, yytext());}
"tipo" {return new Symbol(sym.TIPO, yyline, yycolumn, yytext());}
"total" {return new Symbol(sym.TOTAL, yyline, yycolumn, yytext());}
"extra" {return new Symbol(sym.EXTRA, yyline, yycolumn, yytext());}
"valores" {return new Symbol(sym.VALORES, yyline, yycolumn, yytext());}
"unir" {return new Symbol(sym.UNIR, yyline, yycolumn, yytext());}
"ejecutar" {return new Symbol(sym.RUN, yyline, yycolumn, yytext());}
"Def"|"def" {return new Symbol(sym.DEF, yyline, yycolumn, yytext());}

"\""{L}({L}|{D}|{E})*"\"" {lexema=yytext(); return new Symbol(sym.IDENTIFICADOR, yyline, yycolumn, yytext());/*Comentario*/}
{espacio} {/*Ignore*/}
"-"?({N}{D}}|{N})|"0"  {lexema=yytext(); return new Symbol(sym.NUMERO, yyline, yycolumn, yytext());}
"-"?({N}{D}*("."{D}+)?)|"-"?("0""."{D}+)|"0" {lexema=yytext(); return new Symbol(sym.DECIMAL, yyline, yycolumn, yytext());}
 . {return new Symbol(sym.Error, yyline, yycolumn, yytext());}

unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, TAGraph, TASeries, Forms, Controls, Graphics,
  Dialogs, StdCtrls, ExtCtrls, math;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Chart1: TChart;
    Chart1LineSeries1: TLineSeries;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Memo1: TMemo;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    procedure Button1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

function F(x:real):real;
begin
F:=x-(sin(x)/cos(x));
end;

procedure TForm1.Button1Click(Sender: TObject);
var pred, beg, last, eps, x, i, k: extended;
code: byte;
s: string;
begin
beg:=strtofloat(edit1.text);
last:=strtofloat(edit2.text);
eps:=strtofloat(edit3.text);
if beg>=last then messagedlg('Введите правильные значения', mtWarning, [mbOk], 0)
else
if (eps<0) and (eps>1) then messagedlg('Неправильная точность!', mtWarning, [mbOk], 0)
else

if cos(x)=0 then messagedlg('Деление на ноль!', mtWarning, [mbOk], 0)
else
begin
if (beg>last) or (F(beg)*F(last)>0) then messagedlg('Нет корней', mtWarning, [mbOk], 0);
if radiobutton1.checked then
begin
memo1.lines.Clear;
memo1.lines.Add('     X'+'        '+'F(x)');
i:=0;
 repeat
   x:=beg-f(beg)*(last-beg)/(f(last)-f(beg));
   if f(beg)*f(x)>0 then beg:=x
   else last:=x;
   memo1.Lines.add(floattostr(x)+' '+floattostrf(f(x), fffixed, 6,4));
   i:=i+1;
 until abs((f(last)*beg-f(beg)*last)/(f(last)-f(beg))-x)>eps ;
k:=x;
memo1.lines.add('Корень уравнения:'+floattostrF(x, FFFixed, 6,4));
while (i<last) do
begin
i:=i+0.001;
Chart1LineSeries1.AddXY(i, f(i));
end;
end;
end;
if radiobutton2.checked then
begin
x:=last;
pred:=beg;
while (abs(x-pred)>eps) do
begin
if x>0 then
begin
memo1.Lines.add(floattostrF(x, FFFixed, 6,4)+' '+floattostrf(f(x), fffixed, 6,4));
pred:=x;
x:=(x-f(x)/(-(sqr(sin(x)/cos(x)))));
end;
end;
memo1.lines.add('Корень уравнения:'+floattostrF(x, FFFixed, 6,4));
while (i<last) do
begin
i:=i+0.001;
Chart1LineSeries1.AddXY(i, f(i));
end;
end;
end;
end.


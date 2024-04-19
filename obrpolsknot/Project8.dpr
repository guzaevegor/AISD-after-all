Program Progstack;

{$APPTYPE CONSOLE}

uses
  System.SysUtils;

Type
    PNode = ^TStack;

    TStack = Record
        Value: Char;
        Top: PNode;
    End;
    TAoS = Array of String;

Procedure Push(Var Stack: TStack; Value: Char);
Var
    NewNode: PNode;
Begin
    New(NewNode);
    NewNode^.Value := Value;
    NewNode^.Top := Stack.Top;
    Stack.Top := NewNode;
End;

Function Pop(Var Stack: TStack): Char;
Var
    TempNode: PNode;
Begin
    Result := Stack.Top^.Value;
    TempNode := Stack.Top;
    Stack.Top := Stack.Top^.Top;
    Dispose(TempNode);
End;

Function Peek(Var Stack: TStack): Char;
Var
    TempNode: PNode;
Begin
    Result := Stack.Top^.Value;
End;

Procedure Initialize(Var Stack: TStack);
Begin
    Stack.Top := Nil;
End;

function findInt(Ch: Char; Arr: TAoS): Integer;
var
    I, Answ: Integer;
begin
    if Ch In ['a'..'z'] then
        Answ:= 8;
    for I := 0 to High(Arr) do
        if Arr[I][1]=Ch then
        begin
            Answ:= strtoint(Arr[i][2]);
            Break;
        end;
    Result:= Answ;
end;

procedure printStack(Var Stack: TStack);
var
    Temp: PNode;
    str: String;
begin
    Temp:= Stack.Top;
    while Temp<>Nil do
    begin
        Str:= Temp.Value + Str;
        Temp := Temp.Top;
    end;
    Write(str,'                ');
end;

Var
    Stack: TStack;
    Value: Integer;
    OtnPr, StPr: TAoS;
    Input, Output: String;
    Ch: Char;
    A: Boolean;

Begin
    Initialize(Stack);
    A:= True;
    OtnPr := ['+1','-1','*3','/3','^6','(9'];
    StPr := ['+2','-2','*4','/4','^5','(0'];
    Input:= 'w*(a+b+c*(y-g*d)^n^k+s*l)/(x-f*t*p+w)^e';
    {for var I := 1 to length(Input)-1 do
    begin
        if (not(Input[I-1] in ['a'..'z']) and not (Input[I] in ['a'..'z'])) or ((Input[I-1] in ['a'..'z']) and (Input[I] in ['a'..'z'])) then
        begin
            Writeln('������������ ����');
            a:= False;
        end;
    end;}

    for var I := 0 to length(Input)-1 do
    begin
        write(Ch,'  ');
        printStack(Stack);
        Writeln(Output);

        Ch:= Input[I+1];
        if (Stack.Top=Nil) or (Ch='(') or (Ch in ['a'..'z']) then
        begin
            Push(Stack, Ch);
            Continue;
        end;

        if (Ch=')') then
        begin
            while Peek(Stack)<>'(' do
                Output:= Output + pop(Stack);
            pop(Stack);
            Continue;
        end;


        while (Stack.Top<>Nil) and (FindInt(Ch, OtnPr)<FindInt(Peek(Stack),StPr)) do
        begin
            Output:= Output + pop(Stack);
        end;
        Push(Stack, Ch);
    end;

    while Stack.Top<>Nil do
        Output:= Output + pop(Stack);
    Writeln(Output);
    readln;
End.

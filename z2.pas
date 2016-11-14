unit z2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus;

type
  TForm1 = class(TForm)
    edt1: TEdit;
    lbl1: TLabel;
    btn1: TButton;
    lst1: TListBox;
    lbl3: TLabel;
    lbl4: TLabel;
    edt3: TEdit;
    edt2: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    function ConvertToInt : Integer;
    function GetMiddle(s1 : string) : Integer;
    function GetElementary(s1 : string) : Integer;
  end;

var
  Form1: TForm1; p : integer; mass : Array[1..10] of String;

implementation

{$R *.dfm}

function TForm1.ConvertToInt : Integer;
var h, m, e, j, yy : Integer; und : Boolean;
begin
  h := 0;
  m := 0;
  e := 0;
  j := 0;
  und := False;
  yy := 1;
  m := GetMiddle(mass[yy]);
  if (m > 0) then begin
    if (GetElementary(mass[2]) > 0) then begin
      ShowMessage('Число десятичного формата идет после единичного и слова ''und''');
      Result := 0;
      Exit;
    end;

    Result := m;
    for j := 1 to 4 do begin
      if (mass[j + 1] = 'und') then begin
        if ((j < 4) and (GetElementary(mass[j + 2]) > 0)) then begin
          ShowMessage('Число единичного формата должно стоять перед und, а число десятичного формата должно стоять после ''und''');
          Result := 0;
          Exit;
        end;
        ShowMessage('''und'' не нужно');
        Result := 0;
        Exit;
      end
      else
      if (mass[j + 1] <> '') then begin
        ShowMessage('Ошибка в слове ( ' + mass[j + 1] + ')!');
        Result := 0;
        Exit;
      end;
    end;
  end
  else begin
    e := GetElementary(mass[yy]);
    if (e = 0) then begin
      if (mass[yy] = 'hundert') then begin
        ShowMessage('перед ''hundert'' следует ввести число единичного формата!');
        Result := 0;
        Exit;
      end;
    end;
    if (e > 0) then begin
      // Начало сотни
        if (GetElementary(mass[2]) > 0) then begin
          ShowMessage('Числа единичного формата не могут повторяться!');
          Result := 0;
          Exit;
        end;

        if (mass[2] = 'hundert') then begin
          if ((e = 1) and (mass[1] = 'eins')) then begin
            ShowMessage('Окончаение у ein(s) не требуется!');
            Result := 0;
            Exit;
          end;

          if (mass[3] = 'hundert') then begin
            ShowMessage('слова ''hundert'' повторяются!');
            Result := 0;
            Exit;
          end;
          if ((GetElementary(mass[3]) > 0) and (mass[4] = 'hundert')) then begin
            ShowMessage('после сотен не могут идти сотни!');
            Result := 0;
            Exit;
          end;
          if (mass[3] = 'und') then begin
            ShowMessage('''und'' не ставится после ''hundert''!');
            Result := 0;
            Exit;
          end;

           h := e * 100;
           m := GetMiddle(mass[3]);

           if (m > 0) then begin
              if (GetElementary(mass[4]) > 0) then begin
                  if ((m mod 10) > 0) then
                    ShowMessage('После числа формата 11-19 не могут быть другие числа!')
                  else
                    ShowMessage('Число десятичного формата идет после единичного и слова ''und''');
                  Result := 0;
                  Exit;
              end;
              if (GetMiddle(mass[4]) > 0) then begin
                  ShowMessage('Числа десятичного формата или формата 11-19 не могут повторяться!');
                  Result := 0;
                  Exit;
              end;

              Result := h + m;
              for j := 4 to 5 do begin
                 if (mass[j] <> '') then begin
                    ShowMessage('Ошибка в слове ( ' + mass[j] + ')!');
                    Result := 0;
                    Exit;
                 end;
              end;

           end
           else begin
              e := GetElementary(mass[3]);
              if (GetElementary(mass[4]) > 0) then begin
                  ShowMessage('Числа единичного формата не могут повторяться');
                  Result := 0;
                  Exit;
              end;
              if (e > 0) then begin
                if (mass[4] = 'und') then und := True;
                if ((mass[5] = 'und') and (und = True)) then begin
                  ShowMessage('''und'' уже стоит!');
                  Result := 0;
                  Exit;
                end;

                if (GetElementary(mass[4]) > 0) then begin
                  ShowMessage('Число десятичного формата идет после единичного и слова ''und''');
                  Result := 0;
                  Exit;
                end;

                m := GetMiddle(mass[5]);
                if (m mod 10 > 0) then begin
                  ShowMessage('Числа формата от 11 до 19 не пишутся вместе с единичным форматом!');
                  Result := 0;
                  Exit;
                  end;
                if ((und = True) and (m = 0) and (mass[5] <> '')) then begin
                  ShowMessage('После ''und'' должно идти число десятичного формата!');
                  Result := 0;
                  Exit;
                end;
                if (und = False) then
                  m := GetMiddle(mass[4]);
                if ((und = False) and (m > 0)) then begin
                  ShowMessage('Нехватает ''und'' между десятичным форматом и форматом от 1 до 9');
                  Result := 0;
                  Exit;
                end;
                if ((und = True) and (m = 0)) then begin
                  ShowMessage('''und'' не требуется!');
                  Result := 0;
                  Exit;
                end;

                if (m = 0) then begin
                  if (mass[3] = 'eins') then begin
                    ShowMessage('Окончаение у ein(s) не требуется!');
                    Result := 0;
                    Exit;
                  end;
                  for j := 4 to 5 do begin
                    if (mass[j] <> '') then begin
                      ShowMessage('Ошибка в слове ( ' + mass[j] + ')!');
                      Result := 0;
                      Exit;
                    end;
                  end;
                end
                else begin
                  if (mass[3] = 'ein') then begin
                    ShowMessage('Отсутствует окончаение у ein(s)!');
                    Result := 0;
                    Exit;
                  end;
                end;

                if ((m > 0) and (und = True)) then
                  Result := h + m + e;
                if ((m = 0) and (und = False)) then
                  Result := h + e;
              end
              else begin
                if (mass[3] <> '') then begin
                  ShowMessage('Ошибка в слове ( ' + mass[3] + ')!');
                  Result := 0;
                  Exit;
                end;
                Result := h;
              end;
           end;
        end
        else begin
          if ((mass[1] = 'und') or (mass[3] = 'und')) then begin
            ShowMessage('''und'' не требуется!');
            Result := 0;
            Exit;
          end;

          if (mass[2] = 'und') then und := True;
          if ((und = False) and (mass[2] <> '')) then begin;
            ShowMessage('После единичного формата может стоять либо ''hundert'', либо ''und''!');
            Result := 0;
            Exit;
          end;
          for j := 3 to 5 do begin
            if ((mass[j] = 'und') and (und = True)) then begin
              ShowMessage('''und'' уже стоит!');
              Result := 0;
              Exit;
            end;
          end;
          m := GetMiddle(mass[3]);
          if (m mod 10 > 0) then begin
                  ShowMessage('Числа от 11 до 19 не пишутся вместе с единичным форматом!');
                  Result := 0;
                  Exit;
                  end;
          if ((m = 0) and (mass[3] <> '')) then begin
            ShowMessage('После ''und'' идёт число десятичного формата!');
            Result := 0;
            Exit;
          end;

          if ((und = False) and (m > 0)) then begin
            ShowMessage('Нехватает ''und'' между десятичным форматом и форматом от 1 до 9');
            Result := 0;
            Exit;
          end;
          if ((und = True) and (m = 0)) then begin
            ShowMessage('''und'' не требуется!');
            Result := 0;
            Exit;
          end;

          if (m = 0) then begin
            if (mass[1] = 'ein') then begin
              ShowMessage('Отсутствует окончаение у ein(s)!');
              Result := 0;
              Exit;
            end;
            for j := 2 to 5 do begin
              if (mass[j] <> '') then begin
                ShowMessage('Ошибка в слове ( ' + mass[j] + ')!');
                Result := 0;
                Exit;
              end;
            end;
          end
          else begin
            if (mass[1] = 'eins') then begin
              ShowMessage('Окончаение у ein(s) не требуется!');
              Result := 0;
              Exit;
            end;
          end;

          for j := 4 to 5 do begin
            if (mass[j] <> '') then begin
              ShowMessage('Ошибка в слове ( ' + mass[j] + ')!');
              Result := 0;
              Exit;
            end;
          end;

          Result := e + m;
        end;

      end
      else begin
        ShowMessage('Ошибка в слове ( ' + mass[1] + ')!');
        Result := 0;
      end;
  end;
end;


function TForm1.GetMiddle(s1 : string) : Integer;
begin
  if (s1 = 'zehn') then Result := 10
  else if (s1 = 'elf') then Result := 11
  else if (s1 = 'zwolf') then Result := 12
  else if (s1 = 'dreizehn') then Result := 13
  else if (s1 = 'vierzehn') then Result := 14
  else if (s1 = 'funfzehn') then Result := 15
  else if (s1 = 'sechzehn') then Result := 16
  else if (s1 = 'siebzehn') then Result := 17
  else if (s1 = 'achtzehn') then Result := 18
  else if (s1 = 'neunzehn') then Result := 19
  else if (s1 = 'zwanzig') then Result := 20
  else if (s1 = 'dreizig') then Result := 30
  else if (s1 = 'vierzig') then Result := 40
  else if (s1 = 'funfzig') then Result := 50
  else if (s1 = 'sechzig') then Result := 60
  else if (s1 = 'siebzig') then Result := 70
  else if (s1 = 'achtzig') then Result := 80
  else if (s1 = 'neunzig') then Result := 90
  else Result := 0;
end;

function TForm1.GetElementary(s1 : string) : Integer;
begin
  if ((s1 = 'ein') or (s1 = 'eins')) then begin
    Result := 1;
  end
  else if (s1 = 'zwei') then begin
    Result := 2;
  end
  else if (s1 = 'drei') then begin
    Result := 3;
  end
  else if (s1 = 'vier') then begin
    Result := 4;
  end
  else if (s1 = 'funf') then begin
    Result := 5;
  end
  else if (s1 = 'sechs') then begin
    Result := 6;
  end
  else if (s1 = 'sieben') then begin
    Result := 7;
  end
  else if (s1 = 'acht') then begin
    Result := 8;
  end
  else if (s1 = 'neun') then begin
    Result := 9;
  end
  else Result := 0;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  lbl1.Caption := 'Строка:';
  lbl3.Caption := 'Арабские:';
  lbl4.Caption := 'Русские:';
  edt1.Text := '';
  edt2.Text := '';
  edt2.ReadOnly := True;
  edt3.Text := '';
  edt3.ReadOnly := True;
  Form1.Caption := 'Домашняя работа №1';
  btn1.Caption := 'Перевести в цифры';
  for p := 1 to 5 do
    mass[p] := '';

  p := 1;
end;

procedure TForm1.btn1Click(Sender: TObject);
var i, j, m : Integer; s2, sstr : string; flag : Boolean;
begin
  if (Length(edt1.Text) < 1) then begin
    ShowMessage('Введите число от 0 до 999 на Немецком в строку прописью!');
    Exit;
  end;

  s2 := edt1.Text;

  for p := 1 to 10 do
    mass[p] := '';

  flag := False;
  m := 1;
  p := 0;
  sstr := '';

  for j := 1 to Length(s2) do begin
    if (s2[j] <> ' ') then begin
      if (flag = False) then begin
        Inc(p);
        if (p > 6) then begin
          ShowMessage('Слишком много слов! Максимальная длина - 5 слов.');
          Exit;
        end;
        m := 1;
        flag := True;
      end;

      if (s2[j] in ['0'..'9']) then begin
        ShowMessage('Присутствует арабская цифра или цифры!');
        Exit;
      end;


      insert(s2[j], mass[p], m);
      Inc(m);
    end
    else begin
      if (flag = True) then
        flag := False;
    end;
  end;

  for j := 1 to p do
    LowerCase(mass[j]);

  i := Form1.ConvertToInt;
  edt2.Text := IntToStr(i);
  Edt3.Text := '';

  while (i >= 1) do begin
    if (i >= 500) then begin
      Edt3.Text := Edt3.Text + 'Ф';
      i := i - 500;
    end
    else if (i >= 100) then begin
      Edt3.Text := Edt3.Text + 'Р';
      i := i - 100;
    end
    else if (i >= 30) then begin
      Edt3.Text := Edt3.Text + 'Л';
      i := i - 30;
    end
    else if (i >= 8) then begin
      Edt3.Text := Edt3.Text + 'И';
      i := i - 8;
    end
    else if (i >= 2) then begin
      Edt3.Text := Edt3.Text + 'В';
      i := i - 2;
    end
    else if (i >= 1) then begin
      Edt3.Text := Edt3.Text + 'А';
      Dec(i);
    end;
  end;


end;

end.

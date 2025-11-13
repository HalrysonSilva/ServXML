unit FRM_EMAIL_PROGRESSO;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,Vcl.ComCtrls, Vcl.StdCtrls;

type
  TFRMEMAIL = class(TForm) // <<<<<<--- O nome da CLASSE do formulário é TFRMEMAIL
    PBEMAIL: TProgressBar;
    LabelEMAIL: TLabel;
    // ...
  private
    { Private declarations }
  public
    // Métodos públicos para atualizar a UI do progresso
    procedure AtualizarProgresso(Porcentagem: Integer; const Mensagem: String);
    procedure FinalizarProgresso(const MensagemFinal: String; Sucesso: Boolean);
  end;

var
  FRMEMAIL: TFRMEMAIL; // <<<<<<--- A VARIÁVEL GLOBAL do formulário é FRMEMAIL

implementation

{$R *.dfm}

procedure TFRMEMAIL.AtualizarProgresso(Porcentagem: Integer; const Mensagem: String);
begin
  if Assigned(PBEMAIL) then
  begin
    PBEMAIL.Position := Porcentagem;
    if PBEMAIL.Position > PBEMAIL.Max then PBEMAIL.Position := PBEMAIL.Max;
    if PBEMAIL.Position < PBEMAIL.Min then PBEMAIL.Position := PBEMAIL.Min;
  end;
  if Assigned(LabelEMAIL) then
    LabelEMAIL.Caption := Mensagem;
  Application.ProcessMessages;
end;

procedure TFRMEMAIL.FinalizarProgresso(const MensagemFinal: String; Sucesso: Boolean);
begin
  if Assigned(LabelEMAIL) then
    LabelEMAIL.Caption := MensagemFinal;
  if Assigned(PBEMAIL) then
  begin
    if Sucesso then
      PBEMAIL.Position := PBEMAIL.Max
    else
      PBEMAIL.Position := PBEMAIL.Min;
  end;
  Application.ProcessMessages;
end;

end.

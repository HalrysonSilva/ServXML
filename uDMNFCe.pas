unit uDMNFCe;

interface

uses
  SysUtils, Classes, ACBrNFe, ACBrNFeDANFEClass, ACBrNFeDANFeESCPOS,
  uNFCeIGService, Messages, Forms, Dialogs, DB, MemDS, DBAccess, svFuncoesNFCe,
  Windows, ShellAPI, ACBrBase, ACBrSocket, ACBrIBPTax, ACBRNFE.CLASSES,
  pcnConversao, ACBrDFe, ACBrPosPrinter, Uni, RDprint,
  Soap.InvokeRegistry, Soap.Rio, Soap.SOAPHTTPClient, ACBrDFeReport,
  ACBrDFeDANFeReport, uPacotesNFCe, System.Net.URLClient,
  Vcl.ExtCtrls, System.DateUtils, pcnConversaoNFe, ACBrNFeDANFEFR;

 {
type
  TTipoNFCeEnvio = (
                 reqEnviarCupom,
                 reqEnviarCancelamento,
                 reqEnviarReimpressao,
                 reqEnviarCupomContigencia,
                 reqCriarCupomContigencia,
                 reqEnviarCupomRejeitado
                 );     }
type
  TCupomOffline = class
    private
    FTempoInicio: TDateTime;
    FTempoFinal: TDateTime;
    FTempoMinutosOffline: integer;
    FTempoMinutosRestante: integer;
    FAtivo: Boolean;

    public
    property TempoInicio: TDateTime read FTempoInicio write FTempoInicio;
    property TempoFinal: TDateTime read FTempoFinal write FTempoFinal;
    property TempoMinutosOffline: integer read FTempoMinutosOffline write FTempoMinutosOffline;
    property TempoMinutosRestante: integer read FTempoMinutosRestante write FTempoMinutosRestante;
    property Ativo: Boolean read FAtivo write FAtivo;
  end;

type
  TdmNFCe = class(TDataModule)
    ACBrNFe1: TACBrNFe;
    qryInfVenda: TUniQuery;
    qryInfVendapedido: TIntegerField;
    qryInfVendaTroco: TFloatField;
    qryInfVendaChave_Acesso: TStringField;
    qryInfVendaNota: TIntegerField;
    qryInfVendaSerie: TStringField;
    qry: TUniQuery;
    qryInfVendanum_mod_doc: TIntegerField;
    qryVena: TUniQuery;
    qryVenaControle: TIntegerField;
    qryVenaData: TDateTimeField;
    qryVenaLkTipo: TIntegerField;
    qryVenaNota: TIntegerField;
    qryVenaSerie: TStringField;
    qryVenaPedido: TIntegerField;
    qryVenaLkReceb: TIntegerField;
    qryVenaLkVendedor: TIntegerField;
    qryVenaLkCliente: TIntegerField;
    qryVenaLkFornec: TIntegerField;
    qryVenaTagCliente: TIntegerField;
    qryVenaComissao: TFloatField;
    qryVenaObs: TStringField;
    qryVenaVenda: TBooleanField;
    qryVenaLkUser: TIntegerField;
    qryVenaCFOP: TStringField;
    qryVenaCancelada: TBooleanField;
    qryVenaTipoDoc: TStringField;
    qryVenaLkOrca: TIntegerField;
    qryVenaCliente: TStringField;
    qryVenaBairro: TStringField;
    qryVenaEndereco: TStringField;
    qryVenaCidade: TStringField;
    qryVenaUF: TStringField;
    qryVenaTOTAL: TFloatField;
    qryVenaDESCONTO: TFloatField;
    qryVenaACRESCIMO: TFloatField;
    qryVenaSUBTOTAL: TFloatField;
    qryVenaVLPAGO: TFloatField;
    qryVenaEntrada: TFloatField;
    qryVenaFaturado: TFloatField;
    qryVenaKm: TIntegerField;
    qryVenaPlaca: TStringField;
    qryVenaHoraIni: TStringField;
    qryVenaHoraFim: TStringField;
    qryVenaDescricao: TStringField;
    qryVenaLkTurno: TIntegerField;
    qryVenaDataTurno: TDateTimeField;
    qryVenaDataSaida: TDateTimeField;
    qryVenaVenda_Servico: TStringField;
    qryVenaidEmpresa: TIntegerField;
    qryVenaContrato: TIntegerField;
    qryVenaCupom: TIntegerField;
    qryVenaLkECF: TIntegerField;
    qryVenaQtdItens: TIntegerField;
    qryVenaDataEntrega: TDateTimeField;
    qryVenaRG_INSC: TStringField;
    qryVenaCPF_CNPJ: TStringField;
    qryVenaIdControle: TIntegerField;
    qryVenaVendedor: TStringField;
    qryVenaStatus: TStringField;
    qryVenabloqueado: TIntegerField;
    qryVenaLkCaixa: TIntegerField;
    qryVenaLkUsuario: TIntegerField;
    qryVenaSaldo_limite: TFloatField;
    qryVenaVlBonus: TFloatField;
    qryVenaComplEnd: TStringField;
    qryVenaTelefone: TStringField;
    qryVenaeMail: TStringField;
    qryVenalkConvenio: TIntegerField;
    qryVenaComissaoItemValor: TFloatField;
    qryVenaComissaoNota: TFloatField;
    qryVenaCodigo: TStringField;
    qryVenaORCAMENTO: TIntegerField;
    qryVenac_Status: TStringField;
    qryVenaTagFisica: TBooleanField;
    qryVenaC_Bloqueado: TStringField;
    qryVenac_PerDesconto: TFloatField;
    qryVenac_PerAcrescimo: TFloatField;
    qryVenac_LucroPercentual: TFloatField;
    qryVenac_LucroTotal: TFloatField;
    qryVenaLkCxFecha: TIntegerField;
    qryVenac_Diferenca: TFloatField;
    qryVenaNumero: TStringField;
    qryVenaNum_Mod_Doc: TIntegerField;
    qryVenanProt: TStringField;
    qryVenaNFCe_Data: TDateTimeField;
    qryVenaNFCe_enviada: TIntegerField;
    qryVenaCod_Mun: TIntegerField;
    qryVenaCEP: TStringField;
    qryVenb: TUniQuery;
    qryVenbControle: TIntegerField;
    qryVenbidEmpresa: TIntegerField;
    qryVenbPEDIDO: TIntegerField;
    qryVenbLkEst3A: TIntegerField;
    qryVenbLkProduto: TIntegerField;
    qryVenbProduto: TStringField;
    qryVenbCodInterno: TStringField;
    qryVenbCodORIGEM: TStringField;
    qryVenbQtdAtacado: TFloatField;
    qryVenbPeso: TFloatField;
    qryVenbServico: TBooleanField;
    qryVenbQuantidade: TFloatField;
    qryVenbVlUnitario: TFloatField;
    qryVenbTotal: TFloatField;
    qryVenbAcrescimo: TFloatField;
    qryVenbDesconto: TFloatField;
    qryVenbComissao: TFloatField;
    qryVenbPrecoVenda: TFloatField;
    qryVenbCor: TStringField;
    qryVenbCST: TIntegerField;
    qryVenbCFOP: TIntegerField;
    qryVenbDataInc: TDateTimeField;
    qryVenbHoraFim: TStringField;
    qryVenbHoraIni: TStringField;
    qryVenbICMS: TFloatField;
    qryVenbCSTECF: TStringField;
    qryVenbLkBaixa: TIntegerField;
    qryVenblkClienteItem: TIntegerField;
    qryVenbLkGuiche: TIntegerField;
    qryVenblkPreco: TIntegerField;
    qryVenblkVarejo_Atacado: TIntegerField;
    qryVenbLkVendedor: TIntegerField;
    qryVenbVendedor: TStringField;
    qryVenbLucro: TFloatField;
    qryVenbMARCA: TStringField;
    qryVenbQtdReal: TFloatField;
    qryVenbQtdSaldo: TFloatField;
    qryVenbQuantCanc: TFloatField;
    qryVenbTipoOper: TIntegerField;
    qryVenbTotVenda: TFloatField;
    qryVenbUnidade: TStringField;
    qryVenbVenda_Servico: TStringField;
    qryVenbVlBonus: TFloatField;
    qryVenbPrCusto: TFloatField;
    qryVenbidControle: TIntegerField;
    qryVenbFracUN: TStringField;
    qryVenbFracQtd: TFloatField;
    qryVenbFracQtdTotal: TFloatField;
    qryVenbLkCxFecha: TIntegerField;
    qryVenbItem: TIntegerField;
    qryVenbcItem: TIntegerField;
    qryVenbEntrega: TIntegerField;
    qryVenbLkPrevenda: TIntegerField;
    DsQryVena: TDataSource;
//    ACBrPosPrinter1: TACBrPosPrinter;
    RDprint: TRDprint;
//    DANFEFastReport: TACBrNFeDANFEFR;
    HTTPRIO1: THTTPRIO;
    DANFEFastReport_: TACBrNFeDANFEFR;
    DANFeESCPOS1: TACBrNFeDANFeESCPOS;
    ACBrPosPrinter1: TACBrPosPrinter;
    DANFEFastReport: TACBrNFeDANFCEFR;
    qVendaXml: TUniQuery;
    dsCfg_Venda: TDataSource;
    qryCfg_Venda: TUniQuery;
    qryCfg_VendaAUTOCADASTRO: TStringField;
    qryCfg_VendaOBSVENDA: TStringField;
    qryCfg_VendaDESCONTO: TStringField;
    qryCfg_VendaLANCAVENDA: TStringField;
    qryCfg_VendaTIPODESCONTO: TStringField;
    qryCfg_VendaALTERADATA: TStringField;
    qryCfg_VendaTROCO: TStringField;
    qryCfg_VendaImprimeNota: TStringField;
    qryCfg_VendaESTOQUEINSUFICIENTE: TStringField;
    qryCfg_VendaPRECOMENOR: TStringField;
    qryCfg_VendaIMPRIMEDESC: TStringField;
    qryCfg_VendaBloqueiaProdutoSemPreco: TStringField;
    qryCfg_VendaTURNO: TStringField;
    qryCfg_VendaDATATURNO: TStringField;
    qryCfg_VendaDESCONTO2: TStringField;
    qryCfg_VendaACRESCIMO: TStringField;
    qryCfg_VendaATIVABLOQUEIO: TStringField;
    qryCfg_VendaFARMACIA: TStringField;
    qryCfg_VendaDESBLOQ_CLI_AUTO: TStringField;
    qryCfg_VendaSEL_VENDEDOR_VENDA: TStringField;
    qryCfg_VendaModoGravacaoForcado: TStringField;
    qryCfg_VendaBloqueiaVendaAtacado: TStringField;
    qryCfg_VendaEXCLUI_CAIXA_CANCELAMENTO: TStringField;
    qryCfg_VendaPapelParedeMenu: TStringField;
    qryCfg_VendaINIBEMARCAS: TStringField;
    qryCfg_VendaMenuRelatorio: TStringField;
    qryCfg_VendaNfcSolicitaCPF: TStringField;
    qryCfg_VendaVerificaECF: TStringField;
    qryCfg_VendaPrefPreencheNulos: TStringField;
    qryCfg_VendaPrefPreVenda: TStringField;
    qryCfg_VendaFRACAO: TStringField;
    qryCfg_VendaFINALIZA_POR_TECLA: TStringField;
    qryCfg_VendaSelecionaSerie: TStringField;
    qryCfg_VendaBloqueiaFormaPagto: TStringField;
    qryCfg_VendaValidaVendedor: TStringField;
    qryCfg_VendaValidaItensServicos: TStringField;
    qryCfg_VendaNrCasaDecimais: TStringField;
    qryCfg_VendaDescGrupoAutomatico: TStringField;
    qryCfg_VendaDevolucaoSenha: TStringField;
    qryCfg_VendaAvisaItemLancado: TStringField;
    qryCfg_VendaBloqueiaImpressaoVendaSemFormaPagamento: TStringField;
    qryCfg_VendaImpEnvelopeOrientacao: TStringField;
    qryCfg_VendaMEIO_A_MEIO: TBooleanField;
    qryCfg_VendaCARTAO_EMITE_CUPOM_AUTO: TBooleanField;
    qryCfg_VendaCupomTrocaAutomatico: TBooleanField;
    qryCfg_VendaCupomTrocaTexto: TMemoField;
    tmrTransmitir: TTimer;
    qryVendaNrNFCe: TUniQuery;
    qryVendaNrNFCeControle: TIntegerField;
    qryVendaNrNFCePedido: TIntegerField;
    qryVendaNrNFCeNota: TIntegerField;
    qryVendaNrNFCeSerie: TStringField;
    qryVendaNrNFCeNum_Nota_Fiscal: TIntegerField;
    qryVendaNrNFCeNum_Serie: TIntegerField;
    qryVendaNrNFCeChaveNFe: TStringField;
    qryVendaNrNFCeStatusNFCe: TStringField;
    qryVendaNrNFCeCodEmitente: TIntegerField;
    qryVendaNrNFCeTipo_Amb: TIntegerField;
    qryVendaNrNFCeDataCriacao: TDateTimeField;
    qryVendaNrNFCeXMLTexto: TMemoField;
    qryVendaNrNFCenProt: TWideStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure tmrTransmitirTimer(Sender: TObject);
  private
    { Private declarations }
    impVelocidade: Integer;
    vImpTroco: Double;
    bExecutaComandoPorta: Boolean;
    NFCe_Servico: IGService;
    NFCe_TipoReq :  TTipoPacoteRequisicao;
    TempoEmContigencia: TDateTime;

    procedure ImprimirVenda(bVisualizar: Boolean; nVias: integer=1);

    procedure NFCe_ExecutaCMDPorta(sPorta, sVelocidade: string);
    function AC_ImprimeConfiguraModoImpressao(iModo: Integer): Boolean;
    function AC_ImprimePedidoA4(bVisualizar: Boolean = false): Boolean;
    function NFCe_LerIdToken(sCNPJ, sToken, idToken: string): string;
    function Fun_CompletaStrLeft(Conteudo, Caractere: string;
      Tamanho: Integer): string;
    function AC_ImprimePedidoNFCeSpooler(bVisualizar: Boolean = false;nVias : integer=1): Boolean;
    procedure MensagemAviso(Texto: string);
    Function ConfiguraPathPDF: String;
    function EntregaImp_MontaImpressao(iViaNr: Integer): Boolean;
    function AC_ImprimeConfiguraRdPrint: Boolean;
    function GetNFCe_CupomSomenteGerado(codVenda: Integer=0): Boolean;
    function GetNFCe_TipoReqEnvio(codVenda: Integer=0 ): TTipoPacoteRequisicao ;
    /// <summary>
    ///   Verifica se existe um XML transmitido referente a venda passada, ou
    ///   seja, se a venda já foi transmitida
    /// </summary>
    function GetNFCe_TransmitidoSemRetorno(codVenda: Integer): Boolean;
    function GetTempoContingencia: Boolean;
    procedure SetTempoContingencia;








  public
    { Public declarations }
    req: TRequisicao;
    res: TResposta;
    CupomOffline : TCupomOffline;
    bContigenciaPDV : Boolean;
    cfg_ImpSpooler : Boolean;

    procedure ConfiguraDispositivo(bHabilitar: Boolean);
    Function ProcessarVenda(Codigo: Integer; bVisualizar: Boolean = false;bImprime :Boolean=true;nVias : integer=1)
      : TRetornoNFCe;
    procedure AC_GavetaAcionaNFCe;
    procedure Ac_AcionaGavetaPelaImpressora(DispositivoGaveta: TAcbrposPrinter; sPorta : string='');
    procedure AC_GhulhotinaAciona;
    Function AC_ImprimePedido(iPedido: Integer; Conteudo: TStringList;
      bCortaPapel: Boolean): Boolean;
    function CancelarCupomVenda(Codigo: Integer): TRetornoNFCe;
    function AC_ImprimirNFCePedido(iPedido: Integer; Conteudo: TStringList;
      bCortaPapel: Boolean): Boolean;
    function AC_BaixaArquivoWeb(EnderecoWeb, DestinoLocal: string): Boolean;

    Function EntregaImp_Via(iPedido: Integer; iVias: Integer = 2): Boolean;
    function Entrega_SelecionaVenda(iPedido: Integer;
      iEntrega: Integer = 1): Boolean;
    procedure Entregar(bMarcarTodos: Boolean);
    procedure Entregar_MarcarPedido(bMarcarTodos: Boolean = false;
      iPedido: Integer = 0);
    function AC_ImprimirConteudoRdPrint(iPedido: Integer; Conteudo: TStringList;
      bCortaPapel: Boolean=true): Boolean;
    function ProcessarVendaTesteSemImpressao(Codigo: Integer; bVisualizar: Boolean=FALSE): TRetornoNFCe;
    function Pedido_ImprimeCupomTroca(codVenda :Integer=0; bAutomatico :Boolean=true) : Boolean;
    //NFCe
    function GetNFCe_NrCupomJaFoiTransmitido(codVenda: Integer=0): Boolean;
    function GetNFCe_CupomJaFoiTransmitido(codVenda: Integer=0): Boolean;


    //--------------ENVIO CUPOM POR WHATSAPP--------------------
    function EnviaNFCe_ApiZap(iPedidoVenda: Integer=0; sNrTelefoneZap: string='';bSolicitarNrTelefone : Boolean = false ): Boolean;

  end;

var
  dmNFCe: TdmNFCe;

implementation

uses
    ServDBU, SvDmVen, ACBrNFeNotasFiscais,
  svFuncoes, SvDmDados, untMsgProcesso, DataServ, uGHttpRequest, SERVMSG, Printers,
  untCLib.Objetos.Venda.Informacoes, svDmZap, CONEXAOBD, Frm_ACBrNFe,
  Frm_ConfiguraSerial, Frm_SelecionarCertificado, Frm_Status, MENU, TELAESPERA;

{$R *.dfm}

procedure TdmNFCe.DataModuleCreate(Sender: TObject);
var
  iPorta: Integer;
  sIp: string;
begin

  try

     bExecutaComandoPorta := false;

    sIp := LerSysPdv('NFCe', 'IP');
    iPorta := LerSysPdvInt('NFCe', 'Porta');
    NFCe_Servico := GetIGService( true, 'http://' + sIp + ':' + IntToStr(iPorta)
      + '/wsdl/IGService');

    ConfiguraDispositivo(false);
    cfg_ImpSpooler := ( LerSysPdvInt('DANFE', 'MODELO') > 0 );
  except

  end;

  try
    dmNFCe.bContigenciaPDV := LerSysBool('NFCe','Contigencia');
    qryCfg_Venda.Open;
  finally

  end;

end;

procedure TdmNFCe.NFCe_ExecutaCMDPorta(sPorta, sVelocidade: string);
var
  sCMD: string;
  ResultCode: Integer;
begin

  try
    sCMD := 'Mode ' + sPorta + ':' + sVelocidade + ',n,8,1';

    ResultCode := ShellExecute(0, PChar('Open'), PChar('cmd.exe'), PChar(sCMD),
      nil, SW_HIDE);
    GravaSYS('NFCe', 'CMD', TimeToStr(Now) + ' - ' + sCMD);
  except
    GravaSYS('NFCe', 'CMD FALHA', TimeToStr(Now) + ' - ' + sCMD);
  end;

end;

function TdmNFCe.ProcessarVenda(Codigo: Integer; bVisualizar: Boolean = false;bImprime :Boolean=true;nVias : integer=1)
  : TRetornoNFCe;
var
  iNota, iSerie: Integer;
  sChave, sProt: string;
  sMensagemValidacao: string;
  iPosicaoCorte: Integer;
  bCupomTransmitido, bModoContigencia : BOOL;
  sMsgContigencia : string;
  objVendaInformacoes: TVendaInformacoes;

begin

  try
    objVendaInformacoes := TVendaInformacoes.Create;

    (*Ler Informações da Venda*)
    qryInfVenda.close;
    qryInfVenda.ParamByName('ped').Value := Codigo;
    qryInfVenda.Open;

    self.req := TRequisicao.Create;
    self.req.Codigo := Codigo;


    bCupomTransmitido := GetNFCe_CupomJaFoiTransmitido(Codigo );

    {
    if (GetTempoContingencia()) then
    begin
  //    LogTracer('Tempo em contigência ativo');
      Self.req.Tipo := reqCriarCupomContigencia;
    end
    else
     }
    begin //new
      if ( bCupomTransmitido = true ) then //antes:       if ( qryInfVendaNota.Value > 0 ) then
        Self.req.Tipo := reqEnviarReimpressao
      else
        Self.req.Tipo := reqEnviarCupom; // reqEnviarReimpressao;
    end;

        (*Modo Forçado de Contigência...*)
//          bModoContigencia :=  LerSysBool('NFCe','Contigencia') ;


        (*Configura Tipo de Envio: Re-impressao, Re-envio ou Envio*)
    //     NFCe_TipoReq :=  GetNFCe_TipoReqEnvio(Codigo);


//        if bModoContigencia then
//          sMsgContigencia := ' "EM CONTIGÊNCIA" [Off-Line] !!! '
//          else
//          sMsgContigencia := '';

        tmrTransmitir.Enabled := True;

        Application.ProcessMessages;
        Sleep(1200);

        TFuncoesNFCe.Aguardar('L',
          'Transmitindo Cupom Fiscal Eletrônico NFC-e...' + sLineBreak + sMsgContigencia);

        objVendaInformacoes.CarregarDados(Codigo, qry);

        bCupomTransmitido := GetNFCe_CupomJaFoiTransmitido(Codigo );


//        if ((objVendaInformacoes.serie <> '') and (objVendaInformacoes.nota > 0))   //cab vendas
//              or (bCupomTransmitido = True)  then                                   //Xml_temp
//          Self.req.Tipo := reqEnviarReimpressao;

//        if not bModoContigencia then
//        begin
//         res := TResposta.Create( NFCe_Servico.EnviarRequisicao(req.ToString) );
//
//
//        end
//        else
//        if bModoContigencia then
//          begin
//            req.Tipo := reqCriarCupomContigencia;
//            res := TResposta.Create( NFCe_Servico.EnviarRequisicao(req.ToString) );
//          end;

        FormatSettings.DecimalSeparator := ',';
        FormatSettings.ThousandSeparator := '.';





       if res.DeuErro then
       begin
         // ShowMessage(res.Mensagem);
         sMensagemValidacao := res.Mensagem;
         if  UpperCase( DMDADOS.cfg_Usuario ) = 'COMPUSERVE' then
          begin
             if FileExists('LogNFCeMsg.txt') then
               DeleteFile('LogNFCeMsg.txt');
             GravaArqTxt(sMensagemValidacao, 'LogNFCeMsg.txt' );
          end;


          BuscaTroca(sMensagemValidacao, '| |', ' ');

         //**--PROV sMensagemValidacao := BuscaTroca(sMensagemValidacao, '|', #13#10);

          iPosicaoCorte := Pos('Contate o suporte tecnico', sMensagemValidacao) +
            length('Contate o suporte tecnico');
          //Delete(sMensagemValidacao, 1, iPosicaoCorte);
          if bImprime then
            MensagemAviso('Atenção: ' + #13#10 + sMensagemValidacao);

          Result.Autorizada := false;

        end
        else
               { //**--//**--//**--//**--

               * * * DESATIVADO BLOCO ABAIXO CONTIGENCIA 09/01/2025  * * *

               //**--//**--//**--//**--//**--//**--
        if (self.res.status = 0) and (self.res.DeuErro = False) then
        begin
//        LogTracer('Cupom emitido em contingência');
          SetTempoContingencia();
        end;  }

        if (self.res.DeuErro = False) then
        begin
          ACBrNFe1.NotasFiscais.Clear;
          ACBrNFe1.NotasFiscais.LoadFromString(res.ObjRetorno);
          iNota := ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.nNF;
          iSerie := ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.serie;
          sChave := Copy(ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID, 4, 44);
          NFCe_LerIdToken(ACBrNFe1.NotasFiscais.Items[0].NFe.Emit.CNPJCPF, '', '');
          sProt := ACBrNFe1.NotasFiscais.Items[0].NFe.procNFe.nProt;

          Result.Chave := sChave;
          Result.serie := iSerie;
          Result.Nota := iNota;

        //Gravar o número do cupom fiscal na venda
        if (qryInfVendaNota.IsNull) OR (qryInfVendaNota.AsString = '0') then
        begin
          qry.close;
          qry.sql.Clear;
          qry.sql.Add('update tabest3a set num_mod_doc = 65, serie = ' +
            QuotedStr(IntToStr(iSerie)) + ', nota = ' +
            QuotedStr(IntToStr(iNota)) + ', Chave_acesso = ' +
            QuotedStr(Copy(sChave, 4, 44)) +
             ', nProt = ' + QuotedStr(sProt)
            + ' where pedido = ' +             IntToStr(Codigo));
          qry.ExecSQL;
          DmDados.Pedido_BaixaEstoqueFiscal(Codigo);
        end;


          qryInfVenda.close;
          qryInfVenda.ParamByName('ped').Value := Codigo;
          qryInfVenda.Open;
          vImpTroco := qryInfVendaTroco.Value;

          TFuncoesNFCe.Aguardar('L', 'Imprimindo NFC-e... ' + sMsgContigencia);

          try
            if bImprime then
              ImprimirVenda(bVisualizar,nVias);
            Result.Imprimiu := true;
          except
            on E: Exception do
            begin

              DmDados.GravaLogAcao(Codigo, 'NFCe', 'Falha ao imprmir NFC-e: ' +
                E.Message);
              Result.Imprimiu := false;

            end;

          end;

          try


          except
            on E: Exception do
              DmDados.GravaLogAcao(Codigo, 'NFCe',
                'Inconsistencia ao gerar e gravar chave: ' + QuotedStr(Copy(sChave,
                4, 44)) + ' - ' + E.Message);
          end;

          Result.Autorizada := true;
        end;

  finally
    TFuncoesNFCe.Aguardar('', '');

  end;

end;

(* Cancelar Venda *)
function TdmNFCe.CancelarCupomVenda(Codigo: Integer): TRetornoNFCe;
var
  req: TRequisicao;
  res: TResposta;

  arquivo: TStringList;
  iNota, iSerie: Integer;
  sChave: string;

begin

  try

    TFuncoesNFCe.Aguardar('L',
      'Solicitando Cancelamento de Cupom Fiscal Eletrônico ao consumidor NFC-e...');
    req := TRequisicao.Create;
    req.Codigo := Codigo;
    req.Tipo := reqEnviarCancelamento;

    res := TResposta.Create(NFCe_Servico.EnviarRequisicao(req.ToString));

    FormatSettings.DecimalSeparator := ',';
    FormatSettings.ThousandSeparator := '.';

    if res.DeuErro then
    begin
      // TFuncoesNFCe.Aguardar('L','Problemas encontrados: ' + #13 + res.Mensagem );
      ShowMessage(res.Mensagem);
      Result.Autorizada := false;

    end
    else
    begin
      arquivo := TStringList.Create;
      arquivo.Text := res.ObjRetorno;

      arquivo.SaveToFile('cfe.xml');

      ACBrNFe1.NotasFiscais.Clear;
      ACBrNFe1.NotasFiscais.LoadFromString(arquivo.Text);

      iNota := ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.nNF;
      iSerie := ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.serie;
      sChave := Copy(ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID, 4, 44);
      // NFCe_LerIdToken( ACBrNFe1.NotasFiscais.Items[0].NFe.

      Result.Chave := sChave;
      Result.serie := iSerie;
      Result.Nota := iNota;

      qryInfVenda.close;
      qryInfVenda.ParamByName('ped').Value := Codigo;
      qryInfVenda.Open;
      vImpTroco := qryInfVendaTroco.Value;

      TFuncoesNFCe.Aguardar('L', 'Imprimindo NFC-e...');

      try
        if (qryInfVendaNota.IsNull) OR (qryInfVendaNota.AsString = '0') then
        begin
          qry.close;
          qry.sql.Clear;
          qry.sql.Add('update tabest3a set num_mod_doc = 65, serie = ' +
            QuotedStr(IntToStr(iSerie)) + ', nota = ' +
            QuotedStr(IntToStr(iNota)) + ', Chave_acesso = ' +
            QuotedStr(Copy(sChave, 4, 44)) + ' where pedido = ' +
            IntToStr(DmVEnda.TabVenaPedido.AsInteger));
          qry.ExecSQL;
          // dmdados.Pedido_BaixaEstoqueFiscal(Codigo) ;
        end;
      except
        on E: Exception do
          DmDados.GravaLogAcao(Codigo, 'NFCe',
            'Inconsistencia ao gerar e gravar chave: ' + QuotedStr(Copy(sChave,
            4, 44)) + ' - ' + E.Message);
      end;

      Result.Autorizada := true;
    end;
    Application.ProcessMessages;
    TFuncoesNFCe.Aguardar('L', 'Situação do pedido de Cancelamento: ' + #10#13 +
      res.Mensagem, 50, 100);
    Sleep(2000);
  finally

    TFuncoesNFCe.Aguardar('', '');

  end;
end;

Function TdmNFCe.ConfiguraPathPDF: String;
var
  sPasta: string;
BEGIN
  // Cria Diretorio do Sistema

  sPasta := ExtractFilePath(Application.ExeName) + 'NFCe';
  if not DirectoryExists(sPasta) then
    if not CreateDir(sPasta) then
      raise Exception.Create('Erro ao Criar: ' + sPasta);
  Result := sPasta
end;

procedure TdmNFCe.ConfiguraDispositivo(bHabilitar: Boolean);
  function CorrentPrinter: String;
  // Declare a unit Printers na clausula uses
  var
  Device: array [0 .. 255] of Char;
  Driver: array [0 .. 255] of Char;
  Port: array [0 .. 255] of Char;
  hDMode: THandle;
  begin
    Printer.GetPrinter(Device, Driver, Port, hDMode);
    Result := Device;
  end;


var
  DispModeloNr: Integer;
  DispPorta, DispVelocidade, sImpressoraNFCe : string;

begin

  impVelocidade := LerSysPdvInt('NFCe_Impressora', 'Velocidade');
  cfg_ImpSpooler := ( LerSysPdvInt('DANFE', 'MODELO') > 0 );


  if impVelocidade = 0 then
  begin
    impVelocidade := 115200;
    GravaSysPdvInt('NFCe_Impressora', 'Velocidade', impVelocidade);
  end;

  // Equaliza a velocidade da porta do computador
  try
    if bExecutaComandoPorta = false then
    begin

      try
        DispPorta := LerSys('NFCe_Impressora', 'Porta');
        DispVelocidade := IntToStr(impVelocidade);
        NFCe_ExecutaCMDPorta(DispPorta, DispVelocidade);
      finally
        bExecutaComandoPorta := true;
      end;

    end;
  except

  end;

  if bHabilitar = false then
  begin
    try
     if DANFeESCPOS1.PosPrinter.Device.Ativo then
        DANFeESCPOS1.PosPrinter.Device.Desativar;
      DANFeESCPOS1.PosPrinter.Device.Baud := impVelocidade;

    except

    end;
    Exit;

  end;

  if DANFeESCPOS1.PosPrinter.Device.Ativo then
  begin
    DANFeESCPOS1.PosPrinter.Device.Desativar;
  end;


  try

    if length(LerSys('NFCe_Impressora', 'Modelo')) < 5 then
    begin
      GravaSYSInt('NFCe_Impressora', 'ModeloNr', 0);
      GravaSYS('NFCe_Impressora', 'Modelo', 'Daruma');
      DispModeloNr := LerSYSInt('NFCe_Impressora', 'ModeloNr');
    end
    else
      DispModeloNr := LerSYSInt('NFCe_Impressora', 'ModeloNr');

    case DispModeloNr of
      - 1:
        DANFeESCPOS1.PosPrinter.Modelo := ppEscDaruma;
      0:
        DANFeESCPOS1.PosPrinter.Modelo := ppEscDaruma;
      1:
        DANFeESCPOS1.PosPrinter.Modelo := ppEscBematech;
      2:
        DANFeESCPOS1.PosPrinter.Modelo := ppEscDiebold;
      3:
        DANFeESCPOS1.PosPrinter.Modelo := ppEscPosEpson;
      4:
        DANFeESCPOS1.PosPrinter.Modelo := ppEscVox;
    end;
  except
    DANFeESCPOS1.PosPrinter.Modelo := ppEscDaruma;
  end;


  (*Caso seja IMpressão no Spooler*)
  cfg_ImpSpooler := ( LerSysPdvInt('DANFE', 'MODELO') > 0 );
  if cfg_ImpSpooler then
  begin
    sImpressoraNFCe := LerSysPdv('NFCe', 'ImpressoraSpooler');
    if sImpressoraNFCe < '  ' then
    sImpressoraNFCe := CorrentPrinter;
    ACBrPosPrinter1.Porta := sImpressoraNFCe
  end
  else
  DANFeESCPOS1.PosPrinter.Device.Porta := LerSys('NFCe_Impressora', 'Porta');
  DANFeESCPOS1.PosPrinter.Device.Baud := impVelocidade;
  DANFeESCPOS1.PosPrinter.Device.TimeOut := 40;

  DANFeESCPOS1.PosPrinter.Device.Ativar;
  DANFeESCPOS1.PathPDF := ConfiguraPathPDF;

  if not DANFeESCPOS1.PosPrinter.Device.Ativo then
  begin
    DANFeESCPOS1.PosPrinter.Device.Desativar;
    Application.ProcessMessages;
    DANFeESCPOS1.PosPrinter.Device.Ativar;
  end;

//    ACBrPosPrinter1.AbrirGaveta

  DANFeESCPOS1.PosPrinter.LinhasEntreCupons :=
    LerSysPdvInt('NFCe', 'LinhasEntreCupom');

end;


procedure TdmNFCe.Ac_AcionaGavetaPelaImpressora(DispositivoGaveta :  TAcbrposPrinter; sPorta : string='');
begin

  try
    DispositivoGaveta.Desativar ;
    DispositivoGaveta.Porta := sPorta;
    DispositivoGaveta.Ativar;
    DispositivoGaveta.Buffer.Text := '</abre_gaveta>';
    DispositivoGaveta.Imprimir;



  finally
    DispositivoGaveta.Desativar ;
  end;

  {
  try//metodo de teste Acionar gavetam, cotinua o de cima
    DispositivoGaveta.Desativar ;
    DispositivoGaveta.Porta := EditPortaGaveta.Text;
    DispositivoGaveta.AbrirGaveta ;


  finally
    lEstado.Caption:= 'Abertura Acionada.';
    ACBrGAV1.Desativar ;
  end;
  }



end;



procedure TdmNFCe.ImprimirVenda(bVisualizar: Boolean; nVias: integer=1);

var
  iModeloDanfe: Integer;
begin

  try
    if ACBrNFe1.NotasFiscais.Count > 0 then
    begin

      iModeloDanfe := LerSysPdvInt('DANFE', 'MODELO');

      if iModeloDanfe <= 0 then
      begin
        // Modelo de Impressao Bobina

        ACBrNFe1.DANFE := DANFeESCPOS1;
        ConfiguraDispositivo(true);
        if DANFeESCPOS1.PosPrinter.LinhasEntreCupons < 4 then
          GravaSysPdvInt('NFCe', 'LinhasEntreCupom', 4);

        //DANFeESCPOS1.imprime
        DANFeESCPOS1.vTroco := vImpTroco;
        DANFeESCPOS1.Usuario := DmDados.cfg_Usuario;
        ACBrNFe1.NotasFiscais.Items[0].Imprimir;
      end
      else if iModeloDanfe = 2 then
      begin
        // Modelo de Impressao  Termica
        AC_ImprimePedidoNFCeSpooler(bVisualizar, nvias);
      end
      else
      begin
        AC_ImprimePedidoA4(bVisualizar);
      end;

    end;
  finally
    ConfiguraDispositivo(false); // -> DANFeESCPOS1.Device.Desativar;
  end;
end;






procedure TdmNFCe.AC_GavetaAcionaNFCe;
var bEstavaAtivo : Boolean;
begin

  try
    bEstavaAtivo := ACBrPosPrinter1.Ativo;
    try

      if not ACBrPosPrinter1.Ativo then
        ConfiguraDispositivo(true);

        ACBrPosPrinter1.AbrirGaveta;
    finally
      if not bEstavaAtivo then
        ConfiguraDispositivo(false);
    end;
  except on E: Exception do
    begin
      DmDados.GravaLogAcao( -1 , 'ERRO',
        'PDV abertura da gaveta método NFC-e: ' + E.Message);

        TFuncoesNFCe.Aguardar('L','Problemas durante a abertura da gaveta metodo NFC-e: ' + #13#10 + E.Message );
        Sleep(1500);
        TFuncoesNFCe.Aguardar('');
    end;


  end;

end;


procedure TdmNFCe.AC_GhulhotinaAciona;
begin

  try
    ConfiguraDispositivo(true);
    DANFeESCPOS1.PosPrinter.CortarPapel(false);
  finally
    ConfiguraDispositivo(false);
  end;

end;


Function TdmNFCe.AC_ImprimirNFCePedido(iPedido: Integer; Conteudo: TStringList;
  bCortaPapel: Boolean): Boolean;
var
  iModeloDanfe: Integer;
begin


  try
    iModeloDanfe := LerSysPdvInt('DANFE', 'MODELO');
    if iModeloDanfe = 2 then
      AC_ImprimirConteudoRdPrint(iPedido, conteudo, true)
      else
      begin
        ConfiguraDispositivo(true);
        DANFeESCPOS1.ImprimirRelatorio(Conteudo);
      end;
  finally
    ConfiguraDispositivo(false);
  end;

end;

Function TdmNFCe.AC_ImprimePedidoA4(bVisualizar: Boolean = false): Boolean;
var
  sPathArquivoDanfe: string;
begin

  try
    sPathArquivoDanfe := ExtractFilePath(Application.ExeName) +
      'pdv\DANFeNFCeA4.fr3';

    if not FileExists(sPathArquivoDanfe) then
    begin
      ShowMessage('Atenção!' + #13#10 + 'Arquivo Danfe NFC-e não encontrando: '
        + QuotedStr(sPathArquivoDanfe) + '!');
      AC_BaixaArquivoWeb
        ('http://www.compuservedobrasil.com/versao/Danfe/DANFeNFCeA4.rar',
        sPathArquivoDanfe);
      Result := false;
    end;

    if not FileExists(sPathArquivoDanfe) then
    begin
      // ShowMessage('Atenção!' + #13#10 + 'O Sistema não conseguiu conexão através da internet para baixar do servidor central o Arquivo Danfe NFC-e não encontrando: ' +  QuotedStr(sPathArquivoDanfe) + '!');
      Result := false;
      Exit;
    end;

    DANFEFastReport.FastFile := sPathArquivoDanfe;
    ACBrNFe1.DANFE := DANFEFastReport;
    DANFEFastReport.TipoDANFE :=  tiNFCe;
    DANFEFastReport.MostraSetup := true;
    DANFEFastReport.MostraPreview := bVisualizar;
    ACBrNFe1.NotasFiscais.Items[0].Imprimir;
    Result := true;

  finally

  end;

end;

Function TdmNFCe.AC_ImprimePedidoNFCeSpooler(bVisualizar
  : Boolean = false;nVias : integer=1): Boolean;
var
  sPathArquivoDanfe: string;
begin

  try
    sPathArquivoDanfe := ExtractFilePath(Application.ExeName) +
      'pdv\DANFeNFCe.fr3';

    if not FileExists(sPathArquivoDanfe) then
    begin
      // ShowMessage('Atenção!' + #13#10 + 'Arquivo Danfe NFC-e não encontrando: ' +  QuotedStr(sPathArquivoDanfe) + '!');
      AC_BaixaArquivoWeb
        ('http://www.compuservedobrasil.com/versao/Danfe/DANFeNFCe.rar',
        sPathArquivoDanfe);
      Result := false;
    end;

    if not FileExists(sPathArquivoDanfe) then
    begin
      ShowMessage('Atenção!' + #13#10 +
        'O Sistema não conseguiu conexão através da internet para baixar do servidor central o Arquivo Danfe NFC-e não encontrando: '
        + QuotedStr(sPathArquivoDanfe) + '!');
      Result := false;
      Exit;
    end;

    DANFEFastReport.FastFile := sPathArquivoDanfe;
    ACBrNFe1.DANFE := DANFEFastReport;
    // DANFEFastReport.ACBrNFe := ACBrNFe1;
    DANFEFastReport.Impressora := LerSysPdv('NFCe', 'ImpressoraSpooler');
    DANFEFastReport.MostraSetup := bVisualizar;
    DANFEFastReport.MostraPreview := bVisualizar;
    DANFEFastReport.TipoDANFE := tiNFCe;
    DANFEFastReport.NumCopias := nVias;
    ACBrNFe1.NotasFiscais.Items[0].Imprimir;
    Result := true;

  finally

  end;

end;

Function TdmNFCe.AC_BaixaArquivoWeb(EnderecoWeb, DestinoLocal: string): Boolean;
var
  url: string;
  ArquivoLocal: string;
  request: TGHttpRequest;
begin

  try
    if EnderecoWeb <= ' ' then
      url := 'http://www.compuservedobrasil.com/versao/Danfe/DANFeNFCeA4.rar'
      // Format('http://www.compuservedobrasil.com/versao/Danfe/DANFeNFCeA4.fr3',[]);
    else
      url := EnderecoWeb;

    if DestinoLocal <= ' ' then
      ArquivoLocal := ExtractFilePath(Application.ExeName) +
        'pdv\DANFeNFCeA4.fr3'
    else
      ArquivoLocal := DestinoLocal;

    request := TGHttpRequest.Create();
    request.get(url).SaveToFile(ArquivoLocal);
    Result := true;
  except
    Result := false;
  end;
end;



Function TdmNFCe.AC_ImprimeConfiguraModoImpressao(iModo: Integer): Boolean;
begin

  try

  finally

  end;

end;

function TdmNFCe.AC_ImprimePedido(iPedido: Integer; Conteudo: TStringList;
  bCortaPapel: Boolean): Boolean;
begin
  TRY

    try

      ConfiguraDispositivo(true);

      if LerSysPdvInt('DANFE', 'MODELO') > 0 then
      begin
          DANFeESCPOS1.PosPrinter.Device.Desativar;
          Application.ProcessMessages;
          DANFeESCPOS1.PosPrinter.Porta := dmDados.Cfg_ImpBobinaPadraoPorta;
          DANFeESCPOS1.PosPrinter.Device.Ativar;
      end;


      DANFeESCPOS1.ImprimirRelatorio(Conteudo);

      try
        // ACBrPosPrinter1.CortarPapel(False);;
      Except

      end;

    finally

      ConfiguraDispositivo(false);

    end;

  except
    on E: Exception do
    begin

      TFuncoesNFCe.Aguardar('L',
          'IMPRESSAO CUPOM'  +sLineBreak + 'Falha na impressão do Dispositivo: ' +
        E.Message);

      DmDados.GravaLogAcao( iPedido, 'IMPRESSAO CUPOM', 'Falha na impressão do Dispositivo: ' +
        E.Message);

    end;

  end;

end;


function TdmNFCe.AC_ImprimeConfiguraRdPrint: Boolean;
var iModeloIMPRESSORA : integer;
begin

  try

   (*Define o Modelo da Impressora*)
    IF LERSYS('IMPRESSORA','MODELO') <= ' ' THEN
       GRAVASYS('IMPRESSORA','MODELO','1');
       iModeloIMPRESSORA := strtoint('0'+LERSYS('IMPRESSORA','MODELO'));

    If (iModeloIMPRESSORA = 0) or (iModeloIMPRESSORA = 5) or
    (iModeloIMPRESSORA = 6) or (iModeloIMPRESSORA = 7) then

    RDprint.Impressora := Bobina;
    RDprint.PortaComunicacao := LerSys('VENDA', 'PortaPrint');
    //RDprint.TitulodoRelatorio := 'PEDIDO' + DataServer.TabVenaPedido.AsString;
    RDprint.TamanhoQteLinhas := 20;
    RDprint.OpcoesPreview.Preview := false;
    result := true;

  finally

  end;

end;

Function TdmNFCe.AC_ImprimirConteudoRdPrint(iPedido: Integer; Conteudo: TStringList;
  bCortaPapel: Boolean=true): Boolean;
begin

  try
     AC_ImprimeConfiguraRdPrint;

     if iPedido > 0 then
       rdPrint.TitulodoRelatorio := 'Pedido ' + StrZero(iPedido,9)
       else
       rdPrint.TitulodoRelatorio := 'Impressão Gerencial (' + DmDados.cfg_Usuario + ')  ' + TimeToStr(time);
      RDprint.TamanhoQteLinhas := conteudo.Count + 5;


      if FileExists('Temp.txt') then
        DeleteFile('Temp.txt');

      Conteudo.SaveToFile('Temp.txt');
     if FileExists('Temp.txt') then
     begin
        RDprint.Abrir;
        RDprint.Imprimindo( 'temp.txt');
        RDprint.Fechar;
     end;

    result := true;
  finally
    ConfiguraDispositivo(false);
  end;

end;

function TdmNFCe.NFCe_LerIdToken(sCNPJ, sToken, idToken: string): string;
var
  sIdToken, Token: string;
begin

  qry.close;
  qry.sql.Clear;
  qry.sql.Add
    ('SELECT Codigo, CNPJ, IDTOKEN_NFCe, TOKEN_NFCe  FROM NFe_Emitente e with(nolock) WHERE e.CNPJ =  '
    + QuotedStr(LimpaNumeros(sCNPJ)));
  qry.Open;

  sIdToken := qry.fieldbyname('idTOKEN_NFCe').AsString;
  sToken := qry.fieldbyname('TOKEN_NFCe').AsString;

  if length(sIdToken) <> 6 then
  begin

    sIdToken := (Fun_CompletaStrLeft(sIdToken, '0', 6));
    qry.close;
    qry.sql.Clear;
    qry.sql.Add('Update Nfe_emitente set IDTOKEN_NFCe = ' + QuotedStr(sIdToken)
      + ' WHERE CNPJ =  ' + QuotedStr(LimpaNumeros(sCNPJ)));
    qry.Execute;
    qry.sql.Clear;

  end;

  ACBrNFe1.Configuracoes.Geral.Idcsc := sIdToken;
  ACBrNFe1.Configuracoes.Geral.CSC := sToken;

  Result := sIdToken + ';' + sToken;

  qry.close;
  qry.sql.Clear;

end;

Function TdmNFCe.Fun_CompletaStrLeft(Conteudo, Caractere: string;
  Tamanho: Integer): string;
begin
  Result := Repl(Caractere, (Tamanho - length(Conteudo))) +
    Copy(Conteudo, 1, Tamanho);
end;

procedure TdmNFCe.MensagemAviso(Texto: string);
var
  Largura: Integer;
begin
  with TFormMensagem.Create(Application) do
  begin

    Frase.Lines.Add(Texto);
    Largura := 110 + Frase.Width;
    if Largura < 300 then
      Largura := 600;
    Width := Largura;
    BtnOk.Left := (Width - 80) div 2;
    MessageBeep(0);
    ShowModal;
    Free;
  end;
end;

Function TdmNFCe.EntregaImp_Via(iPedido: Integer; iVias: Integer = 2): Boolean;
var
  i: Integer;
  iQtdVias: Integer;

  // slImpressao : TStringList;
begin

  try
    iQtdVias := iVias;
    if iQtdVias = 0 then
      iQtdVias := LerSysPdvInt('ENTREGA', 'QuantidadeVias');
    // slImpressao := TStringlist.Create;
    if Entrega_SelecionaVenda(iPedido) then
    begin
      ConfiguraDispositivo(true);
      for i := 1 to iQtdVias do
      begin
        EntregaImp_MontaImpressao(i);
      end;

      Result := true;
    end;

  finally
    ConfiguraDispositivo(false);
    // freeandnil(slImpressao);
  end;

end;

Function TdmNFCe.Entrega_SelecionaVenda(iPedido: Integer;
  iEntrega: Integer = 1): Boolean;
begin

  try

    qry.close;
    qry.sql.Clear;
    qry.sql.Add
      ('UPDATE TabEst3b SET Peso = isnull((quantidade * (SELECT Peso FROM TABEST1 T with(nolock)  WHERE T.controle = TabEst3B.LkProduto) ),0) WHERE PEDIDO = '
      + IntToStr(iPedido));
    qry.Execute;
    qry.sql.Clear;

    qryVena.close;
    qryVenb.close;
    qryVena.ParamByName('Pedido').Value := iPedido;
    qryVenb.ParamByName('Pedido').Value := iPedido;
    qryVenb.ParamByName('Entrega').Value := iEntrega;
    qryVena.Open;
    qryVenb.Open;

    if not qryVenb.IsEmpty then
    begin
      Result := true
    end
    else
    begin
      qryVena.close;
      qryVenb.close;
    end;

  finally

  end;

end;

Function TdmNFCe.EntregaImp_MontaImpressao(iViaNr: Integer): Boolean;
var
  slConteudo: TStringList;
  Titulo, sLinha, sVia: string;
  iTam, iLargura: Integer;
  vTotalQuantidade, vTotalPeso, vTotalValor: Double;
  vItens: Integer;
begin

  try
    slConteudo := TStringList.Create;
    iLargura := 48;
    vTotalQuantidade := 0;
    vTotalPeso := 0;
    vItens := 0;
    vTotalValor := 0;

    case iViaNr of
      0, 1:
        sVia := '1ª VIA [ENTREGA]';
      2:
        sVia := '2ª VIA [DEPOSITO / LOJA]';
      3:
        sVia := '3ª VIA [CONTABILIDADE]';
      4:
        sVia := '4ª VIA [CONTROLE FISCAL]';
    end;

    // Cabeçalho
    slConteudo.Add('.');
    Titulo := UpperCase(DmDados.Cfg_Empresa_NomeResumido);
    if length(Titulo) <= 24 then // Expandido
      Titulo := '<CE><e>' + Titulo + '</CE></e>'
    else
      Titulo := '<ce><n>' + Titulo + '</ce></n>';
    slConteudo.Add(Titulo);

    slConteudo.Add(Fun_CentralizaTexto(DmDados.Cfg_Empresa_Endereco, iLargura));
    slConteudo.Add(Fun_CentralizaTexto(DmDados.Cfg_Empresa_Endereco2,
      iLargura));
    Titulo := 'Cx: ' + Copy(LerSys('VENDA', 'DESCCAIXA'), 1, 8) + ' Op: ' +
      LerSys('LOGIN', 'OPERADOR') + ' ' + qryVenaData.AsString + ' ' +
      Copy(TimeToStr(Now), 1, 5);
    slConteudo.Add(Titulo);
    slConteudo.Add('');
    Titulo := 'PEDIDO: ' + STRZERO(DataServer.TabVenaPedido.Value, 8);
    Titulo := '<CE><e>' + Titulo + '</CE></e>';
    slConteudo.Add(Titulo);
    slConteudo.Add('');
    slConteudo.Add('<CE><e>AUTORIZACAO P/ ENTREGA</CE></e>');
    slConteudo.Add('');
    slConteudo.Add('<CE><e>' + sVia + '</CE></e>');

    slConteudo.Add('</linha_simples>'); // slConteudo.Add(Repl('-',iLargura));
    slConteudo.Add('Codigo Descricao Quant Un Valor Unit Valor Total');
    slConteudo.Add('</linha_simples>'); // slConteudo.Add(Repl('_',iLargura));

    qryVenb.First;
    while not qryVenb.eof do
    begin
      Titulo := Transform(qryVenbItem.Value, '000') + ' [__] ';
      Titulo := Titulo + Copy(qryVenbCodInterno.AsString, 1, 13) + ' ' +
        qryVenbProduto.AsString;
      slConteudo.Add(Titulo);

      Titulo := '<n>' + Transform(qryVenbQuantidade.Value, '#,###,##0.000') +
        ' ' + Copy(qryVenbUnidade.AsString, 1, 2) + '</n> ' + ' x R$';
      Titulo := Titulo + Transform(qryVenbVlUnitario.Value, '###,##0.00') +
        ' = R$' + Transform(qryVenbTotal.Value, '#,###,##0.00');
      slConteudo.Add(Titulo);

      // Calcula
      inc(vItens);
      vTotalQuantidade := vTotalQuantidade + qryVenbQuantidade.Value;
      vTotalPeso := vTotalPeso + qryVenbPeso.Value;
      vTotalValor := vTotalValor + qryVenbTotal.Value;

      qryVenb.Next;
    end;
    // Divisão Totais
    slConteudo.Add('</linha_simples>'); // slConteudo.Add(Repl('-',iLargura));
    slConteudo.Add('<ad><n>Total da Nota: R$' + Transform(qryVenaVLPAGO.Value,
      '##,###,##0.00') + '</n>');
    slConteudo.Add('<ad><n>Total Entrega: R$' + Transform(vTotalValor,
      '##,###,##0.00') + '</n>');
    slConteudo.Add('<n>Peso Total......:' + Transform(vTotalPeso,
      '##,###,##0.00') + '</n>');
    slConteudo.Add('Itens.....: ' + STRZERO(qryVenb.reCordCount, 3) + '   ' +
      'Quantidades..:' + Transform(vTotalQuantidade, '##,###,##0.00'));
    slConteudo.Add('</ad>'); // Alinha a Direita
    slConteudo.Add('<CE>---| * <n> D E S T I N A T A R I O </n> * |---</CE>');
    slConteudo.Add('NOME....: ' + '<n>' + qryVenaCliente.AsString + '</n>');
    // Negrita
    IF length(qryVenaCPF_CNPJ.AsString) > 5 THEN
      slConteudo.Add('CPF/CNPJ: ' + '<n>' +
        CompletaStr(qryVenaCPF_CNPJ.AsString, '_', 18) + '   ' + '</n>');
    // Negrita
    slConteudo.Add('ENDEREÇO: ' + '<n>' + qryVenaEndereco.AsString + '</n>');
    // Negrita
    slConteudo.Add('NUMERO..: ' + '<n>' + CompletaStr(qryVenaNumero.AsString,
      '_', 8) + '</n> BAIRRO: <n>' + qryVenaBairro.AsString + '</n>');
    // Negrita
    slConteudo.Add('COMPLEM.: ' + '<I>' + qryVenaComplEnd.AsString + '</i>');
    // Italico
    slConteudo.Add('CIDADE..: ' + '<n>' + qryVenaCidade.AsString + '-' +
      qryVenaUF.AsString + '</n>'); // Italico
    slConteudo.Add('TELEFONE: ' + '<n>' + qryVenaTelefone.AsString + '</n>');
    // Italico
    slConteudo.Add('');
    slConteudo.Add('<CE>________________________________________</CE>');
    slConteudo.Add('<CE>Entregador</CE>');

    slConteudo.Add
      ('Declaro ter recebido todos os itens supra em perfeito estado.');
    slConteudo.Add('');
    slConteudo.Add('<CE>________________________________________</CE>');
    slConteudo.Add('<CE>Destinatário/Cliente</CE>');
    slConteudo.Add('');
    slConteudo.Add
      ('<ad><n>Entregue em: ___ / ___ /20____ as ____:____ Horas</ad></n>');
    slConteudo.Add('<ad><i>(Somente Itens selecionados p/ entrega)</ad></i>');
    slConteudo.Add('');
    slConteudo.Add('<CE><code128>' + qryVenaPedido.AsString +
      '</code128></CE>');

    DANFeESCPOS1.ImprimirRelatorio(slConteudo);
    slConteudo.SaveToFile(DmDados.cfg_PathSistema + 'pdv\ImpressaoEntrega.txt');
    Result := true;

  finally
    FreeAndNil(slConteudo);
  end;

end;

procedure TdmNFCe.Entregar_MarcarPedido(bMarcarTodos: Boolean = false;
  iPedido: Integer = 0);
VAR
  bBuscaPedido: Boolean;
begin
  try

    qry.close;
    qry.sql.Clear;
    if bMarcarTodos then
      qry.sql.Add('update tabest3b set entrega = 1 where pedido = ' +
        IntToStr(iPedido))
    else
      qry.sql.Add('update tabest3b set entrega = 0 where pedido = ' +
        IntToStr(iPedido));
    qry.Execute;

  finally
    qry.close;
    qry.sql.Clear;

  end;

end;

procedure TdmNFCe.Entregar(bMarcarTodos: Boolean);
begin

end;


function TdmNFCe.ProcessarVendaTesteSemImpressao(Codigo: Integer; bVisualizar: Boolean = false): TRetornoNFCe;
var
  req: TRequisicao;
  res: TResposta;

  arquivo: TStringList;
  iNota, iSerie: Integer;
  sChave: string;
  sMensagemValidacao: widestring;
  iPosicaoCorte: Integer;

begin

  try

    TFuncoesNFCe.Aguardar('L',
      'Transmitindo Cupom Fiscal Eletrônico ao consumidor NFC-e...');
    req := TRequisicao.Create;
    req.Codigo := Codigo;
    req.Tipo := reqEnviarCupom;

    res := TResposta.Create(NFCe_Servico.EnviarRequisicao(req.ToString));

    FormatSettings.DecimalSeparator := ',';
    FormatSettings.ThousandSeparator := '.';

    if res.DeuErro then
    begin
      // ShowMessage(res.Mensagem);
      sMensagemValidacao := res.Mensagem;
      BuscaTroca(sMensagemValidacao, '| |', ' ');

      sMensagemValidacao := BuscaTroca(sMensagemValidacao, '|', #13#10);

      iPosicaoCorte := pos( PChar(' Contate o suporte tecnico'),  sMensagemValidacao ) +
        length(' Contate o suporte tecnico');
      Delete(sMensagemValidacao, 1, iPosicaoCorte);
      //MensagemAviso('Atenção: ' + #13#10#13#10 + sMensagemValidacao);

      // ShowMessage( sMensagemValidacao );

      Result.Autorizada := false;

    end
    else
    begin
      arquivo := TStringList.Create;
      arquivo.Text := res.ObjRetorno;

      arquivo.SaveToFile('cfe.xml');

      ACBrNFe1.NotasFiscais.Clear;
      ACBrNFe1.NotasFiscais.LoadFromString(arquivo.Text);
      iNota := ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.nNF;
      iSerie := ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.serie;
      sChave := Copy(ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID, 4, 44);
      NFCe_LerIdToken(ACBrNFe1.NotasFiscais.Items[0].NFe.Emit.CNPJCPF, '', '');

      Result.Chave := sChave;
      Result.serie := iSerie;
      Result.Nota := iNota;

      qryInfVenda.close;
      qryInfVenda.ParamByName('ped').Value := Codigo;
      qryInfVenda.Open;
      vImpTroco := qryInfVendaTroco.Value;
       {
      TFuncoesNFCe.Aguardar('L', 'Imprimindo NFC-e...');

      try
        ImprimirVenda(bVisualizar);
        Result.Imprimiu := true;
      except
        on E: Exception do
        begin

          DmDados.GravaLogAcao(Codigo, 'NFCe', 'Falha ao imprmir NFC-e: ' +
            E.Message);
          Result.Imprimiu := false;

        end;

      end;
      }

      try

        if (qryInfVendaNota.IsNull) OR (qryInfVendaNota.AsString = '0') then
        begin
          qry.close;
          qry.sql.Clear;
          qry.sql.Add('update tabest3a set num_mod_doc = 65, serie = ' +
            QuotedStr(IntToStr(iSerie)) + ', nota = ' +
            QuotedStr(IntToStr(iNota)) + ', Chave_acesso = ' +
            QuotedStr(Copy(sChave, 4, 44)) + ' where pedido = ' +
            IntToStr(Codigo));
          qry.ExecSQL;
          DmDados.Pedido_BaixaEstoqueFiscal(Codigo);
        end;

      except
        on E: Exception do
          DmDados.GravaLogAcao(Codigo, 'NFCe',
            'Inconsistencia ao gerar e gravar chave: ' + QuotedStr(Copy(sChave,
            4, 44)) + ' - ' + E.Message);
      end;

      Result.Autorizada := true;
    end;

  finally
    TFuncoesNFCe.Aguardar('', '');

  end;
end;



procedure TdmNFCe.tmrTransmitirTimer(Sender: TObject);
var
  resposta: WideString;
begin

  try

      resposta := NFCe_Servico.EnviarRequisicao(self.req.ToString);

    self.Res := TResposta.Create(resposta);

    self.tmrTransmitir.Enabled := false;

  except
    on E: Exception do
    begin
      if  self.res <> nil  then
      begin
        self.res.DeuErro := true;
        self.res.Status  := -1;
      end;

      self.tmrTransmitir.Enabled := false;
      if Pos('UNABLE TO LOAD', UpperCase(E.message)) <> 0 then
      begin
        Application.MessageBox
          ('Não foi possível comunicar com o NFCeServ. Primeiro verifique se o serviço está aberto e rodando. '
          + 'Em seguida tente reiniciar o programa NFCeServ. Caso o erro permaneça contate o suporte técnico.',
          '');
//        LogTracer('Não foi possível comunicar com o NFCeTop');
      end
      else
      begin
//        LogTracer('Erro ao enviar requisição: '+ E.Message);
        Application.MessageBox(PChar(E.message), '');
      end;
    end;

  end;

//  TFuncoesNFCe.Aguardar('', '');

end;
function TdmNFCe.GetNFCe_NrCupomJaFoiTransmitido(codVenda :Integer=0) : Boolean;
begin

  try
    qryVendaNrNFCe.close;
    qryVendaNrNFCe.ParamByName('Pedido').AsInteger := codvenda;
    qryVendaNrNFCe.Open;
//    qry.SQL.Add('SELECT X.CodVenda, X.Status, X.Num_Nota_Fiscal FROM NFE_XMLTemp x with(nolock) WHERE x.CodVenda = '+ IntToStr(codVenda) +' AND Status = ' + QuotedStr('T'));


    if NOT qry.IsEmpty then
      Result := True
    ELSE
      Result := False;
  finally

  end;
end;

function TdmNFCe.GetNFCe_TipoReqEnvio(codVenda :Integer=0) : TTipoPacoteRequisicao;
begin

  try

    if GetNFCe_CupomJaFoiTransmitido( codVenda ) then
      NFCe_TipoReq := reqEnviarReimpressao
    else
    if GetNFCe_CupomSomenteGerado( codVenda ) then
      NFCe_TipoReq := reqEnviarReimpressao
      else
      NFCe_TipoReq := reqEnviarCupom;

     Result := NFCe_TipoReq;
  finally
  end;
end;


function TdmNFCe.GetNFCe_CupomJaFoiTransmitido(codVenda :Integer=0) : Boolean;
begin

  try
    qry.close;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT X.CodVenda, X.Status, X.Num_Nota_Fiscal FROM NFE_XMLTemp x with(nolock) WHERE x.CodVenda = '+ IntToStr(codVenda) +' AND Status = ' + QuotedStr('T'));
    qry.OPEN;

    if NOT qry.IsEmpty then
      Result := True
    ELSE
      Result := False;
  finally
    qry.close;
    qry.SQL.Clear;
  end;
end;



function TdmNFCe.GetNFCe_CupomSomenteGerado(codVenda :Integer=0) : Boolean;
begin

  try
    qry.close;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT X.CodVenda, X.Status, X.Num_Nota_Fiscal FROM NFE_XMLTemp x with(nolock) WHERE x.CodVenda = '+ IntToStr(codVenda) +' AND Status <> ' + QuotedStr('T'));
    qry.OPEN;

    if NOT qry.IsEmpty then
      Result := True
    ELSE
      Result := False;
  finally
    qry.close;
    qry.SQL.Clear;
  end;
end;


function TdmNFCe.GetNFCe_TransmitidoSemRetorno(codVenda :Integer) : Boolean;
begin

  try
    qry.close;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT X.CodVenda, X.Status, X.Num_Nota_Fiscal FROM NFE_XMLTemp x with(nolock)');
    qry.SQL.Add(' WHERE x.CodVenda = '+ IntToStr(codVenda) +' AND Status = ' + QuotedStr('T'));
    qry.OPEN;

    if NOT qry.IsEmpty then
      Result := false
    ELSE
      Result := true;
  finally
    qry.close;
    qry.SQL.Clear;
  end;
end;



function TdmNFCe.Pedido_ImprimeCupomTroca(codVenda :Integer=0; bAutomatico :Boolean=true) : Boolean;
var bImprimeCupomtroca : Boolean;
 slCupom : TStringList;
begin

  try
    if not qryCfg_Venda.Active then
      qryCfg_Venda.Open
    else
      qryCfg_Venda.Refresh;


    if not qryVena.Active then
    begin
      qryVena.ParamByName('Pedido').AsInteger := codVenda;
      qryVena.Open;
    end
    else
    if qryVenaPedido.AsInteger <> codVenda then
    begin
      qryVena.close;
      qryVena.ParamByName('Pedido').AsInteger := codVenda;
      qryVena.Open;
    end;



    bImprimeCupomtroca := ((qryCfg_VendaCupomTrocaAutomatico.AsBoolean = true)
                           or (bAutomatico = false));

    slCupom := TStringList.Create;

    if bImprimeCupomtroca then
    begin

      slCupom.Add('</zera>');
      slCupom.Add('<n></fn></ce>');    //Centraliza
      slCupom.Add('<n>'+DMDADOS.Cfg_Empresa_Descricao);
      slCupom.Add('<n>CNPJ: ' + DMDADOS.Cfg_Empresa_CNPJ + ' FONE: ' + DMDADOS.Cfg_Empresa_Telefone );
      slCupom.Add(DMDADOS.qryEmpresaBairro.AsString );
      slCupom.Add(DMDADOS.qryEmpresaMunicipio.AsString +' - ' + UpperCase( DMDADOS.qryEmpresaUF.AsString) );
      slCupom.Add( DateTimeToStr(Now) );
      slCupom.Add('');
      slCupom.Add('<e>* CUPOM DE TROCA *</e></n>');
      slCupom.Add('');
      slCupom.Add('</ae>');
      slCupom.Add('VENDA......: <n>' + IntToStr(codVenda) + '</n>    DATA...: <N>' + FormatDateTime('DD/MM/YYYY',qryVenaData.AsDateTime)+'</n>');
      if not qryVenaNota.IsNull then
        slCupom.Add('CUPOM......: <n>' + qryVenaNota.AsString + '</n> SERIE..: '  + qryVenaSerie.AsString +'</n>');

      if not qryVenaVendedor.IsNull then
      slCupom.Add('VENDEDOR(A): <n>' + qryVenaVendedor.AsString +'</n>');
      slCupom.Add('</ae></n>' + Repl('-',42));//Alinha a esquerda
      slCupom.Append(qryCfg_VendaCupomTrocaTexto.AsAnsiString);
      slCupom.Add('</n>');    //Centraliza
      slCupom.Add('');
      slCupom.Add('');
      slCupom.Add('');
      ConfiguraDispositivo(True);
      ACBrPosPrinter1.Imprimir(slCupom.Text);
      ACBrPosPrinter1.CortarPapel();
      ConfiguraDispositivo(False);
    end;
      Result := bImprimeCupomtroca;
  finally
    FreeAndNil( slCupom);
  end;
end;

function TdmNFCe.GetTempoContingencia: Boolean;
var
  HoraInicial, HoraFinal, Minutos : Double;
begin
  Result := False;

  if Assigned(CupomOffline) then
  begin
     if Now < CupomOffline.TempoFinal then
       Result := True
      else
       Result := False;

    if not Result then
      CupomOffline.Ativo := False;

//    LogTracer('Tempo inicial: '+ DateTimeToStr(CupomOffline.TempoInicio));
//    LogTracer('Tempo final  : '+ DateTimeToStr(CupomOffline.TempoFinal));
//    LogTracer('Tempo restante: '+DateTimeToStr(CupomOffline.TempoInicio - CupomOffline.TempoFinal));
//    LogTracer('Ativo: '+BoolToStr(CupomOffline.Ativo));
  end;
end;

procedure TdmNFCe.SetTempoContingencia;
var
  TempoS : string;
  TempoI : integer;
begin
  TempoEmContigencia       := Now;
  CupomOffline             := TCupomOffline.Create;
  CupomOffline.TempoInicio := TempoEmContigencia;
  CupomOffline.Ativo       := True;

  TempoI := DmDados.LerIniInt('NFCe', 'TEMPO_CONTINGENCIA');
  try
     if TempoI <= 0 then
     begin
      TempoI := 10;
      DmDados.GravaIniInt('NFCe', 'TEMPO_CONTINGENCIA',TempoI);
     end;
  except
    TempoI := 10;
  end;

//  LogTracer('SetContingencia Ok');

  CupomOffline.TempoMinutosOffline := TempoI;
  CupomOffline.TempoFinal          := IncMinute(CupomOffline.TempoInicio, TempoI);
end;


{$REGION 'FUNCOES PARA GERACAO E ENVIO DOS ARQUIVOS NFCe AUTORIZADOS'}

Function TdmNFCe.EnviaNFCe_ApiZap( iPedidoVenda : Integer=0; sNrTelefoneZap : string='';
                       bSolicitarNrTelefone : Boolean = false ): Boolean;
var
  WsXmlNota: widestring;
  sArquivoXml, sArquivoPDF, sPathRel : string;
  sPathArquivoDanfe: string;
  codvenda : Integer;
  sNrTelefone,sChave : string;

begin
     codvenda := iPedidoVenda;

     if not GetNFCe_CupomJaFoiTransmitido(  iPedidoVenda ) then
     begin
       Result := False;
       Exit;

     end;

     try
      sPathRel := ExtractFilePath(Application.ExeName) + 'PDF';
      If Not DirectoryExists(sPathRel) then
         ForceDirectories(sPathRel);

      sArquivoPDF := sPathRel + '\NFCe_' + IntToStr(iPedidoVenda) + '.PDF' ;
      sArquivoXml := sPathRel + '\NFCe_' + IntToStr(iPedidoVenda) + '.XML' ;
      GravaSYS('PATH','PASTA PDF', sPathRel );
      GravaSYS('PATH','ARQUIVO NFCE PDF',sArquivoPDF);
      GravaSYS('PATH','ARQUIVO NFCE XML',sArquivoXML);

      {if FileExists(PChar( sArquivoXml)) then
        DeleteFile(PChar(sArquivoXml));
      if FileExists(PChar(sArquivoPDF)) then
        DeleteFile(PChar(sArquivoPDF));}



    except


    end;


  // CONSULTANDO PEDIDO:
    (*Ler Informações da Venda*)
    qryInfVenda.close;
    qryInfVenda.ParamByName('ped').Value := iPedidoVenda;
    qryInfVenda.Open;

    qryVena.close;
    qryVena.ParamByName('pedido').Value := iPedidoVenda;
    qryVena.Open;

    (*Ler Informações do XML da NFCe_xmlTemp*)
    qry.close;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT x.CodEmitente,  X.CodVenda, X.Status, X.Num_Nota_Fiscal, x.ChaveNFe, x.XMLTexto, x.Tipo_Amb, x.Forma_Emissao FROM NFE_XMLTemp x with(nolock) WHERE x.CodVenda = '+ IntToStr(codVenda) +' AND Status = ' + QuotedStr('T'));
    qry.OPEN;

    if not qry.IsEmpty then
    begin
      WsXmlNota := qry.FieldByName('xmlTexto').AsWideString;
      sChave := qry.FieldByName('chaveNFe').AsString;
      GravaSYS('PATH','CHAVE NFCE',sChave);

    end;
      ACBrNFe1.NotasFiscais.Clear;
      ACBrNFe1.NotasFiscais.LoadFromString( WsXmlNota );


  try
    sPathArquivoDanfe := ExtractFilePath(Application.ExeName) +
      'pdv\DANFeNFCe.fr3';

    if not FileExists(sPathArquivoDanfe) then
    begin
      ShowMessage('Atenção!' + #13#10 +
        'O Sistema não conseguiu conexão através da internet para baixar do servidor central o Arquivo Danfe NFC-e não encontrando: '
        + QuotedStr(sPathArquivoDanfe) + '!');
      Result := false;
      Exit;
    end;

    DANFEFastReport.FastFile := sPathArquivoDanfe;
    ACBrNFe1.DANFE := DANFEFastReport;
    DANFEFastReport.Impressora := LerSysPdv('NFCe', 'ImpressoraSpooler');
    DANFEFastReport.MostraSetup := false;
    DANFEFastReport.MostraPreview := false;
    DANFEFastReport.TipoDANFE := tiNFCe;
    DANFEFastReport.NumCopias := 1;
    DANFEFastReport.NomeDocumento := ExtractFileName( sArquivoPDF);
    DANFEFastReport.PathPDF := sPathRel;//**--

    ACBrNFe1.NotasFiscais.Items[0].ImprimirPDF;
    ACBrNFe1.NotasFiscais.Items[0].GravarXML(PChar(sArquivoXml) );
    GravaSYS('PATH','NOTA NFCE EM',PChar(sArquivoXml));

             if ( Length( sNrTelefoneZap ) > 8) and (  bSolicitarNrTelefone = false ) then
               sNrTelefone := sNrTelefoneZap
             else
             begin
               sNrTelefone := qryVenaTelefone.AsString;
               sNrTelefone := InputBox('Confirmação do Número',
              'Confirme ou altere o número de telefone para o envio:', sNrTelefone );
             end;

          // Verifica se o usuário não clicou em cancelar (sNumeroTelefone não estará vazio)
          if sNrTelefone <> '' then
          begin
             dmZap.ZapEnviaMensagem( sNrTelefone, '', sArquivoPDF );
             dmZap.ZapEnviaMensagem( sNrTelefone, '', sArquivoXml);
             //dmZap.ZapEnviaMensagem( sNrTelefone, sMensagem);
          end;



    Result := true;

  finally

  end;

end;




{$ENDREGION}





end.

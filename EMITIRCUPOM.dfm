object frmemitir: Tfrmemitir
  Left = 0
  Top = 0
  Caption = 'frmemitir'
  ClientHeight = 643
  ClientWidth = 902
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI Semibold'
  Font.Style = [fsBold]
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 21
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 902
    Height = 643
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitLeft = 272
    ExplicitTop = 224
    ExplicitWidth = 185
    ExplicitHeight = 41
    object Label1: TLabel
      Left = 0
      Top = 97
      Width = 902
      Height = 25
      Align = alTop
      Alignment = taCenter
      Caption = 'Vendas '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitTop = 121
      ExplicitWidth = 69
    end
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 902
      Height = 97
      Align = alTop
      TabOrder = 0
      object Label2: TLabel
        Left = 12
        Top = 21
        Width = 160
        Height = 21
        Caption = 'Defina o Valor a Emitir'
      end
      object Label5: TLabel
        Left = 233
        Top = 21
        Width = 141
        Height = 21
        Caption = 'P'#233'riodo das vendas'
      end
      object Label6: TLabel
        Left = 202
        Top = 51
        Width = 24
        Height = 21
        Caption = 'De:'
        OnClick = Label6Click
      end
      object Label7: TLabel
        Left = 359
        Top = 51
        Width = 15
        Height = 21
        Caption = 'A:'
        OnClick = Label6Click
      end
      object Editvalorparaemitir: TEdit
        Left = 12
        Top = 48
        Width = 121
        Height = 29
        TabOrder = 0
        Text = 'Editvalorparaemitir'
      end
      object btnemitir: TBitBtn
        AlignWithMargins = True
        Left = 769
        Top = 21
        Width = 129
        Height = 55
        Margins.Top = 20
        Margins.Bottom = 20
        Align = alRight
        Caption = 'Emitir Nfce'
        TabOrder = 1
        ExplicitLeft = 648
        ExplicitTop = 56
        ExplicitHeight = 59
      end
      object Btnconsultar: TBitBtn
        AlignWithMargins = True
        Left = 634
        Top = 21
        Width = 129
        Height = 55
        Margins.Top = 20
        Margins.Bottom = 20
        Align = alRight
        Caption = 'Consultar'
        TabOrder = 2
        ExplicitTop = 19
      end
      object datainicio: TDateTimePicker
        Left = 232
        Top = 48
        Width = 121
        Height = 25
        Date = 45811.000000000000000000
        Time = 0.377456388887367200
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI Semibold'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
      end
      object datafim: TDateTimePicker
        Left = 380
        Top = 48
        Width = 125
        Height = 25
        Date = 45811.000000000000000000
        Time = 0.377456388887367200
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI Semibold'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
      end
    end
    object Panel3: TPanel
      Left = 0
      Top = 528
      Width = 902
      Height = 115
      Align = alBottom
      TabOrder = 1
      object Label3: TLabel
        Left = 568
        Top = 16
        Width = 231
        Height = 21
        Caption = 'Valor Total Emitido (Nfce + Nfe)'
      end
      object labelvaloremitido: TLabel
        Left = 1
        Top = 77
        Width = 900
        Height = 37
        Align = alBottom
        Caption = 'R$ 100,00'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'Segoe UI Semibold'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitLeft = 568
        ExplicitTop = 43
        ExplicitWidth = 117
      end
      object memolog: TMemo
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 437
        Height = 70
        Align = alLeft
        Lines.Strings = (
          'memolog')
        ScrollBars = ssVertical
        TabOrder = 0
        ExplicitHeight = 107
      end
    end
    object GRIDVENDAS: TDBGrid
      Left = 0
      Top = 122
      Width = 902
      Height = 406
      Align = alClient
      DataSource = DataModule1.DSQRYBUSCARVENDAS
      TabOrder = 2
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -16
      TitleFont.Name = 'Segoe UI Semibold'
      TitleFont.Style = [fsBold]
    end
  end
  object ACBrNFe1: TACBrNFe
    Configuracoes.Geral.SSLLib = libNone
    Configuracoes.Geral.SSLCryptLib = cryNone
    Configuracoes.Geral.SSLHttpLib = httpNone
    Configuracoes.Geral.SSLXmlSignLib = xsNone
    Configuracoes.Geral.FormatoAlerta = 'TAG:%TAGNIVEL% ID:%ID%/%TAG%(%DESCRICAO%) - %MSG%.'
    Configuracoes.Arquivos.OrdenacaoPath = <>
    Configuracoes.WebServices.UF = 'SP'
    Configuracoes.WebServices.AguardarConsultaRet = 0
    Configuracoes.WebServices.QuebradeLinha = '|'
    Configuracoes.RespTec.IdCSRT = 0
    Left = 528
    Top = 16
  end
end

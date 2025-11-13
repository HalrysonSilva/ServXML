# ⚙️ ServXML: Gerenciador de Documentos Fiscais Eletrônicos (NF-e / NFC-e)

O **ServXML** é uma aplicação de serviço e utilitário desenvolvida em Delphi, dedicada à automatização e gerenciamento de processos de Documentos Fiscais Eletrônicos (DF-e), como NF-e e NFC-e. O projeto se integra com a suíte de componentes **ACBr** para comunicação com a SEFAZ, geração de XMLs e envio de documentos.

---

## 💻 Tecnologias e Dependências

Este projeto requer um ambiente de desenvolvimento robusto, incluindo:

* **Linguagem:** Object Pascal
* **IDE:** Embarcadero **Delphi 10.3** (ou superior)
* **Banco de Dados:** **SQL Server**
* **Biblioteca Fiscal:** **ACBr Componentes** (Essencial para a comunicação com a SEFAZ, geração e assinatura de XMLs).
* **Acesso a Dados:** Utiliza DataModule (`CONEXAOBD`) para a persistência dos dados.
* **Comunicação Segura:** Depende de bibliotecas como **OpenSSL** (`libeay32.dll` e `ssleay32.dll`) para conexões seguras (HTTPS/SSL), essenciais para WebServices e envio de e-mail.
* **Tratamento de XML:** Utiliza bibliotecas para manipulação de XML (e.g., `OmniXML`).

---

## Pré-requisitos

Para compilar e executar o ServXML, certifique-se de que o ambiente possui:

1.  **Delphi 10.3** com as bibliotecas **ACBr** e **FastReport** (componentes sugeridos pelos arquivos dcu) instaladas.
2.  Instância ativa do **SQL Server** e acesso configurado.
3.  **DLLs OpenSSL** (`libeay32.dll` e `ssleay32.dll`) no caminho do executável (`Win32/Debug/` ou `System32/SysWOW64`).
4.  Um **Certificado Digital** (A1 ou A3) configurado para a comunicação com a SEFAZ.

---

## ⚙️ Configuração do Projeto

### 1. Configuração do Banco de Dados

A conexão com o **SQL Server** é gerenciada pela DataModule **`CONEXAOBD.pas`**.

* **Ação Necessária:** Edite o `CONEXAOBD.dfm` e/ou `CONEXAOBD.pas` e ajuste a `ConnectionString` do componente de conexão de dados para corresponder ao seu ambiente SQL Server.
* **Estrutura de Dados:** O projeto depende de tabelas que armazenam dados fiscais (NF-e, NFC-e) e parâmetros de configuração do emitente.

### 2. Configuração ACBr (Geração de XML)

O formulário principal de lógica fiscal parece ser **`GERAXML.pas`** e as configurações específicas estão em **`CONFIGACBR/Frm_ACBrNFe.pas`**.

* **Certificado Digital:** Utilize `CONFIGACBR/Frm_SelecionarCertificado.pas` para gerenciar a seleção do certificado digital e garantir que ele esteja corretamente referenciado.
* **Arquivos INI:** Verifique o arquivo `SERVXML.ini` (ou similar) no diretório `Win32/Debug/` para configurar caminhos de XML, schemas, e *WebServices* da SEFAZ.

### 3. Configuração de E-mail (SMTP)

O formulário **`FRM_EMAIL_PROGRESSO.pas`** lida com o envio de e-mails (provavelmente para enviar o XML/DANFE ao cliente).

* **Ação Necessária:** Configure os parâmetros de SMTP (servidor, porta, usuário, senha e SSL/TLS) nas unidades de envio de e-mail (possivelmente utilizando Synapse ou Indy, como sugerido pelos dcu's).

---

## 💡 Funcionalidades Chave

* **Geração de XML:** Lógica em **`GERAXML.pas`** para montar o arquivo XML dos documentos fiscais a partir dos dados do SQL Server.
* **Comunicação com SEFAZ:** Integração com os componentes ACBr (via unidades em `CONFIGACBR/`) para enviar lotes, consultar status e fazer o download de documentos.
* **Configuração de Certificado:** Telas dedicadas para a seleção e gerenciamento do Certificado Digital.
* **Controle de Fluxo:** Utiliza um menu principal (`MENU.pas`) e uma tela de espera (`TELAESPERA.pas`) para indicar o processamento de tarefas em segundo plano.
* **Emissão de Cupom:** O formulário **`EMITIRCUPOM.pas`** sugere a funcionalidade de emissão de NFC-e ou outro tipo de cupom.

---

## 📁 Estrutura do Projeto

| Arquivo/Diretório | Descrição |
| :--- | :--- |
| `SERVXML.dpr` | Arquivo principal do projeto Delphi. |
| `MENU.pas` / `MENU.dfm` | Formulário principal ou menu de acesso às funcionalidades. |
| `CONEXAOBD.pas` / `CONEXAOBD.dfm` | DataModule para gerenciar a conexão com o **SQL Server**. |
| `GERAXML.pas` / `GERAXML.dfm` | Lógica principal para a geração e processamento de XMLs fiscais. |
| `EMITIRCUPOM.pas` / `EMITIRCUPOM.dfm` | Formulário ou unidade de lógica para emissão de cupom (NFC-e). |
| `FRM_EMAIL_PROGRESSO.pas` | Tela de progresso ou lógica para o envio de e-mails. |
| `TELAESPERA.pas` / `TELAESPERA.dfm` | Formulário de carregamento (*splash*) para longas operações. |
| `CONFIGACBR/` | Contém formulários específicos para configurar a integração ACBr (e.g., Certificado, Serial, Status). |
| `uDMNFCe.pas` | DataModule ou unidade de dados específica para NFC-e. |

---

## 🚀 Próximos Passos

1.  Verifique a compatibilidade e instale todos os componentes ACBr necessários.
2.  Configure a conexão com seu **SQL Server** na `CONEXAOBD`.
3.  Configure o caminho das DLLs OpenSSL no ambiente de execução.

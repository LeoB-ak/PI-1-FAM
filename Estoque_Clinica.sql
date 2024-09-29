REM   Script: PI - TABELAS + CONSTRAINTS
REM   algumas alterações em relação ao conceitual
- Data de expiração foi para a tabela dos itens de compra (uma vez que estamos registrando a compra de uma instancia de Botox a um registro global de Botox, cada item possuiria sua própria data de validade)
- Data de abertura, e data de expiração especial foi para a tabela do estoque (uma vez que ambos são realizados a um item já estocado, não ao registro global do item em questão) 
- Não fui capaz de realizar as constraints do estoque, minha ideia era puxar a chave primaria das tabelas associativas (itens_procedimentos + itens_compra) como chaves estrangeiras para ser o equivalente da entrada e saída do estoque, mas não fui capaz de fazer, revisão necessária


CREATE TABLE Fornecedor ( 
id_forn number (3), 
forn_nome varchar (25), 
forn_fone number (11), 
forn_loc varchar (13),
forn_cnpj number (14));

CREATE TABLE Cliente ( 
id_cli number (5), 
cli_nome varchar (40), 
cli_email varchar (50), 
cli_fone number (11), 
cli_niver date, 
cli_cpf number (11) 
);

CREATE TABLE Cargo( 
id_cargo number (2), 
cargo_nome varchar (25));

CREATE TABLE Funcionario(  
id_func number (2),  
func_login varchar (16), 
func_senha varchar (16), 
func_crbm number (12));

CREATE TABLE Compra( 
id_com number (6), 
com_notafis varchar(44), 
com_valor number(7,2) , 
com_data date );

CREATE TABLE Itens_Compra( 
itemcom_qtde number (4), 
itemcom_lote number (12),
itemcom_expi date);

CREATE TABLE Procedimento( 
id_proc number (2), 
proc_nome varchar (25));

Create TABLE Itens_Procedimento( 
itemproc_qtde number (2));

Create table Ficha_Atendimento( 
id_atd number (3), 
atd_data date, 
atd_hora date);

Create table Categoria( 
id_cat number (2), 
cat_nome varchar (25));

Create table Subcategoria( 
id_scat number (2), 
scat_nome varchar (25));

Create table Item( 
id_item number (4), 
item_nome varchar (25), 
item_desc varchar (40), 
item_img blob,
item_id_img bfile, 
item_est_min number (2), 
item_est_max number (4),
item_temp_rec number (3));

Create table Estoque(
id_est number (6),   
est_qtd number (4), 
est_data_aber date, 
est_dias_val_aber number (3));

ALTER TABLE FUNCIONARIO 
add CONSTRAINT PK_ID_FUNCIONARIO PRIMARY KEY (ID_FUNC);

ALTER TABLE CARGO 
add CONSTRAINT PK_ID_CARGO PRIMARY KEY (ID_CARGO);

ALTER TABLE CATEGORIA 
add CONSTRAINT PK_ID_CATEGORIA PRIMARY KEY (ID_CAT);

ALTER TABLE CLIENTE 
add CONSTRAINT PK_ID_CLIENTE PRIMARY KEY (ID_CLI);

ALTER TABLE COMPRA 
add CONSTRAINT PK_ID_COMPRA PRIMARY KEY (ID_COM);

ALTER TABLE FORNECEDOR 
add CONSTRAINT PK_ID_FORNECEDOR PRIMARY KEY (ID_FORN);

ALTER TABLE ITEM 
add CONSTRAINT PK_ID_ITEM PRIMARY KEY (ID_ITEM);

ALTER TABLE PROCEDIMENTO 
add CONSTRAINT PK_ID_PROCEDIMENTO PRIMARY KEY (ID_PROC);

ALTER TABLE SUBCATEGORIA 
add CONSTRAINT PK_ID_SUBCATEGORIA PRIMARY KEY (ID_SCAT);

ALTER TABLE ITENS_COMPRA 
ADD ID_ITEM NUMBER (4);

ALTER TABLE ITENS_COMPRA 
ADD ID_COM NUMBER (6);

ALTER TABLE ITENS_COMPRA 
ADD CONSTRAINT PK_IDS_ITEM_COMPRA PRIMARY KEY(ID_COM, ID_ITEM);

ALTER TABLE ITENS_COMPRA 
ADD CONSTRAINT FK_ID_COMPRA FOREIGN KEY(ID_COM) REFERENCES COMPRA(ID_COM);

ALTER TABLE ITENS_COMPRA 
ADD CONSTRAINT FK_ID_ITEM FOREIGN KEY(ID_ITEM) REFERENCES ITEM(ID_ITEM);

ALTER TABLE ITENS_PROCEDIMENTO 
ADD ID_ITEM NUMBER (4);

ALTER TABLE ITENS_PROCEDIMENTO 
ADD ID_PROC NUMBER (2);

ALTER TABLE ITENS_PROCEDIMENTO 
ADD CONSTRAINT PK_IDS_ITEM_PROCEDIMENTO PRIMARY KEY(ID_PROC, ID_ITEM);

ALTER TABLE ITENS_PROCEDIMENTO 
ADD CONSTRAINT FK_ID_PROCEDIMENTO FOREIGN KEY(ID_PROC) REFERENCES PROCEDIMENTO(ID_PROC);

ALTER TABLE ITENS_PROCEDIMENTO 
ADD CONSTRAINT FK_ID_ITEM_S FOREIGN KEY(ID_ITEM) REFERENCES ITEM(ID_ITEM);

ALTER TABLE COMPRA 
ADD ID_FORN NUMBER (3);

ALTER TABLE COMPRA 
ADD CONSTRAINT FK_ID_FORNECEDOR FOREIGN KEY(ID_FORN) REFERENCES FORNECEDOR(ID_FORN);

ALTER TABLE FUNCIONARIO 
ADD ID_CARGO NUMBER (2);

ALTER TABLE FUNCIONARIO 
ADD CONSTRAINT FK_ID_CARGO FOREIGN KEY(ID_CARGO) REFERENCES CARGO(ID_CARGO);

ALTER TABLE ITEM 
ADD ID_CAT number (1);

ALTER TABLE ITEM 
ADD ID_SCAT number (2);

ALTER TABLE ITEM 
ADD CONSTRAINT FK_ID_CATEGORIA FOREIGN KEY(ID_CAT) REFERENCES CATEGORIA(ID_CAT);

ALTER TABLE ITEM 
ADD CONSTRAINT FK_ID_SUBCATEGORIA FOREIGN KEY (ID_SCAT) REFERENCES SUBCATEGORIA(ID_SCAT);

ALTER TABLE SUBCATEGORIA 
ADD ID_CAT NUMBER (1);

ALTER TABLE SUBCATEGORIA 
ADD CONSTRAINT FK_ID_CAT_SUBCAT FOREIGN KEY (ID_CAT) REFERENCES CATEGORIA (ID_CAT);

ALTER TABLE FICHA_ATENDIMENTO 
ADD ID_CLI NUMBER (5);

ALTER TABLE FICHA_ATENDIMENTO 
ADD ID_FUNC NUMBER (2);

ALTER TABLE FICHA_ATENDIMENTO 
ADD ID_PROC NUMBER (2);

ALTER TABLE FICHA_ATENDIMENTO 
ADD CONSTRAINT PK_IDS_ATENDIMENTO PRIMARY KEY(ID_CLI, ID_ATD);

ALTER TABLE FICHA_ATENDIMENTO 
ADD CONSTRAINT FK_ID_CLIENTE FOREIGN KEY (ID_CLI) REFERENCES CLIENTE (ID_CLI);

ALTER TABLE FICHA_ATENDIMENTO 
ADD CONSTRAINT FK_ID_FUNCIONARIO FOREIGN KEY (ID_FUNC) REFERENCES FUNCIONARIO (ID_FUNC);

ALTER TABLE FICHA_ATENDIMENTO
ADD CONSTRAINT FK_ID_PROCEDIMENTO_ATD FOREIGN KEY (ID_PROC) REFERENCES PROCEDIMENTO (ID_PROC);


CREATE TABLE Armazenamento(
id_arm number (2),
arm_local varchar (25),
temp_arm number (3));


ALTER TABLE Armazenamento   
add CONSTRAINT PK_ID_Armazenamento PRIMARY KEY (ID_ARM)


ALTER TABLE Estoque  
ADD ID_ITEM NUMBER (4)


ALTER TABLE ESTOQUE 
ADD ID_PROC NUMBER (2)


ALTER TABLE ESTOQUE 
ADD ID_COM NUMBER (6)


ALTER TABLE ESTOQUE 
ADD ID_ARM NUMBER (2)


ALTER TABLE ESTOQUE
add CONSTRAINT PK_ID_ESTOQUE PRIMARY KEY (ID_EST)


ALTER TABLE Estoque  
ADD CONSTRAINT FK_ID_SAIDA FOREIGN KEY (id_item, id_proc)  
        REFERENCES ITENS_PROCEDIMENTO (id_item, id_proc)


ALTER TABLE Estoque  
ADD CONSTRAINT FK_ID_ENTRADA FOREIGN KEY (id_item, id_com)  
        REFERENCES ITENS_COMPRA (id_item, id_com)


ALTER TABLE Estoque 
ADD CONSTRAINT FK_ARMAZENAMENTO FOREIGN KEY (ID_ARM) 
REFERENCES ARMAZENAMENTO (ID_ARM)



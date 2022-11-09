--Criacao do Log
/*tabela log serve para acompanhar as alteracoes ou mudancas feitas
pela equipe durante a realizacao do trabalho*/

create table tb_log
(
 id_log  int         not null,
 usuario VARCHAR(50) NOT NULL,
 DATA    DATE        NOT NULL,
 operacao VARCHAR(50) NOT NULL
 );

ALTER TABLE tb_log ADD CONSTRAINT pk_log PRIMARY KEY (id_log);

create SEQUENCE sq_Log;

--trigger para povoar a tabela log a cada alteracao no schema

create or replace TRIGGER TR_REGISTRO_DDL
AFTER DDL
ON SCHEMA
DECLARE vOPERACAO VARCHAR2(50);
BEGIN
    voperacao := 'DDL - '|| ORA_SYSEVENT ||
                      ' '|| ORA_DICT_OBJ_TYPE || 
                      ' '|| ORA_DICT_OBJ_NAME;
    INSERT INTO TB_LOG VALUES(SQ_LOG.NEXTVAL, USER, SYSDATE, vOperacao);
END;


-- Criação das tabelas

create table tb_usuario
(
 ID_usuario int not null, 
 nome varchar(50) not null,
 cpf int not null,
 dt_nascimento date not null,
 preferencial varchar(15)
);

create table tb_telefone
(
 ID_telefone int not null, 
 ddd int not null,
 numero int not null,
 ID_usuario int not null
);

create table tb_marca
(
  ID_marca int not null, 
 descricao varchar2(10)
);

create table tb_modelo
(
 ID_modelo int not null, 
 descricao varchar2(10),
 ID_marca int not null
);

create table tb_veiculo
(
 ID_veiculo int not null, 
 tipo varchar(15) not null,
 placa int not null,
 ID_usuario int not null,
 ID_modelo int not null
);

create table tb_bairro
(
 ID_bairro int not null, 
 nome varchar(20) not null
);

create table tb_cidade
(
 ID_cidade int not null, 
 nome varchar(20) not null,
 ID_bairro int not null
);

create table tb_estado
(
 ID_estado int not null, 
 nome varchar(20) not null,
 ID_cidade int not null
);

create table tb_shopping
(
 ID_shopping int not null, 
 Nome varchar(50) not null
);

create table tb_endereco 
(
 ID_endereco int not null,
 numero int not null,
 logradoro varchar2(10) not null,
 complemento varchar2(10),
 cep int not null, 
 ID_estado int not null,
 ID_shopping int not null
);

create table tb_regiao 
(
 ID_regiao int not null, 
 descicao varchar(10) not null,
 ID_setor int not null 
);

create table tb_setor 
(
 ID_setor int not null,
 descricao varchar2(15), 
 ID_vagas int not null
);

create table tb_vagas
(
 ID_vagas int not null, 
 estado char(01) not null,
 tipo_vaga varchar(15) not null,
 identificador int not null,
 ID_veiculo int not null
);

create table tb_estadia 
(
 ID_estadia int not null, 
 data_hora_entrada date not null,
 data_hora_saida date not null,
 ID_vagas int not null
);

create table tb_estacionamento
(
 ID_estacionamento int not null, 
 numero_vagas int not null,
 ID_shopping int not null,
 ID_regiao int not null
);

create table tb_cartao
(
 ID_cartao int not null, 
 numero_cartao int not null,
 cvv int not null,
 dt_vencimento date not null,
 ID_usuario int not null
);

create table tb_pagamento
(
 ID_pagamento int not null,
 tipo_pagamento varchar(30) not null,
 data_hora date not null,
 valor number not null,
 ID_usuario int not null,
 ID_estadia int not null,
 ID_cartao int not null
);

create table tb_preco 
(
 ID_preco int not null, 
 taxas_moto number not null,
 taxas_carro not null 
);


-- Criação das restrições de Chave Primária

alter table tb_usuario add constraint pk_usuario primary key (ID_usuario);

alter table tb_veiculo add constraint pk_veiculo primary key (ID_veiculo);

alter table tb_estado add constraint pk_estado primary key (ID_estado);

alter table tb_cidade add constraint pk_cidade primary key (ID_cidade);

alter table tb_bairro add constraint pk_bairro primary key (ID_bairro);

alter table tb_endereco add constraint pk_endereco primary key (ID_endereco);

alter table tb_pagamento add constraint pk_pagamento primary key (ID_pagamento);

alter table tb_shopping add constraint pk_shopping primary key (ID_shopping);

alter table tb_vagas add constraint pk_vagas primary key (ID_vagas);

alter table tb_estacionamento add constraint pk_estacionamento primary key (ID_estacionamento);

alter table tb_setor add constraint pk_setor primary key (ID_setor);

alter table tb_regiao add constraint pk_regiao primary key (ID_regiao);

alter table tb_estadia add constraint pk_estadia primary key (ID_estadia);

alter table tb_preco add constraint pk_preco primary key (ID_preco);

alter table tb_telefone add constraint pk_telefone primary key (ID_telefone);

alter table tb_cartao add constraint pk_cartao primary key (ID_cartao);


-- Criação das restrições

alter table tb_vagas add constraint ck_estado CHECK (estado in ('O','L'));
/*'O' = Ocupado. 'L' = Livre */

alter session set nls_date_format='dd/mm/yyyy';


-- Criação das restrições de Chave Estrangeira

alter table tb_telefone add constraint fk_telefone_usuario foreign key (ID_usuario) references tb_usuario(ID_usuario);

alter table tb_modelo add constraint fk_modelo_marca foreign key (ID_marca) references tb_estacionamento(ID_marca);

alter table tb_veiculo add constraint fk_veiculo_usuario foreign key (ID_usuario) references tb_usuario(ID_usuario);

alter table tb_veiculo add constraint fk_veiculo_modelo foreign key (ID_modelo) references tb_modelo(ID_modelo);

alter table tb_pagamento add constraint fk_pagamento_usuario foreign key (ID_usuario) references tb_usuario(ID_usuario);

alter table tb_pagamento add constraint fk_pagamento_estadia foreign key (ID_estadia) references tb_estadia(ID_estadia);

alter table tb_pagamento add constraint fk_pagamento_cartao foreign key (ID_cartao) references tb_cartao(ID_cartao);

alter table tb_cartao add constraint fk_cartao_usuario foreign key (ID_usuario) references tb_usuario(ID_ususario);

alter table tb_endereco add constraint fk_endereco_estado foreign key (ID_estado) references tb_estado(ID_estado);

alter table tb_endereco add constraint fk_endereco_shopping foreign key (ID_shopping) references tb_shopping(ID_shopping);

alter table tb_estadia add constraint fk_estadia_vagas foreign key (ID_vagas) references tb_vagas(ID_vagas);

alter table tb_vagas add constraint fk_vagas_veiculo foreign key (ID_veiculo) references tb_veiculo(ID_veiculo);

alter table tb_setor add constraint fk_setor_vagas foreign key (ID_vagas) references tb_vagas(ID_vagas);

alter table tb_regiao add constraint fk_regiao_setor foreign key (ID_setor) references tb_setor(ID_setor);

alter table tb_estacionamento add constraint fk_estacionamento_shopping foreign key (ID_shopping) references tb_shopping(ID_shopping);

alter table tb_estacionamento add constraint fk_estacionamento_regiao foreign key (ID_regiao) references tb_regiao(ID_regiao);

alter table tb_cidade add constraint fk_cidade_bairro foreign key (ID_bairro) references tb_bairro(ID_bairro);

alter table tb_estado add constraint fk_estado_cidade foreign key (ID_cidade) references tb_cidade(ID_cidade);


--Criacao de Sequencias

create sequence sq_usuario;
create sequence sq_telefone;
create sequence sq_marca;
create sequence sq_modelo;
create sequence sq_veiculo;
create sequence sq_bairro;
create sequence sq_cidade;
create sequence sq_estado;
create sequence sq_shopping;
create sequence sq_endereco;
create sequence sq_regiao;
create sequence sq_setor;
create sequence sq_vagas;
create sequence sq_estadia;
create sequence sq_estacionamento;
create sequence sq_cartao;
create sequence sq_pagamento;
create sequence sq_preco;

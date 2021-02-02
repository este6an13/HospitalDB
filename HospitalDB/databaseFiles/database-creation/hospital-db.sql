/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     29/01/2021 10:56:22 a. m.                    */
/*==============================================================*/


drop table if exists CITA;

drop table if exists MEDICO;

drop table if exists PACIENTE;

/*==============================================================*/
/* Table: CITA                                                  */
/*==============================================================*/
create table CITA
(
   ID_CITA              int not null,
   ID_PAC               varchar(15) not null,
   ID_MED               varchar(15) not null,
   FECHA_CITA           date not null,
   HORA_CITA            char(2) not null,
   primary key (ID_CITA)
);

/*==============================================================*/
/* Table: MEDICO                                                */
/*==============================================================*/
create table MEDICO
(
   ID_MED               varchar(15) not null,
   TIPO_ID_MED          char(2) not null,
   NOMBRE_MED           varchar(100) not null,
   NUM_TP               varchar(20) not null,
   EXP                  float(1) not null,
   ESP                  varchar(100) not null,
   INIC                 varchar(5) not null,
   FIN                  varchar(5) not null,
   primary key (ID_MED)
);

/*==============================================================*/
/* Table: PACIENTE                                              */
/*==============================================================*/
create table PACIENTE
(
   ID_PAC               varchar(15) not null,
   TIPO_ID_PAC          char(2) not null,
   NOMBRE_PAC           varchar(100) not null,
   FECHA_NAC            date not null,
   EPS                  varchar(30) not null,
   HISTORIA             varchar(5000) not null,
   primary key (ID_PAC)
);

alter table CITA add constraint FK_CITA foreign key (ID_PAC)
      references PACIENTE (ID_PAC) on delete restrict on update restrict;

alter table CITA add constraint FK_CITA2 foreign key (ID_MED)
      references MEDICO (ID_MED) on delete restrict on update restrict;



-- MXA values
DELETE FROM KEYVALUES;

--REM INSERTING into KEYVALUES
Insert into KEYVALUES (KEY_NAME,DATEVALUE,NUMERICVALUE,STRINGVALUE,DESCRIPTION) values ('SYSTEMUSERNAME',null,null,'PAT','SYSTEMUSERNAME er etatens bruker hos altinn');
Insert into KEYVALUES (KEY_NAME,DATEVALUE,NUMERICVALUE,STRINGVALUE,DESCRIPTION) values ('SYSTEMUSERCODE',null,null,'PAT_1','Kode for kildesystem. Tre første bokstaver representerer tjenesteeier. Etterfølgende tegn representerer avdeling system');
Insert into KEYVALUES (KEY_NAME,DATEVALUE,NUMERICVALUE,STRINGVALUE,DESCRIPTION) values ('LANGUAGECODE',null,null,'1044','Språkkode i Altinn. 1044 er norsk');
Insert into KEYVALUES (KEY_NAME,DATEVALUE,NUMERICVALUE,STRINGVALUE,DESCRIPTION) values ('ALTINNPASSWORD',null,null,'Wrong Password','Patentstyrets passord i Altinn');
Insert into KEYVALUES (KEY_NAME,DATEVALUE,NUMERICVALUE,STRINGVALUE,DESCRIPTION) values ('SMTPHOST',null,null,'10.0.0.25','Mailserver i patentstyret');
Insert into KEYVALUES (KEY_NAME,DATEVALUE,NUMERICVALUE,STRINGVALUE,DESCRIPTION) values ('SMTPUSER',null,null,null,'Brukernavn på mailserveren. Settes til null hvis autentisering ikke benyttes');
Insert into KEYVALUES (KEY_NAME,DATEVALUE,NUMERICVALUE,STRINGVALUE,DESCRIPTION) values ('SMTPPASSWORD',null,null,null,'Passord på mailserveren. Settes til null hvis autentisering ikke benyttes');
Insert into KEYVALUES (KEY_NAME,DATEVALUE,NUMERICVALUE,STRINGVALUE,DESCRIPTION) values ('MAILFROM',null,null,'mxa@patentstyret.no','Avsender på mail som sendes fra MXA'); 
Insert into KEYVALUES (KEY_NAME,DATEVALUE,NUMERICVALUE,STRINGVALUE,DESCRIPTION) VALUES ('RECEIPTFTPSERVER',null,null,'10.0.0.21','FTP-server hvor kvitteringsfilene fra Altinn ligger');
Insert into KEYVALUES (KEY_NAME,DATEVALUE,NUMERICVALUE,STRINGVALUE,DESCRIPTION) VALUES ('RECEIPTFTPPATH',null,null,'/altinn/test/kvittering','Filsti på FTP-serveren');
Insert into KEYVALUES (KEY_NAME,DATEVALUE,NUMERICVALUE,STRINGVALUE,DESCRIPTION) VALUES ('RECEIPTFTPUSER',null,null,'ftp_takisai','Bruker på FTP-serveren');
Insert into KEYVALUES (KEY_NAME,DATEVALUE,NUMERICVALUE,STRINGVALUE,DESCRIPTION) VALUES ('RECEIPTFTPPASSWORD',null,null,'Wrong Password','Passord på FTP-serveren');
--SendMail KEYVALUES
Insert into KEYVALUES (ID,KEY_NAME,DATEVALUE,NUMERICVALUE,STRINGVALUE,DESCRIPTION) VALUES (12,'MAILNOTICESUBJECT',null,null,'Brev fra Patentstyret er tilgjengelig i Altinn','E-post tittel felt');
Insert into KEYVALUES (ID,KEY_NAME,DATEVALUE,NUMERICVALUE,STRINGVALUE,DESCRIPTION) VALUES (13,'MAILNOTICECONTENT',null,null,'
Du/dere har mottatt et brev (en melding) fra NVE i Altinn-portalen.
Meldingen var tilgjengelig for ca. en uke siden, og vi kan ikke se at den er lest. 

Meldingen gjelder: ${messageHeader}

Trenger du hjelp? 
- For å logge inn på Altinn-portalen kan du følge denne lenken: www.altinn.no 
  Her finner du veiledninger, og Altinns brukerstøtte kan bistå. 
- Dersom du ønsker å snakke med noen i NVE, kontakt oss på telefon: 09575. 

Dette er en automatisk generert e-post. Svar på denne e-posten vil ikke bli lest. 

Med vennlig hilsen 
NVE','E-post hovedtekst med ${messageHeader}');
Insert into KEYVALUES (ID,KEY_NAME,DATEVALUE,NUMERICVALUE,STRINGVALUE,DESCRIPTION) VALUES (14,'MAILTOPAT',null,null,'mxa@patentstyret.no','Send kopi til');
Insert into KEYVALUES (ID,KEY_NAME,DATEVALUE,NUMERICVALUE,STRINGVALUE,DESCRIPTION) VALUES (15,'MAILWARNSUBJECT',null,null,'Brevet sendes pr post - ikke lest i Altinn','E-post tittel felt');
Insert into KEYVALUES (ID,KEY_NAME,DATEVALUE,NUMERICVALUE,STRINGVALUE,DESCRIPTION) VALUES (16,'MAILWARNCONTENT',null,null,
'Meldingen gjelder:  ${messageHeader}

${messageSummary}

${caseDescription}

Med vennlig hilsen
Administrator MXA
','E-post hovedtekst med ${messageHeader}, ${messageSummary}');
Insert into KEYVALUES (ID,KEY_NAME,DATEVALUE,NUMERICVALUE,STRINGVALUE,DESCRIPTION) VALUES (17,'NOTIFICATIONTYPE',null,null,'Correspondence','NotificationType i Correspondence. "none" for å ikke sende Notifications');
Insert into KEYVALUES (ID,KEY_NAME,DATEVALUE,NUMERICVALUE,STRINGVALUE,DESCRIPTION) VALUES (18,'SERVICECODE',null,null,'PAT','Tjenestekode, f.eks. PSA');
Insert into KEYVALUES (ID,KEY_NAME,DATEVALUE,NUMERICVALUE,STRINGVALUE,DESCRIPTION) VALUES (19,'SERVICEEDITION',null,null,'1','Tjenesteutgavekoden som meldingen gjelder for');

Insert into KEYVALUES (ID,KEY_NAME,DATEVALUE,NUMERICVALUE,STRINGVALUE,DESCRIPTION) VALUES (20,'MAILNOTICEDAYS',null,7,null,'Antall dager mellom melding sendt til Altinn og at infomail blir sendt.');
Insert into KEYVALUES (ID,KEY_NAME,DATEVALUE,NUMERICVALUE,STRINGVALUE,DESCRIPTION) VALUES (21,'MAILWARNDAYS',null,14,null,'Antall dager mellom melding sendt til Altinn og at varselsmail blir sendt.');

-- QUARTZ values

DELETE FROM QRTZ_TRIGGER_LISTENERS;
DELETE FROM QRTZ_SIMPLE_TRIGGERS;
DELETE FROM QRTZ_CRON_TRIGGERS ;
DELETE FROM QRTZ_TRIGGERS ;
DELETE FROM QRTZ_JOB_LISTENERS;
DELETE FROM QRTZ_JOB_DETAILS ;
DELETE FROM QRTZ_SCHEDULER_STATE ;

BEGIN TRANSACTION;
--REM INSERTING into QRTZ_JOB_DETAILS
Insert into QRTZ_JOB_DETAILS (DESCRIPTION,IS_DURABLE,IS_STATEFUL,IS_VOLATILE,JOB_CLASS_NAME,JOB_GROUP,JOB_NAME,REQUESTS_RECOVERY) values (null,'0','0','0','no.mxa.service.batch.CheckNewMessagesQuartzJob','DEFAULT','checkNewMessagesQuartzJob','0');
Insert into QRTZ_JOB_DETAILS (DESCRIPTION,IS_DURABLE,IS_STATEFUL,IS_VOLATILE,JOB_CLASS_NAME,JOB_GROUP,JOB_NAME,REQUESTS_RECOVERY) values (null,'0','0','0','no.mxa.service.batch.ConfirmationBatchQuartzJob','DEFAULT','confirmationBatchQuartzJob','0');
Insert into QRTZ_JOB_DETAILS (DESCRIPTION,IS_DURABLE,IS_STATEFUL,IS_VOLATILE,JOB_CLASS_NAME,JOB_GROUP,JOB_NAME,REQUESTS_RECOVERY) values (null,'0','0','0','no.mxa.service.batch.SendDeviationNoticeAndWarnQuartzJob','DEFAULT','sendDeviationNoticeAndWarnQuartzJob','0');

--REM INSERTING into QRTZ_TRIGGERS
Insert into QRTZ_TRIGGERS (CALENDAR_NAME,DESCRIPTION,END_TIME,IS_VOLATILE,JOB_GROUP,JOB_NAME,MISFIRE_INSTR,NEXT_FIRE_TIME,PREV_FIRE_TIME,PRIORITY,START_TIME,TRIGGER_GROUP,TRIGGER_NAME,TRIGGER_STATE,TRIGGER_TYPE) values (null,null,0,'0','DEFAULT','checkNewMessagesQuartzJob',0,-1,-1,5,-1,'DEFAULT','cronCheckNewMessages','WAITING','CRON');
Insert into QRTZ_TRIGGERS (CALENDAR_NAME,DESCRIPTION,END_TIME,IS_VOLATILE,JOB_GROUP,JOB_NAME,MISFIRE_INSTR,NEXT_FIRE_TIME,PREV_FIRE_TIME,PRIORITY,START_TIME,TRIGGER_GROUP,TRIGGER_NAME,TRIGGER_STATE,TRIGGER_TYPE) values (null,null,0,'0','DEFAULT','confirmationBatchQuartzJob',0,-1,-1,5,-1,'DEFAULT','cronConfirmationBatch','WAITING','CRON');
Insert into QRTZ_TRIGGERS (CALENDAR_NAME,DESCRIPTION,END_TIME,IS_VOLATILE,JOB_GROUP,JOB_NAME,MISFIRE_INSTR,NEXT_FIRE_TIME,PREV_FIRE_TIME,PRIORITY,START_TIME,TRIGGER_GROUP,TRIGGER_NAME,TRIGGER_STATE,TRIGGER_TYPE) values (null,null,0,'0','DEFAULT','sendDeviationNoticeAndWarnQuartzJob',0,-1,-1,5,-1,'DEFAULT','cronSendDeviationNoticeAndWarn','WAITING','CRON');

--REM INSERTING into QRTZ_CRON_TRIGGERS
Insert into QRTZ_CRON_TRIGGERS (CRON_EXPRESSION,TIME_ZONE_ID,TRIGGER_GROUP,TRIGGER_NAME) values ('00 00/10 6-21 ? * *','Europe/Berlin','DEFAULT','cronCheckNewMessages');
Insert into QRTZ_CRON_TRIGGERS (CRON_EXPRESSION,TIME_ZONE_ID,TRIGGER_GROUP,TRIGGER_NAME) values ('00 30 04 ? * *','Europe/Berlin','DEFAULT','cronConfirmationBatch');
Insert into QRTZ_CRON_TRIGGERS (CRON_EXPRESSION,TIME_ZONE_ID,TRIGGER_GROUP,TRIGGER_NAME) values ('00 30 05 ? * *','Europe/Berlin','DEFAULT','cronSendDeviationNoticeAndWarn');

truncate table  QRTZ_LOCKS ;
--REM INSERTING into QRTZ_LOCKS;
Insert into QRTZ_LOCKS (LOCK_NAME) values ('CALENDAR_ACCESS');
Insert into QRTZ_LOCKS (LOCK_NAME) values ('JOB_ACCESS');
Insert into QRTZ_LOCKS (LOCK_NAME) values ('MISFIRE_ACCESS');
Insert into QRTZ_LOCKS (LOCK_NAME) values ('STATE_ACCESS');
Insert into QRTZ_LOCKS (LOCK_NAME) values ('TRIGGER_ACCESS');

--REM INSERTING into QRTZ_SCHEDULER_STATE
Insert into QRTZ_SCHEDULER_STATE (CHECKIN_INTERVAL,INSTANCE_NAME,LAST_CHECKIN_TIME) values (7500,'wl0105401245756718984',1245758066812);



-- Commit
COMMIT;



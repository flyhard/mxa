
-- MXA values
DELETE FROM KEYVALUES;

REM INSERTING into KEYVALUES
Insert into KEYVALUES (ID,KEY_NAME,DATEVALUE,NUMERICVALUE,STRINGVALUE,DESCRIPTION) values (1,'SYSTEMUSERNAME',null,null,'PAT','SYSTEMUSERNAME er etatens bruker hos altinn');
Insert into KEYVALUES (ID,KEY_NAME,DATEVALUE,NUMERICVALUE,STRINGVALUE,DESCRIPTION) values (2,'SYSTEMUSERCODE',null,null,'PAT_1','Kode for kildesystem. Tre første bokstaver representerer tjenesteeier. Etterfølgende tegn representerer avdeling system');
Insert into KEYVALUES (ID,KEY_NAME,DATEVALUE,NUMERICVALUE,STRINGVALUE,DESCRIPTION) values (13,'LANGUAGECODE',null,null,'1044','Språkkode i Altinn. 1044 er norsk');
Insert into KEYVALUES (ID,KEY_NAME,DATEVALUE,NUMERICVALUE,STRINGVALUE,DESCRIPTION) values (14,'ALTINNPASSWORD',null,null,'Wrong Password','Patentstyrets passord i Altinn');
Insert into KEYVALUES (ID,KEY_NAME,DATEVALUE,NUMERICVALUE,STRINGVALUE,DESCRIPTION) values (16,'SMTPHOST',null,null,'10.0.0.25','Mailserver i patentstyret');
Insert into KEYVALUES (ID,KEY_NAME,DATEVALUE,NUMERICVALUE,STRINGVALUE,DESCRIPTION) values (17,'SMTPUSER',null,null,null,'Brukernavn på mailserveren. Settes til null hvis autentisering ikke benyttes');
Insert into KEYVALUES (ID,KEY_NAME,DATEVALUE,NUMERICVALUE,STRINGVALUE,DESCRIPTION) values (18,'SMTPPASSWORD',null,null,null,'Passord på mailserveren. Settes til null hvis autentisering ikke benyttes');
Insert into KEYVALUES (ID,KEY_NAME,DATEVALUE,NUMERICVALUE,STRINGVALUE,DESCRIPTION) values (19,'MAILFROM',null,null,'mxa@patentstyret.no','Avsender på mail som sendes fra MXA'); 
Insert into KEYVALUES (ID,KEY_NAME,DATEVALUE,NUMERICVALUE,STRINGVALUE,DESCRIPTION) VALUES (20,'RECEIPTFTPSERVER',null,null,'10.0.0.21','FTP-server hvor kvitteringsfilene fra Altinn ligger');
Insert into KEYVALUES (ID,KEY_NAME,DATEVALUE,NUMERICVALUE,STRINGVALUE,DESCRIPTION) VALUES (21,'RECEIPTFTPPATH',null,null,'/altinn/test/kvittering','Filsti på FTP-serveren');
Insert into KEYVALUES (ID,KEY_NAME,DATEVALUE,NUMERICVALUE,STRINGVALUE,DESCRIPTION) VALUES (22,'RECEIPTFTPUSER',null,null,'ftp_takisai','Bruker på FTP-serveren');
Insert into KEYVALUES (ID,KEY_NAME,DATEVALUE,NUMERICVALUE,STRINGVALUE,DESCRIPTION) VALUES (23,'RECEIPTFTPPASSWORD',null,null,'wrong Password','Passord på FTP-serveren');
--SendMail KEYVALUES
Insert into KEYVALUES (ID,KEY_NAME,DATEVALUE,NUMERICVALUE,STRINGVALUE,DESCRIPTION) VALUES (24,'MAILNOTICESUBJECT',null,null,'Brev fra Patentstyret er tilgjengelig i Altinn','E-post tittel felt');
Insert into KEYVALUES (ID,KEY_NAME,DATEVALUE,NUMERICVALUE,STRINGVALUE,DESCRIPTION) VALUES (25,'MAILNOTICECONTENT',null,null,'
Du/dere har mottatt et brev (en melding) fra Patentstyret i Altinn-portalen.
Meldingen var tilgjengelig for ca. en uke siden, og vi kan ikke se at den er lest. 

Meldingen gjelder: ${messageHeader}

Trenger du hjelp? 
- For å logge inn på Altinn-portalen kan du følge denne lenken: www.altinn.no 
  Her finner du veiledninger, og Altinns brukerstøtte kan bistå. 
- Dersom du ønsker å snakke med noen i Patentstyret, kontakt vårt infosenter på telefon: +47 22 38 73 33 (mandag - fredag 9.00 - 15.00) 

Patentstyret er i henhold til e-forvaltningsforskriften forpliktet til å sende slikt varsel. 
Dette er en automatisk generert e-post. Svar på denne e-posten vil ikke bli lest. 

Med vennlig hilsen 
Patentstyret','E-post hovedtekst med ${messageHeader}');
Insert into KEYVALUES (ID,KEY_NAME,DATEVALUE,NUMERICVALUE,STRINGVALUE,DESCRIPTION) VALUES (26,'MAILTOPAT',null,null,'mxa@patentstyret.no','Send kopi til');
Insert into KEYVALUES (ID,KEY_NAME,DATEVALUE,NUMERICVALUE,STRINGVALUE,DESCRIPTION) VALUES (27,'MAILWARNSUBJECT',null,null,'Brevet sendes pr post - ikke lest i Altinn','E-post tittel felt');
Insert into KEYVALUES (ID,KEY_NAME,DATEVALUE,NUMERICVALUE,STRINGVALUE,DESCRIPTION) VALUES (28,'MAILWARNCONTENT',null,null,
'Meldingen gjelder:  ${messageHeader}

${messageSummary}

${caseDescription}

Med vennlig hilsen
Administrator MXA
','E-post hovedtekst med ${messageHeader}, ${messageSummary}');
Insert into KEYVALUES (ID,KEY_NAME,DATEVALUE,NUMERICVALUE,STRINGVALUE,DESCRIPTION) VALUES (29,'NOTIFICATIONTYPE',null,null,'Correspondence','NotificationType i Correspondence. "none" for å ikke sende Notifications');
Insert into KEYVALUES (ID,KEY_NAME,DATEVALUE,NUMERICVALUE,STRINGVALUE,DESCRIPTION) VALUES (30,'SERVICECODE',null,null,'PAT','Tjenestekode, f.eks. PSA');
Insert into KEYVALUES (ID,KEY_NAME,DATEVALUE,NUMERICVALUE,STRINGVALUE,DESCRIPTION) VALUES (31,'SERVICEEDITION',null,null,'1','Tjenesteutgavekoden som meldingen gjelder for');
Insert into KEYVALUES (ID,KEY_NAME,DATEVALUE,NUMERICVALUE,STRINGVALUE,DESCRIPTION) VALUES (32,'MAILNOTICEDAYS',null,7,null,'Antall dager mellom melding sendt til Altinn og at infomail blir sendt.');
Insert into KEYVALUES (ID,KEY_NAME,DATEVALUE,NUMERICVALUE,STRINGVALUE,DESCRIPTION) VALUES (33,'MAILWARNDAYS',null,14,null,'Antall dager mellom melding sendt til Altinn og at varselsmail blir sendt.');

-- QUARTZ values
DELETE FROM QRTZ_CRON_TRIGGERS CASCADE;
REM INSERTING into QRTZ_CRON_TRIGGERS
Insert into QRTZ_CRON_TRIGGERS (CRON_EXPRESSION,TIME_ZONE_ID,TRIGGER_GROUP,TRIGGER_NAME) values ('00 00/10 6-21 ? * *','Europe/Berlin','DEFAULT','cronCheckNewMessages');
Insert into QRTZ_CRON_TRIGGERS (CRON_EXPRESSION,TIME_ZONE_ID,TRIGGER_GROUP,TRIGGER_NAME) values ('00 30 04 ? * *','Europe/Berlin','DEFAULT','cronConfirmationBatch');
Insert into QRTZ_CRON_TRIGGERS (CRON_EXPRESSION,TIME_ZONE_ID,TRIGGER_GROUP,TRIGGER_NAME) values ('00 30 05 ? * *','Europe/Berlin','DEFAULT','cronSendDeviationNoticeAndWarn');


DELETE FROM QRTZ_JOB_DETAILS CASCADE;
REM INSERTING into QRTZ_JOB_DETAILS
Insert into QRTZ_JOB_DETAILS (DESCRIPTION,IS_DURABLE,IS_STATEFUL,IS_VOLATILE,JOB_CLASS_NAME,JOB_GROUP,JOB_NAME,REQUESTS_RECOVERY) values (null,'0','0','0','no.mxa.service.batch.CheckNewMessagesQuartzJob','DEFAULT','checkNewMessagesQuartzJob','0');
Insert into QRTZ_JOB_DETAILS (DESCRIPTION,IS_DURABLE,IS_STATEFUL,IS_VOLATILE,JOB_CLASS_NAME,JOB_GROUP,JOB_NAME,REQUESTS_RECOVERY) values (null,'0','0','0','no.mxa.service.batch.ConfirmationBatchQuartzJob','DEFAULT','confirmationBatchQuartzJob','0');
Insert into QRTZ_JOB_DETAILS (DESCRIPTION,IS_DURABLE,IS_STATEFUL,IS_VOLATILE,JOB_CLASS_NAME,JOB_GROUP,JOB_NAME,REQUESTS_RECOVERY) values (null,'0','0','0','no.mxa.service.batch.SendDeviationNoticeAndWarnQuartzJob','DEFAULT','sendDeviationNoticeAndWarnQuartzJob','0');


DELETE FROM QRTZ_LOCKS CASCADE;
REM INSERTING into QRTZ_LOCKS;
Insert into QRTZ_LOCKS (LOCK_NAME) values ('CALENDAR_ACCESS');
Insert into QRTZ_LOCKS (LOCK_NAME) values ('JOB_ACCESS');
Insert into QRTZ_LOCKS (LOCK_NAME) values ('MISFIRE_ACCESS');
Insert into QRTZ_LOCKS (LOCK_NAME) values ('STATE_ACCESS');
Insert into QRTZ_LOCKS (LOCK_NAME) values ('TRIGGER_ACCESS');

DELETE FROM QRTZ_SCHEDULER_STATE CASCADE;
REM INSERTING into QRTZ_SCHEDULER_STATE
Insert into QRTZ_SCHEDULER_STATE (CHECKIN_INTERVAL,INSTANCE_NAME,LAST_CHECKIN_TIME) values (7500,'wl0105401245756718984',1245758066812);

DELETE FROM QRTZ_TRIGGERS CASCADE;
REM INSERTING into QRTZ_TRIGGERS
Insert into QRTZ_TRIGGERS (CALENDAR_NAME,DESCRIPTION,END_TIME,IS_VOLATILE,JOB_GROUP,JOB_NAME,MISFIRE_INSTR,NEXT_FIRE_TIME,PREV_FIRE_TIME,PRIORITY,START_TIME,TRIGGER_GROUP,TRIGGER_NAME,TRIGGER_STATE,TRIGGER_TYPE) values (null,null,0,'0','DEFAULT','checkNewMessagesQuartzJob',0,-1,-1,5,-1,'DEFAULT','cronCheckNewMessages','WAITING','CRON');
Insert into QRTZ_TRIGGERS (CALENDAR_NAME,DESCRIPTION,END_TIME,IS_VOLATILE,JOB_GROUP,JOB_NAME,MISFIRE_INSTR,NEXT_FIRE_TIME,PREV_FIRE_TIME,PRIORITY,START_TIME,TRIGGER_GROUP,TRIGGER_NAME,TRIGGER_STATE,TRIGGER_TYPE) values (null,null,0,'0','DEFAULT','confirmationBatchQuartzJob',0,-1,-1,5,-1,'DEFAULT','cronConfirmationBatch','WAITING','CRON');
Insert into QRTZ_TRIGGERS (CALENDAR_NAME,DESCRIPTION,END_TIME,IS_VOLATILE,JOB_GROUP,JOB_NAME,MISFIRE_INSTR,NEXT_FIRE_TIME,PREV_FIRE_TIME,PRIORITY,START_TIME,TRIGGER_GROUP,TRIGGER_NAME,TRIGGER_STATE,TRIGGER_TYPE) values (null,null,0,'0','DEFAULT','sendDeviationNoticeAndWarnQuartzJob',0,-1,-1,5,-1,'DEFAULT','cronSendDeviationNoticeAndWarn','WAITING','CRON');


-- Commit
COMMIT;



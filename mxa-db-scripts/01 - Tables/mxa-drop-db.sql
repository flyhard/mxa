-- Drops everything and truncate exceptions
BEGIN 
    EXECUTE IMMEDIATE 'DROP TABLE CONTACTINFO CASCADE CONSTRAINTS'; 
    EXECUTE IMMEDIATE 'DROP TABLE LOG CASCADE CONSTRAINTS'; 
    EXECUTE IMMEDIATE 'DROP TABLE MESSAGE CASCADE CONSTRAINTS'; 
    EXECUTE IMMEDIATE 'DROP TABLE KEYVALUES CASCADE CONSTRAINTS'; 
    EXECUTE IMMEDIATE 'DROP TABLE ATTACHMENT CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP SEQUENCE CONTACTINFO_SEQ';
    EXECUTE IMMEDIATE 'DROP SEQUENCE MESSAGE_SEQ';
    EXECUTE IMMEDIATE 'DROP SEQUENCE KEYVALUES_SEQ';
    EXECUTE IMMEDIATE 'DROP SEQUENCE LOG_SEQ';
    EXECUTE IMMEDIATE 'DROP SEQUENCE ATTACHMENT_SEQ';
    EXECUTE IMMEDIATE 'DROP TABLE QRTZ_JOB_DETAILS CASCADE CONSTRAINTS'; 
    EXECUTE IMMEDIATE 'DROP TABLE QRTZ_JOB_LISTENERS CASCADE CONSTRAINTS'; 
    EXECUTE IMMEDIATE 'DROP TABLE QRTZ_TRIGGERS CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE QRTZ_SIMPLE_TRIGGERS CASCADE CONSTRAINTS'; 
    EXECUTE IMMEDIATE 'DROP TABLE QRTZ_CRON_TRIGGERS CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE QRTZ_BLOB_TRIGGERS CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE QRTZ_TRIGGER_LISTENERS CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE QRTZ_CALENDARS CASCADE CONSTRAINTS'; 
    EXECUTE IMMEDIATE 'DROP TABLE QRTZ_PAUSED_TRIGGER_GRPS CASCADE CONSTRAINTS'; 
    EXECUTE IMMEDIATE 'DROP TABLE QRTZ_FIRED_TRIGGERS CASCADE CONSTRAINTS'; 
    EXECUTE IMMEDIATE 'DROP TABLE QRTZ_SCHEDULER_STATE CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE QRTZ_LOCKS CASCADE CONSTRAINTS'; 
    EXCEPTION WHEN OTHERS THEN NULL; 
END;
/
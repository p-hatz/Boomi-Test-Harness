-- SQLINES FOR EVALUATION USE ONLY (14 DAYS)
CREATE TABLE processTestSuite (
  processIdSrc varchar(64) DEFAULT NULL,
  processIdClone varchar(64) DEFAULT NULL,
  testSuiteId int NOT NULL IDENTITY,
  PRIMARY KEY (testSuiteId)
);

CREATE TABLE testSuite (
  id int NOT NULL identity primary key,
  name varchar(20) DEFAULT NULL,
  PRIMARY KEY (id)
);


CREATE TABLE testCase (
  id int NOT NULL,
  name varchar(40) DEFAULT NULL,
  tsId int DEFAULT NULL,
  PRIMARY KEY (id)
,
  CONSTRAINT fk_ts_id FOREIGN KEY (tsId) REFERENCES testSuite (id)
);

CREATE INDEX fk_ts_id ON testCase (tsId);


CREATE TABLE testCaseExpected (
  id int DEFAULT NULL,
  val varchar(1000) DEFAULT NULL,
  tcId int DEFAULT NULL
,
  CONSTRAINT fk_tc_id FOREIGN KEY (tcId) REFERENCES testCase (id)
);

CREATE INDEX fk_tc_id ON testCaseExpected (tcId);

CREATE TABLE testCaseExec (
  id int identity primary key,
  execId varchar(64) NOT NULL,
  tsId int DEFAULT NULL,
  tcId int DEFAULT NULL,
  actualVal varchar(1000) DEFAULT NULL,
  status int DEFAULT NULL,
  execDt datetime2(0) NULL DEFAULT current_timestamp,
  PRIMARY KEY (id)
,
  CONSTRAINT testCaseExec_ibfk_1 FOREIGN KEY (tsId) REFERENCES testSuite (id),
  CONSTRAINT testCaseExec_ibfk_2 FOREIGN KEY (tcId) REFERENCES testCase (id)
);

CREATE INDEX tsId ON testCaseExec (tsId);
CREATE INDEX tcId ON testCaseExec (tcId);

CREATE OR ALTER VIEW vwTestCaseActualvsExpected AS
select
    tcexec.execId AS execId,
    pts.processIdSrc AS processIdSrc,
    pts.processIdClone AS processIdClone,
    ts.id AS tsId,
    tc.id AS tcId,
    tc.name AS name,
    tce.val AS expectedVal,
    tcexec.actualVal AS actualVal,
    tcexec.execDt AS actualValExecDt,
    tcexec.status AS status
from
    ((((processTestSuite pts
join testSuite ts on
    (pts.testSuiteId = ts.id))
join testCase tc on
    (ts.id = tc.tsId))
join testCaseExpected tce on
    (tc.id = tce.tcId))
join testCaseExec tcexec on
    (tcexec.tsId = ts.id
        and tcexec.tcId = tc.id));

CREATE OR ALTER VIEW vwTestCaseExpected AS
select
    pts.processIdSrc AS processIdSrc,
    pts.processIdClone AS processIdClone,
    ts.id AS tsId,
    tc.id AS tcId,
    tc.name AS name,
    tce.val AS val
from
    (((processTestSuite pts
join testSuite ts on
    (pts.testSuiteId = ts.id))
join testCase tc on
    (ts.id = tc.tsId))
join testCaseExpected tce on
    (tc.id = tce.tcId));

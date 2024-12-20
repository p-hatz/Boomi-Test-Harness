CREATE TABLE `processTestSuite` (
  `processIdSrc` varchar(64) DEFAULT NULL,
  `processIdClone` varchar(64) DEFAULT NULL,
  `testSuiteId` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`testSuiteId`)
);

CREATE TABLE `testSuite` (
  `id` int(11) NOT NULL auto_increment primary key,
  `name` varchar(200) DEFAULT NULL
);


CREATE TABLE `testCase` (
  `id` int(11) auto_increment primary key,
  `name` varchar(40) DEFAULT NULL,
  `tsId` int(11) DEFAULT NULL,
  KEY `fk_ts_id` (`tsId`),
  CONSTRAINT `fk_ts_id` FOREIGN KEY (`tsId`) REFERENCES `testSuite` (`id`)
);


CREATE TABLE `testCaseExpected` (
  `id` int(11) auto_increment primary key,
  `val` varchar(1000) DEFAULT NULL,
  `tcId` int(11) DEFAULT NULL,
  KEY `fk_tc_id` (`tcId`),
  CONSTRAINT `fk_tc_id` FOREIGN KEY (`tcId`) REFERENCES `testCase` (`id`)
);

CREATE TABLE `testCaseExec` (
  `id` int(11) auto_increment primary key,
  `execId` varchar(64) NOT NULL,
  `tsId` int(11) DEFAULT NULL,
  `tcId` int(11) DEFAULT NULL,
  `actualVal` varchar(1000) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `execDt` timestamp NULL DEFAULT current_timestamp(),
  CONSTRAINT `testCaseExec_ibfk_1` FOREIGN KEY (`tsId`) REFERENCES `testSuite` (`id`),
  CONSTRAINT `testCaseExec_ibfk_2` FOREIGN KEY (`tcId`) REFERENCES `testCase` (`id`)
);

CREATE TABLE `componentDef` (
  `componentId` varchar(64) not null,
  `shapeName` varchar(32) not null,
  `shapeType` varchar(128) DEFAULT NULL,
  `shapeLabel` varchar(256) DEFAULT NULL,
  `nextShape` varchar(32) DEFAULT NULL,
  primary key (componentId,shapeName)
);

CREATE OR REPLACE VIEW `vwTestCaseActualvsExpected` AS
select
    `tcexec`.`execId` AS `execId`,
    `pts`.`processIdSrc` AS `processIdSrc`,
    `pts`.`processIdClone` AS `processIdClone`,
    `ts`.`id` AS `tsId`,
    `tc`.`id` AS `tcId`,
    `tc`.`name` AS `name`,
    `tce`.`val` AS `expectedVal`,
    `tcexec`.`actualVal` AS `actualVal`,
    `tcexec`.`execDt` AS `actualValExecDt`,
    `tcexec`.`status` AS `status`
from
    ((((`processTestSuite` `pts`
join `testSuite` `ts` on
    (`pts`.`testSuiteId` = `ts`.`id`))
join `testCase` `tc` on
    (`ts`.`id` = `tc`.`tsId`))
join `testCaseExpected` `tce` on
    (`tc`.`id` = `tce`.`tcId`))
join `testCaseExec` `tcexec` on
    (`tcexec`.`tsId` = `ts`.`id`
        and `tcexec`.`tcId` = `tc`.`id`));

CREATE OR REPLACE VIEW `vwTestCaseExpected` AS
select
    `pts`.`processIdSrc` AS `processIdSrc`,
    `pts`.`processIdClone` AS `processIdClone`,
    `ts`.`id` AS `tsId`,
    `tc`.`id` AS `tcId`,
    `tc`.`name` AS `name`,
    `tce`.`val` AS `val`
from
    (((`processTestSuite` `pts`
join `testSuite` `ts` on
    (`pts`.`testSuiteId` = `ts`.`id`))
join `testCase` `tc` on
    (`ts`.`id` = `tc`.`tsId`))
join `testCaseExpected` `tce` on
    (`tc`.`id` = `tce`.`tcId`));

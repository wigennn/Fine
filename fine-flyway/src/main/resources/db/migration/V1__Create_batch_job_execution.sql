/*
Navicat MySQL Data Transfer

Source Server         : edu_risk
Source Server Version : 50711
Source Host           : 172.24.138.2:5688
Source Database       : edu_financialanalysis

Target Server Type    : MYSQL
Target Server Version : 50711
File Encoding         : 65001

Date: 2020-09-09 16:54:58
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for batch_job_execution
-- ----------------------------
DROP TABLE IF EXISTS `batch_job_execution`;
CREATE TABLE `batch_job_execution` (
  `JOB_EXECUTION_ID` bigint(20) NOT NULL,
  `VERSION` bigint(20) DEFAULT NULL,
  `JOB_INSTANCE_ID` bigint(20) NOT NULL,
  `CREATE_TIME` datetime NOT NULL,
  `START_TIME` datetime DEFAULT NULL,
  `END_TIME` datetime DEFAULT NULL,
  `STATUS` varchar(10) DEFAULT NULL,
  `EXIT_CODE` varchar(2500) DEFAULT NULL,
  `EXIT_MESSAGE` varchar(2500) DEFAULT NULL,
  `LAST_UPDATED` datetime DEFAULT NULL,
  `JOB_CONFIGURATION_LOCATION` varchar(2500) DEFAULT NULL,
  PRIMARY KEY (`JOB_EXECUTION_ID`),
  KEY `JOB_INST_EXEC_FK` (`JOB_INSTANCE_ID`),
  CONSTRAINT `JOB_INST_EXEC_FK` FOREIGN KEY (`JOB_INSTANCE_ID`) REFERENCES `batch_job_instance` (`JOB_INSTANCE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for batch_job_execution_context
-- ----------------------------
DROP TABLE IF EXISTS `batch_job_execution_context`;
CREATE TABLE `batch_job_execution_context` (
  `JOB_EXECUTION_ID` bigint(20) NOT NULL,
  `SHORT_CONTEXT` varchar(2500) NOT NULL,
  `SERIALIZED_CONTEXT` text,
  PRIMARY KEY (`JOB_EXECUTION_ID`),
  CONSTRAINT `JOB_EXEC_CTX_FK` FOREIGN KEY (`JOB_EXECUTION_ID`) REFERENCES `batch_job_execution` (`JOB_EXECUTION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for batch_job_execution_params
-- ----------------------------
DROP TABLE IF EXISTS `batch_job_execution_params`;
CREATE TABLE `batch_job_execution_params` (
  `JOB_EXECUTION_ID` bigint(20) NOT NULL,
  `TYPE_CD` varchar(6) NOT NULL,
  `KEY_NAME` varchar(100) NOT NULL,
  `STRING_VAL` varchar(250) DEFAULT NULL,
  `DATE_VAL` datetime DEFAULT NULL,
  `LONG_VAL` bigint(20) DEFAULT NULL,
  `DOUBLE_VAL` double DEFAULT NULL,
  `IDENTIFYING` char(1) NOT NULL,
  KEY `JOB_EXEC_PARAMS_FK` (`JOB_EXECUTION_ID`),
  CONSTRAINT `JOB_EXEC_PARAMS_FK` FOREIGN KEY (`JOB_EXECUTION_ID`) REFERENCES `batch_job_execution` (`JOB_EXECUTION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for batch_job_execution_seq
-- ----------------------------
DROP TABLE IF EXISTS `batch_job_execution_seq`;
CREATE TABLE `batch_job_execution_seq` (
  `ID` bigint(20) NOT NULL,
  `UNIQUE_KEY` char(1) NOT NULL,
  UNIQUE KEY `UNIQUE_KEY_UN` (`UNIQUE_KEY`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for batch_job_instance
-- ----------------------------
DROP TABLE IF EXISTS `batch_job_instance`;
CREATE TABLE `batch_job_instance` (
  `JOB_INSTANCE_ID` bigint(20) NOT NULL,
  `VERSION` bigint(20) DEFAULT NULL,
  `JOB_NAME` varchar(100) NOT NULL,
  `JOB_KEY` varchar(32) NOT NULL,
  PRIMARY KEY (`JOB_INSTANCE_ID`),
  UNIQUE KEY `JOB_INST_UN` (`JOB_NAME`,`JOB_KEY`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for batch_job_seq
-- ----------------------------
DROP TABLE IF EXISTS `batch_job_seq`;
CREATE TABLE `batch_job_seq` (
  `ID` bigint(20) NOT NULL,
  `UNIQUE_KEY` char(1) NOT NULL,
  UNIQUE KEY `UNIQUE_KEY_UN` (`UNIQUE_KEY`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for batch_step_execution
-- ----------------------------
DROP TABLE IF EXISTS `batch_step_execution`;
CREATE TABLE `batch_step_execution` (
  `STEP_EXECUTION_ID` bigint(20) NOT NULL,
  `VERSION` bigint(20) NOT NULL,
  `STEP_NAME` varchar(100) NOT NULL,
  `JOB_EXECUTION_ID` bigint(20) NOT NULL,
  `START_TIME` datetime NOT NULL,
  `END_TIME` datetime DEFAULT NULL,
  `STATUS` varchar(10) DEFAULT NULL,
  `COMMIT_COUNT` bigint(20) DEFAULT NULL,
  `READ_COUNT` bigint(20) DEFAULT NULL,
  `FILTER_COUNT` bigint(20) DEFAULT NULL,
  `WRITE_COUNT` bigint(20) DEFAULT NULL,
  `READ_SKIP_COUNT` bigint(20) DEFAULT NULL,
  `WRITE_SKIP_COUNT` bigint(20) DEFAULT NULL,
  `PROCESS_SKIP_COUNT` bigint(20) DEFAULT NULL,
  `ROLLBACK_COUNT` bigint(20) DEFAULT NULL,
  `EXIT_CODE` varchar(2500) DEFAULT NULL,
  `EXIT_MESSAGE` varchar(2500) DEFAULT NULL,
  `LAST_UPDATED` datetime DEFAULT NULL,
  PRIMARY KEY (`STEP_EXECUTION_ID`),
  KEY `JOB_EXEC_STEP_FK` (`JOB_EXECUTION_ID`),
  CONSTRAINT `JOB_EXEC_STEP_FK` FOREIGN KEY (`JOB_EXECUTION_ID`) REFERENCES `batch_job_execution` (`JOB_EXECUTION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for batch_step_execution_context
-- ----------------------------
DROP TABLE IF EXISTS `batch_step_execution_context`;
CREATE TABLE `batch_step_execution_context` (
  `STEP_EXECUTION_ID` bigint(20) NOT NULL,
  `SHORT_CONTEXT` varchar(2500) NOT NULL,
  `SERIALIZED_CONTEXT` text,
  PRIMARY KEY (`STEP_EXECUTION_ID`),
  CONSTRAINT `STEP_EXEC_CTX_FK` FOREIGN KEY (`STEP_EXECUTION_ID`) REFERENCES `batch_step_execution` (`STEP_EXECUTION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for batch_step_execution_seq
-- ----------------------------
DROP TABLE IF EXISTS `batch_step_execution_seq`;
CREATE TABLE `batch_step_execution_seq` (
  `ID` bigint(20) NOT NULL,
  `UNIQUE_KEY` char(1) NOT NULL,
  UNIQUE KEY `UNIQUE_KEY_UN` (`UNIQUE_KEY`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for common_gbbm
-- ----------------------------
DROP TABLE IF EXISTS `common_gbbm`;
CREATE TABLE `common_gbbm` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `GBBM` varchar(10) NOT NULL COMMENT '国标编码',
  `GBBMMC` varchar(50) NOT NULL COMMENT '国标编码名称',
  `SJGBBM` varchar(10) DEFAULT NULL COMMENT '上级国标编码',
  `YXQQ` date DEFAULT NULL COMMENT '有效期起',
  `YXQZ` date DEFAULT NULL COMMENT '有效期至',
  `CREATE_TIME` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `IS_SHOW` tinyint(2) DEFAULT NULL COMMENT '是否展示',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for common_xzqh
-- ----------------------------
DROP TABLE IF EXISTS `common_xzqh`;
CREATE TABLE `common_xzqh` (
  `K_XZQHID` varchar(12) NOT NULL,
  `K_XZQHMC` varchar(128) NOT NULL,
  `K_SJXZQHID` varchar(12) NOT NULL,
  `K_ZT` char(3) NOT NULL DEFAULT '1' COMMENT '1-正常；2-冻结；0-删除',
  PRIMARY KEY (`K_XZQHID`),
  KEY `INdex` (`K_SJXZQHID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='K_XZQHID=’0‘ 表示中国\nK_SJXZQHID=’0‘ 表示省/直辖市';

-- ----------------------------
-- Table structure for eas_balance
-- ----------------------------
DROP TABLE IF EXISTS `eas_balance`;
CREATE TABLE `eas_balance` (
  `FORGUNITID` varchar(255) DEFAULT NULL,
  `FACCOUNTID` varchar(255) DEFAULT NULL,
  `FCURRENCYID` varchar(255) DEFAULT NULL,
  `FPERIOD` varchar(255) DEFAULT NULL,
  `FBEGINBALANCEFOR` varchar(255) DEFAULT NULL,
  `FDEBITFOR` varchar(255) DEFAULT NULL,
  `FCREDITFOR` varchar(255) DEFAULT NULL,
  `FENDBALANCEFOR` varchar(255) DEFAULT NULL,
  `FYEARDEBITFOR` varchar(255) DEFAULT NULL,
  `FYEARCREDITFOR` varchar(255) DEFAULT NULL,
  `FBEGINBALANCELOCAL` varchar(255) DEFAULT NULL,
  `FDEBITLOCAL` varchar(255) DEFAULT NULL,
  `FCREDITLOCAL` varchar(255) DEFAULT NULL,
  `FENDBALANCELOCAL` varchar(255) DEFAULT NULL,
  `FYEARDEBITLOCAL` varchar(255) DEFAULT NULL,
  `FYEARCREDITLOCAL` varchar(255) DEFAULT NULL,
  `FBEGINBALANCERPT` varchar(255) DEFAULT NULL,
  `FDEBITRPT` varchar(255) DEFAULT NULL,
  `FCREDITRPT` varchar(255) DEFAULT NULL,
  `FENDBALANCERPT` varchar(255) DEFAULT NULL,
  `FYEARDEBITRPT` varchar(255) DEFAULT NULL,
  `FYEARCREDITRPT` varchar(255) DEFAULT NULL,
  `FMONTHPNLFOR` varchar(255) DEFAULT NULL,
  `FYEARPNLFOR` varchar(255) DEFAULT NULL,
  `FMONTHPNLLOCAL` varchar(255) DEFAULT NULL,
  `FYEARPNLLOCAL` varchar(255) DEFAULT NULL,
  `FMONTHPNLRPT` varchar(255) DEFAULT NULL,
  `FYEARPNLRPT` varchar(255) DEFAULT NULL,
  `FBEGINQTY` varchar(255) DEFAULT NULL,
  `FDEBITQTY` varchar(255) DEFAULT NULL,
  `FCREDITQTY` varchar(255) DEFAULT NULL,
  `FENDQTY` varchar(255) DEFAULT NULL,
  `FYEARDEBITQTY` varchar(255) DEFAULT NULL,
  `FYEARCREDITQTY` varchar(255) DEFAULT NULL,
  `FDETAILCOUNT` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for eas_subject
-- ----------------------------
DROP TABLE IF EXISTS `eas_subject`;
CREATE TABLE `eas_subject` (
  `FID` varchar(255) DEFAULT NULL,
  `FNAME_L1` varchar(255) DEFAULT NULL,
  `FNAME_L2` varchar(255) DEFAULT NULL,
  `FNAME_L3` varchar(255) DEFAULT NULL,
  `FNUMBER` varchar(255) DEFAULT NULL,
  `FDESCRIPTION_L1` varchar(255) DEFAULT NULL,
  `FDESCRIPTION_L2` varchar(255) DEFAULT NULL,
  `FDESCRIPTION_L3` varchar(255) DEFAULT NULL,
  `FSIMPLENAME` varchar(255) DEFAULT NULL,
  `FISLEAF` varchar(255) DEFAULT NULL,
  `FLEVEL` varchar(255) DEFAULT NULL,
  `FLONGNUMBER` varchar(255) DEFAULT NULL,
  `FCREATORID` varchar(255) DEFAULT NULL,
  `FCREATETIME` varchar(255) DEFAULT NULL,
  `FLASTUPDATEUSERID` varchar(255) DEFAULT NULL,
  `FLASTUPDATETIME` varchar(255) DEFAULT NULL,
  `FACCOUNTTABLEID` varchar(255) DEFAULT NULL,
  `FACCOUNTTYPEID` varchar(255) DEFAULT NULL,
  `FLONGNAME_L1` varchar(255) DEFAULT NULL,
  `FLONGNAME_L2` varchar(255) DEFAULT NULL,
  `FLONGNAME_L3` varchar(255) DEFAULT NULL,
  `FPARENTID` varchar(255) DEFAULT NULL,
  `FISGFREEZE` varchar(255) DEFAULT NULL,
  `FGAA` varchar(255) DEFAULT NULL,
  `FISCFREEZE` varchar(255) DEFAULT NULL,
  `FHELPCODE` varchar(255) DEFAULT NULL,
  `FCOMPANYID` varchar(255) DEFAULT NULL,
  `FCURRENCYID` varchar(255) DEFAULT NULL,
  `FDC` varchar(255) DEFAULT NULL,
  `FISCHANGECURRENCY` varchar(255) DEFAULT NULL,
  `FISCASHEQUIVALENT` varchar(255) DEFAULT NULL,
  `FISCOUNTACCRUAL` varchar(255) DEFAULT NULL,
  `FACCRUALPER` varchar(255) DEFAULT NULL,
  `FISQTY` varchar(255) DEFAULT NULL,
  `FMEASUREUNITGROUPID` varchar(255) DEFAULT NULL,
  `FMEASUREUNITID` varchar(255) DEFAULT NULL,
  `FAC` varchar(255) DEFAULT NULL,
  `FPLTYPE` varchar(255) DEFAULT NULL,
  `FCONTROL` varchar(255) DEFAULT NULL,
  `FCAA` varchar(255) DEFAULT NULL,
  `FACCTCURRENCY` varchar(255) DEFAULT NULL,
  `FISBANK` varchar(255) DEFAULT NULL,
  `FISCASH` varchar(255) DEFAULT NULL,
  `FHASUSERPROPERTY` varchar(255) DEFAULT NULL,
  `FACCOUNTID` varchar(255) DEFAULT NULL,
  `FGLEVEL` varchar(255) DEFAULT NULL,
  `FISALLOWCA` varchar(255) DEFAULT NULL,
  `FCONTROLUNITID` varchar(255) DEFAULT NULL,
  `FUPPERID` varchar(255) DEFAULT NULL,
  `FPARENTAAID` varchar(255) DEFAULT NULL,
  `FISUPPERALLOWCA` varchar(255) DEFAULT NULL,
  `FISSELFFREEZE` varchar(255) DEFAULT NULL,
  `FISPARENTFREEZE` varchar(255) DEFAULT NULL,
  `FREFID` varchar(255) DEFAULT NULL,
  `FCONTROLLEVEL` varchar(255) DEFAULT NULL,
  `FISOUTDAILYACCOUNT` varchar(255) DEFAULT NULL,
  `FDISPLAYNAME_L1` varchar(255) DEFAULT NULL,
  `FDISPLAYNAME_L2` varchar(255) DEFAULT NULL,
  `FDISPLAYNAME_L3` varchar(255) DEFAULT NULL,
  `FACNOTICE` varchar(255) DEFAULT NULL,
  `FBW` varchar(255) DEFAULT NULL,
  `FMAINCASHFLOWITEMID` varchar(255) DEFAULT NULL,
  `FATTCASHFLOWITEMID` varchar(255) DEFAULT NULL,
  `FBORROWERMAINCASHFLOWITEMID` varchar(255) DEFAULT NULL,
  `FBORROWERATTCASHFLOWITEMID` varchar(255) DEFAULT NULL,
  `FLENDERMAINCASHFLOWITEMID` varchar(255) DEFAULT NULL,
  `FLENDERATTCASHFLOWITEMID` varchar(255) DEFAULT NULL,
  `FISCONTROL` varchar(255) DEFAULT NULL,
  `FNAMEPINYIN` varchar(255) DEFAULT NULL,
  `FNAMESHORTPINYIN` varchar(255) DEFAULT NULL,
  `FACCRUALDIRECTION` varchar(255) DEFAULT NULL,
  `FISBIZCHANGECURRENCY` varchar(255) DEFAULT NULL,
  `FISPROFITCENTER` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for finaceo_report_limit
-- ----------------------------
DROP TABLE IF EXISTS `finaceo_report_limit`;
CREATE TABLE `finaceo_report_limit` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_set_id` bigint(20) DEFAULT NULL COMMENT '账套ID',
  `enable` tinyint(4) DEFAULT NULL COMMENT '是否启用(0-禁用,1-启用)',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='智泽华报表限制表';

-- ----------------------------
-- Table structure for finaceo_report_template
-- ----------------------------
DROP TABLE IF EXISTS `finaceo_report_template`;
CREATE TABLE `finaceo_report_template` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `report_id` bigint(4) DEFAULT NULL COMMENT '报表ID',
  `row_num` int(20) DEFAULT NULL COMMENT '行次',
  `row_name` varchar(50) DEFAULT NULL COMMENT '内容',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='智泽华报表模板表';

-- ----------------------------
-- Table structure for risk_account_age_result
-- ----------------------------
DROP TABLE IF EXISTS `risk_account_age_result`;
CREATE TABLE `risk_account_age_result` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_set_id` bigint(20) DEFAULT NULL,
  `period` varchar(10) DEFAULT NULL,
  `group_type` tinyint(1) DEFAULT NULL COMMENT '分组类型(1-科目分组，2-辅助核算分组)',
  `subject_inner_code` varchar(25) DEFAULT NULL COMMENT '科目内码',
  `subject_code` varchar(25) DEFAULT NULL,
  `auxiliary_name` varchar(50) DEFAULT NULL COMMENT '辅助名称',
  `range_amount1` varchar(50) DEFAULT NULL,
  `range_amount2` varchar(50) DEFAULT NULL,
  `range_amount3` varchar(50) DEFAULT NULL,
  `range_amount4` varchar(50) DEFAULT NULL,
  `range_amount5` varchar(50) DEFAULT NULL,
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=118 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for risk_account_report
-- ----------------------------
DROP TABLE IF EXISTS `risk_account_report`;
CREATE TABLE `risk_account_report` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `account_set_id` bigint(20) DEFAULT NULL COMMENT '账套ID',
  `report_id` bigint(20) DEFAULT NULL COMMENT '报告ID',
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1674 DEFAULT CHARSET=utf8 COMMENT='账套报告关联表';

-- ----------------------------
-- Table structure for risk_account_set
-- ----------------------------
DROP TABLE IF EXISTS `risk_account_set`;
CREATE TABLE `risk_account_set` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL COMMENT '账套名称',
  `code` varchar(20) DEFAULT NULL COMMENT '账套编码',
  `start_period` varchar(7) DEFAULT NULL COMMENT '启用期间',
  `settle_period` varchar(7) DEFAULT NULL COMMENT '结账期间',
  `system_id` varchar(20) DEFAULT NULL COMMENT '会计制度id',
  `system_name` varchar(20) DEFAULT NULL COMMENT '会计制度名称',
  `classify` varchar(1) DEFAULT NULL COMMENT '是否重分类报表 0-不重分类 1-全部重分类 2-部分重分类',
  `currency_id` bigint(20) DEFAULT NULL COMMENT '本位币id',
  `profession_id` bigint(20) DEFAULT NULL COMMENT '行业id',
  `profession_name` varchar(128) DEFAULT NULL,
  `second_profession_id` bigint(20) DEFAULT NULL COMMENT '二级行业ID',
  `second_profession_name` varchar(128) DEFAULT NULL COMMENT '二级行业名称',
  `third_profession_id` bigint(20) DEFAULT NULL COMMENT '三级行业ID',
  `third_profession_name` varchar(128) DEFAULT NULL COMMENT '三级行业名称',
  `company_code` bigint(20) DEFAULT NULL COMMENT '企业编码',
  `company_name` varchar(20) DEFAULT NULL COMMENT '企业名称',
  `area_id` int(11) DEFAULT NULL,
  `tier` tinyint(4) DEFAULT NULL COMMENT '科目层级',
  `length` varchar(50) DEFAULT NULL COMMENT '科目长度',
  `tax_nature` varchar(255) DEFAULT NULL COMMENT '纳税性质： 001 一般纳税人，101 小规模纳税人',
  `resource` char(2) DEFAULT NULL COMMENT '账套来源(01-同步,02-导入,03-采集)',
  `is_default` tinyint(1) DEFAULT NULL COMMENT '是否默认(0-否，1-是)',
  `create_user` bigint(20) DEFAULT NULL COMMENT '最后操作人',
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=318 DEFAULT CHARSET=utf8 COMMENT='账套信息表';

-- ----------------------------
-- Table structure for risk_analyse_data
-- ----------------------------
DROP TABLE IF EXISTS `risk_analyse_data`;
CREATE TABLE `risk_analyse_data` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_set_id` bigint(20) DEFAULT NULL,
  `item` varchar(20) DEFAULT NULL COMMENT '模型数据项名称',
  `item_value` decimal(20,4) DEFAULT NULL COMMENT '模型数据项名称',
  `model_id` bigint(4) DEFAULT NULL,
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1299 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for risk_analyse_default_data
-- ----------------------------
DROP TABLE IF EXISTS `risk_analyse_default_data`;
CREATE TABLE `risk_analyse_default_data` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `model_id` bigint(20) DEFAULT NULL COMMENT '模型id',
  `company_code` bigint(20) DEFAULT NULL COMMENT '企业code',
  `company_name` varchar(100) DEFAULT NULL COMMENT '企业名称',
  `key_word` varchar(100) DEFAULT NULL COMMENT 'keyNo、公司名称、社会统一信用代码、注册号',
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='企业图谱默认数据';

-- ----------------------------
-- Table structure for risk_analyse_model
-- ----------------------------
DROP TABLE IF EXISTS `risk_analyse_model`;
CREATE TABLE `risk_analyse_model` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(20) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for risk_analyse_model_detail
-- ----------------------------
DROP TABLE IF EXISTS `risk_analyse_model_detail`;
CREATE TABLE `risk_analyse_model_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `model_id` bigint(20) DEFAULT NULL,
  `index_id` bigint(20) DEFAULT NULL,
  `seq` int(11) DEFAULT NULL,
  `low_standard` decimal(18,2) DEFAULT NULL,
  `hign_standard` decimal(18,2) DEFAULT NULL,
  `legend_name` varchar(20) DEFAULT NULL,
  `legend_type` tinyint(4) DEFAULT NULL COMMENT '1柱状图，2折线图',
  `chart_name` varchar(20) DEFAULT NULL COMMENT '图表名称',
  `chart_desc` varchar(255) DEFAULT NULL COMMENT '图标描述',
  `formula` text COMMENT '非指标公式',
  `chart_seq` int(11) DEFAULT NULL COMMENT '图排序',
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for risk_area
-- ----------------------------
DROP TABLE IF EXISTS `risk_area`;
CREATE TABLE `risk_area` (
  `id` bigint(20) NOT NULL,
  `code` varchar(12) NOT NULL,
  `name` varchar(128) NOT NULL,
  `level` int(10) DEFAULT NULL COMMENT '级别',
  `p_code` varchar(12) NOT NULL,
  `status` char(3) NOT NULL DEFAULT '1' COMMENT '1-正常；2-冻结；0-删除',
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_index` (`code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='K_XZQHID=’0‘ 表示中国\r\nK_SJXZQHID=’0‘ 表示省/直辖市';

-- ----------------------------
-- Table structure for risk_balance_item
-- ----------------------------
DROP TABLE IF EXISTS `risk_balance_item`;
CREATE TABLE `risk_balance_item` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `subject_code` varchar(25) DEFAULT NULL COMMENT '科目内码',
  `subject_name` varchar(50) DEFAULT NULL COMMENT '科目名称',
  `subject_full_name` varchar(50) DEFAULT NULL,
  `subject_abbreviation` varchar(256) DEFAULT NULL COMMENT '科目名称简称',
  `subject_direction` tinyint(4) DEFAULT NULL COMMENT '科目方向  1/-1',
  `subject_type` varchar(20) DEFAULT NULL COMMENT '科目类型：1.资产 2.负债 3.所有者权益 4.成本 5.损益',
  `account_system` bigint(20) DEFAULT NULL COMMENT '001企业会计准则2017版，002企业会计准则2007版，003小企业会计准则2013版',
  `subject_is_zero` tinyint(2) DEFAULT NULL COMMENT '是否0,1借方发生额,贷方发生额,3余额',
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_index` (`account_system`,`subject_code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=200226 DEFAULT CHARSET=utf8 COMMENT='科目余额字典表';

-- ----------------------------
-- Table structure for risk_basic_data_item
-- ----------------------------
DROP TABLE IF EXISTS `risk_basic_data_item`;
CREATE TABLE `risk_basic_data_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_set_id` bigint(20) DEFAULT NULL,
  `type_id` bigint(20) DEFAULT NULL,
  `platform_data_id` bigint(20) DEFAULT NULL,
  `code` varchar(20) DEFAULT NULL COMMENT '数据项编码',
  `name` varchar(20) DEFAULT NULL,
  `simple_name` varchar(20) DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `seq` int(10) DEFAULT NULL,
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33217 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for risk_basic_data_type
-- ----------------------------
DROP TABLE IF EXISTS `risk_basic_data_type`;
CREATE TABLE `risk_basic_data_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_set_id` bigint(20) DEFAULT NULL,
  `platform_type_id` bigint(20) DEFAULT NULL,
  `code` varchar(25) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL,
  `seq` int(10) DEFAULT NULL,
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3187 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for risk_bill_type
-- ----------------------------
DROP TABLE IF EXISTS `risk_bill_type`;
CREATE TABLE `risk_bill_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '发票ID',
  `code` varchar(30) NOT NULL COMMENT '发票类型英文名称',
  `value` int(11) NOT NULL COMMENT '发票类型值',
  `name` varchar(30) NOT NULL COMMENT '发票类型中文名称',
  `abbr` varchar(50) DEFAULT NULL COMMENT '发票类型中文简称',
  `seq` int(11) NOT NULL COMMENT '显示顺序',
  `direction` int(11) NOT NULL COMMENT '进销项类型',
  `valid` tinyint(1) NOT NULL COMMENT '是否启用',
  `create_user` bigint(20) DEFAULT NULL COMMENT '创建用户',
  `update_user` bigint(20) DEFAULT NULL COMMENT '更新用户',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `deleted` tinyint(1) DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='发票类型';

-- ----------------------------
-- Table structure for risk_check_batch
-- ----------------------------
DROP TABLE IF EXISTS `risk_check_batch`;
CREATE TABLE `risk_check_batch` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `company_code` bigint(20) DEFAULT NULL COMMENT '公司编号',
  `account_set_id` bigint(20) DEFAULT NULL COMMENT '账套ID',
  `report_id` bigint(20) DEFAULT NULL COMMENT '报告ID',
  `period` varchar(10) DEFAULT NULL COMMENT '体检会计期间',
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1938 DEFAULT CHARSET=utf8 COMMENT='检测批次表';

-- ----------------------------
-- Table structure for risk_collect_area_config
-- ----------------------------
DROP TABLE IF EXISTS `risk_collect_area_config`;
CREATE TABLE `risk_collect_area_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `province_id` int(5) DEFAULT NULL,
  `type` int(4) DEFAULT NULL COMMENT '采集类型:1税表采集',
  `status` int(4) DEFAULT NULL COMMENT '1.开通,0未开通',
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for risk_collect_config
-- ----------------------------
DROP TABLE IF EXISTS `risk_collect_config`;
CREATE TABLE `risk_collect_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `company_code` bigint(20) DEFAULT NULL COMMENT '企业码',
  `system_id` bigint(10) DEFAULT NULL COMMENT '会计准则ID(企业会计准则2017版->1,小企业会计准则2013版->3,企业会计制度->4)',
  `tax_nature` varchar(10) DEFAULT NULL COMMENT '纳税性质(001-一般纳税人,101-小规模纳税人)',
  `vat_declare_period` int(2) DEFAULT NULL COMMENT '增值税申报周期\r\n            1-月\r\n            2-季\r\n            3-半年\r\n            4-年\r\n            5-次',
  `finance_declare_period` int(2) DEFAULT NULL COMMENT '财务报表申报周期\r\n            1-月\r\n            2-季\r\n            3-半年\r\n            4-年\r\n            5-次\r\n            ',
  `collection_way` varchar(10) DEFAULT NULL COMMENT '征收方式\r\n            601-查账征收\r\n            602-核定征收(按收入总额)\r\n            603-核定征收(按成本费用)\r\n            604-核定所得率征收(按收入)\r\n            605-核定应税所得率征收\r\n            606-代扣代缴\r\n            607-自行申报\r\n            608-委托代征(含代售印花税票)\r\n            609-代收代缴',
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='采集设置表';

-- ----------------------------
-- Table structure for risk_collect_task
-- ----------------------------
DROP TABLE IF EXISTS `risk_collect_task`;
CREATE TABLE `risk_collect_task` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `company_code` bigint(20) DEFAULT NULL COMMENT '企业编码',
  `account_set_id` bigint(20) DEFAULT NULL COMMENT '账套id',
  `message_id` bigint(20) DEFAULT NULL COMMENT '数据采集信息版本信息id',
  `app_id` bigint(20) DEFAULT NULL COMMENT 'appId',
  `system_id` bigint(20) DEFAULT NULL COMMENT '会计准则',
  `group_id` bigint(20) DEFAULT NULL COMMENT '任务组id',
  `collection_way` varchar(20) DEFAULT NULL COMMENT '征收方式',
  `tax_mark` varchar(10) DEFAULT NULL COMMENT '国地税标志',
  `vat_declare_period` int(2) DEFAULT NULL COMMENT '增值税申报周期\r\n            1-月\r\n            2-季\r\n            3-半年\r\n            4-年\r\n            5-次',
  `finance_declare_period` int(2) DEFAULT NULL COMMENT '财务报表报送期限\r\n            1-月\r\n            2-季\r\n            3-半年\r\n            4-年\r\n            5-次',
  `end_period` varchar(20) DEFAULT NULL COMMENT '采集截止期间',
  `tax_status` int(2) DEFAULT NULL COMMENT '税种采集状态(0-采集中 1-成功 2-失败)',
  `type` int(2) NOT NULL DEFAULT '0' COMMENT '0: 纳税采集， 1：财务采集，2：发票采集，3：本地提取',
  `report_status` int(2) DEFAULT NULL COMMENT '财务报表采集状态(0-采集中 1-成功 2-失败)',
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='采集任务表';

-- ----------------------------
-- Table structure for risk_collect_task_item
-- ----------------------------
DROP TABLE IF EXISTS `risk_collect_task_item`;
CREATE TABLE `risk_collect_task_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` bigint(20) DEFAULT NULL COMMENT '任务组id',
  `task_id` bigint(20) DEFAULT NULL COMMENT '任务id',
  `company_code` bigint(20) DEFAULT NULL COMMENT '企业码',
  `period` varchar(20) DEFAULT NULL COMMENT '会计期间',
  `tax_id` bigint(20) DEFAULT NULL COMMENT '税种id',
  `tax_mark` varchar(10) DEFAULT NULL COMMENT '国地税标志',
  `tax_term` varchar(10) DEFAULT NULL COMMENT '纳税期限\r\n            1-月\r\n            2-季\r\n            3-半年\r\n            4-年\r\n            5-次\r\n            ',
  `divide` varchar(20) DEFAULT NULL COMMENT '行政区划',
  `report_type` int(10) DEFAULT NULL COMMENT '报表类型（1-税务报表 2-财务报表）',
  `status` int(2) DEFAULT NULL COMMENT '状态(0-采集中 1-成功 2-失败)',
  `result_code` varchar(10) DEFAULT NULL COMMENT '返回结果code',
  `result_message` text COMMENT '返回结果信息',
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='采集任务明细表';

-- ----------------------------
-- Table structure for risk_company
-- ----------------------------
DROP TABLE IF EXISTS `risk_company`;
CREATE TABLE `risk_company` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '企业码',
  `school_id` varchar(32) DEFAULT NULL COMMENT '学校ID',
  `user_id` varchar(32) DEFAULT NULL COMMENT '学生ID',
  `own_type` tinyint(2) DEFAULT NULL COMMENT '拥有者类型(0-学生)',
  `company_name` varchar(64) NOT NULL COMMENT '全称',
  `company_type` int(11) DEFAULT NULL,
  `profession_id` bigint(20) DEFAULT NULL COMMENT '行业id',
  `profession_name` varchar(20) DEFAULT NULL,
  `second_profession_id` bigint(20) DEFAULT NULL COMMENT '二级行业ID',
  `second_profession_name` varchar(20) DEFAULT NULL COMMENT '二级行业名称',
  `third_profession_id` bigint(20) DEFAULT NULL COMMENT '三级行业ID',
  `third_profession_name` varchar(20) DEFAULT NULL COMMENT '三级行业名称',
  `scales` int(11) DEFAULT NULL COMMENT '规模，枚举类型',
  `business_scope` varchar(1024) DEFAULT NULL COMMENT '经营范围',
  `province_id` bigint(20) DEFAULT NULL COMMENT '省id',
  `province_name` varchar(16) DEFAULT NULL COMMENT '省名称',
  `city_id` bigint(20) DEFAULT NULL COMMENT '市id',
  `city_name` varchar(16) DEFAULT NULL COMMENT '市名称',
  `area_id` bigint(20) DEFAULT NULL COMMENT '区id',
  `area_name` varchar(16) DEFAULT NULL COMMENT '区名称',
  `address` varchar(200) DEFAULT NULL COMMENT '详细地址',
  `taxlayer_type` varchar(20) DEFAULT NULL COMMENT '纳税人类型，001：一般纳税人，101：小规模纳税人',
  `taxlayer_no` varchar(32) DEFAULT '' COMMENT '纳税人识别号',
  `level` tinyint(2) DEFAULT '0' COMMENT '纳税人信用等级',
  `create_user` bigint(20) DEFAULT NULL COMMENT '最后操作人',
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=652187675130216820 DEFAULT CHARSET=utf8 COMMENT='企业信息表';

-- ----------------------------
-- Table structure for risk_company_details
-- ----------------------------
DROP TABLE IF EXISTS `risk_company_details`;
CREATE TABLE `risk_company_details` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `key_word` varchar(100) DEFAULT NULL COMMENT 'keyNo、公司名称、社会统一信用代码、注册号',
  `name` varchar(100) DEFAULT NULL COMMENT '公司名称',
  `key_no` varchar(35) DEFAULT NULL COMMENT '内部KeyNo',
  `no` varchar(20) DEFAULT NULL COMMENT '注册号',
  `belong_org` varchar(50) DEFAULT NULL COMMENT '登记机关',
  `oper_name` varchar(50) DEFAULT NULL COMMENT '法人名',
  `start_date` varchar(20) DEFAULT NULL COMMENT '成立日期',
  `end_date` varchar(20) DEFAULT NULL COMMENT '吊销日期',
  `status` varchar(20) DEFAULT NULL COMMENT '企业状态',
  `province` varchar(20) DEFAULT NULL COMMENT '省份',
  `updated_date` varchar(20) DEFAULT NULL COMMENT '更新日期',
  `credit_code` varchar(20) DEFAULT NULL COMMENT '社会统一信用代码',
  `regist_capi` varchar(20) DEFAULT NULL COMMENT '注册资本',
  `econ_kind` varchar(50) DEFAULT NULL COMMENT '企业类型',
  `address` varchar(255) DEFAULT NULL COMMENT '地址',
  `scope` text COMMENT '经营范围',
  `term_start` varchar(20) DEFAULT NULL COMMENT '营业开始日期',
  `team_end` varchar(20) DEFAULT NULL COMMENT '营业结束日期',
  `check_date` varchar(20) DEFAULT NULL COMMENT '发照日期',
  `org_no` varchar(20) DEFAULT NULL COMMENT '组织机构代码',
  `is_on_stock` varchar(1) DEFAULT NULL COMMENT '是否IPO上市(0为未上市，1为上市)',
  `stock_number` varchar(20) DEFAULT NULL COMMENT '上市公司代码',
  `stock_type` varchar(20) DEFAULT NULL COMMENT '上市类型',
  `image_url` varchar(255) DEFAULT NULL COMMENT '企业Logo',
  `ent_type` varchar(2) DEFAULT NULL COMMENT '企业类型，0-公司，1-社会组织 ，3-香港公司，4政府机构，5-台湾公司，6-基金会，7-医院，8-海外公司，9-律师事务所，10-学校 ，-1-其他',
  `rec_cap` varchar(20) DEFAULT NULL COMMENT '实缴资本',
  `insured_count` varchar(20) DEFAULT NULL COMMENT '参保人数',
  `english_name` varchar(255) DEFAULT NULL COMMENT '英文名',
  `person_scope` varchar(20) DEFAULT NULL COMMENT '人员规模',
  `original_name` text COMMENT '曾用名',
  `partners` text COMMENT '股东信息',
  `employees` text COMMENT '主要人员',
  `branches` longtext COMMENT '分支机构',
  `change_records` longtext COMMENT '变更记录',
  `contact_info` text COMMENT '联系信息',
  `industry` text COMMENT '行业信息',
  `area` text COMMENT '区域信息',
  `investment` text COMMENT '对外投资',
  `historyt_share_holder` text COMMENT '历史股东',
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`),
  UNIQUE KEY `key_word` (`key_word`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='企业信息明细表';

-- ----------------------------
-- Table structure for risk_company_index
-- ----------------------------
DROP TABLE IF EXISTS `risk_company_index`;
CREATE TABLE `risk_company_index` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `account_set_id` bigint(20) DEFAULT NULL COMMENT '账套id',
  `platform_index_id` bigint(20) DEFAULT NULL COMMENT '模板指标id',
  `code` varchar(20) DEFAULT NULL COMMENT '编码',
  `type_id` int(4) DEFAULT NULL,
  `type_name` varchar(20) DEFAULT NULL COMMENT '指标分类名称',
  `name` varchar(50) DEFAULT NULL COMMENT '指标名称',
  `simple_name` varchar(50) DEFAULT NULL COMMENT '指标简码',
  `expression` varchar(512) DEFAULT NULL,
  `formula` text COMMENT '计算公式',
  `description` text,
  `suggest` text,
  `exp1` varchar(256) DEFAULT NULL,
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10429 DEFAULT CHARSET=utf8 COMMENT='企业指标表';

-- ----------------------------
-- Table structure for risk_company_index_range
-- ----------------------------
DROP TABLE IF EXISTS `risk_company_index_range`;
CREATE TABLE `risk_company_index_range` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `account_set_id` bigint(20) DEFAULT NULL COMMENT '账套id',
  `index_id` bigint(20) DEFAULT NULL COMMENT '指标Id',
  `profession_id` bigint(20) DEFAULT NULL COMMENT '企业行业ID',
  `profession_name` varchar(50) DEFAULT NULL COMMENT '企业行业名称',
  `range_low` varchar(256) DEFAULT NULL COMMENT '存在风险',
  `range_low_formula` text COMMENT '存在风险公式',
  `range_high` varchar(256) DEFAULT NULL COMMENT '高等风险',
  `range_high_formula` text COMMENT '高等风险公式',
  `range_top` varchar(256) DEFAULT NULL COMMENT '极度危险',
  `range_top_formula` text COMMENT '极度危险公式',
  `range_1` varchar(256) DEFAULT NULL COMMENT '风险区间备用字段1',
  `range_2` varchar(256) DEFAULT NULL COMMENT '风险区间备用字段2',
  `range_3` varchar(256) DEFAULT NULL COMMENT '风险区间备用字段3',
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10429 DEFAULT CHARSET=utf8 COMMENT='企业指标阈值表';

-- ----------------------------
-- Table structure for risk_company_index_ticket
-- ----------------------------
DROP TABLE IF EXISTS `risk_company_index_ticket`;
CREATE TABLE `risk_company_index_ticket` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `company_code` bigint(20) DEFAULT NULL COMMENT '公司编号',
  `index_id` bigint(20) DEFAULT NULL COMMENT '指标编号',
  `company_problem_id` bigint(20) DEFAULT NULL COMMENT '公司涉及问题id',
  `period` varchar(10) DEFAULT NULL COMMENT '期间',
  `ticket_id` varchar(20) DEFAULT NULL,
  `ticket_type` int(1) DEFAULT NULL COMMENT '单据类型 3:发票',
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 COMMENT='平台指标单据关联表';

-- ----------------------------
-- Table structure for risk_company_modify_record
-- ----------------------------
DROP TABLE IF EXISTS `risk_company_modify_record`;
CREATE TABLE `risk_company_modify_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `company_code` bigint(20) DEFAULT NULL COMMENT '企业码',
  `before_data` varchar(512) DEFAULT NULL COMMENT '修改前的数据',
  `modify_data` varchar(512) DEFAULT NULL COMMENT '修改的数据',
  `has_core_data` tinyint(1) DEFAULT NULL COMMENT '是否包含关键数据修改(0-否,1-是)',
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`),
  KEY `nor_index` (`company_code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8 COMMENT='企业信息修改记录';

-- ----------------------------
-- Table structure for risk_company_problem
-- ----------------------------
DROP TABLE IF EXISTS `risk_company_problem`;
CREATE TABLE `risk_company_problem` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `company_code` bigint(20) DEFAULT NULL COMMENT '公司编号',
  `problem_id` bigint(20) DEFAULT NULL COMMENT '问题编号',
  `problem_title` varchar(512) DEFAULT NULL COMMENT '问题标题',
  `problem_type` int(1) DEFAULT '0' COMMENT '问题类型',
  `period` varchar(10) DEFAULT NULL COMMENT '期间',
  `batch_id` bigint(20) DEFAULT NULL COMMENT '批次ID',
  `status` int(1) DEFAULT NULL COMMENT '涉及问题状态 0:未涉及,1:待处理,2:已处理,3:已忽略',
  `seq` varchar(40) DEFAULT NULL COMMENT '序号',
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='公司涉及问题表';

-- ----------------------------
-- Table structure for risk_company_problem_settle_log
-- ----------------------------
DROP TABLE IF EXISTS `risk_company_problem_settle_log`;
CREATE TABLE `risk_company_problem_settle_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `company_code` bigint(20) DEFAULT NULL COMMENT '公司编号',
  `company_problem_id` bigint(20) DEFAULT NULL COMMENT '涉及问题编号',
  `user_id` bigint(20) DEFAULT NULL COMMENT '解决问题用户id',
  `user_name` varchar(56) DEFAULT NULL COMMENT '解决问题用户名称',
  `head_portrait` varchar(512) DEFAULT NULL COMMENT '解决问题用户头像',
  `settle_way` varchar(512) DEFAULT NULL COMMENT '解决方式',
  `status` int(1) DEFAULT NULL COMMENT '涉及问题解决状态 0:未涉及,1:待处理,2:已解决,3:已忽略',
  `log_type` int(1) DEFAULT NULL COMMENT '日志类型 1:添加了此问题 2：处理了此问题 3：忽略了此问题  4：添加评论 5：移动了此问题，6：分配了此问题，7：变更了此问题用户，8：此问题移除了分配用户',
  `create_user_name` varchar(56) DEFAULT NULL COMMENT '创建人用户名',
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COMMENT='公司涉及问题解决日志表';

-- ----------------------------
-- Table structure for risk_company_problem_user
-- ----------------------------
DROP TABLE IF EXISTS `risk_company_problem_user`;
CREATE TABLE `risk_company_problem_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `company_code` bigint(20) DEFAULT NULL COMMENT '公司编号',
  `company_problem_id` bigint(20) DEFAULT NULL COMMENT '涉及问题编号',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户编号',
  `user_name` varchar(56) DEFAULT NULL COMMENT '用户姓名',
  `head_portrait` varchar(512) DEFAULT NULL COMMENT '用户头像',
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `problem_level` int(1) DEFAULT NULL COMMENT '优先级 3较低2普通1紧急0非常紧急',
  `end_time` varchar(10) DEFAULT NULL COMMENT '截止时间',
  `finish` int(1) DEFAULT '0' COMMENT '是否完成 0-未完成 1-已完成',
  `finish_time` datetime DEFAULT NULL COMMENT '完成时间',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='公司涉及问题分配用户表';

-- ----------------------------
-- Table structure for risk_company_warn
-- ----------------------------
DROP TABLE IF EXISTS `risk_company_warn`;
CREATE TABLE `risk_company_warn` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_set_id` bigint(20) DEFAULT NULL,
  `platform_warn_id` bigint(20) DEFAULT NULL,
  `type_id` bigint(20) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `simple_name` varchar(50) DEFAULT NULL,
  `index_id` bigint(20) DEFAULT NULL,
  `range_low` varchar(256) DEFAULT NULL,
  `range_low_formula` text COMMENT '存在风险公式',
  `range_high` varchar(256) DEFAULT NULL,
  `range_high_formula` text COMMENT '高等风险公式',
  `range_top` varchar(256) DEFAULT NULL,
  `range_top_formula` text COMMENT '极度危险公式',
  `enabled` tinyint(1) DEFAULT NULL COMMENT '0-禁用，1-启用',
  `warn_level` int(2) DEFAULT NULL COMMENT '0-相对安全       1-存在风险\r\n            2-高等风险\r\n            3-极度危险',
  `description` text,
  `suggest` text,
  `exp1` varchar(256) DEFAULT NULL,
  `exp2` varchar(256) DEFAULT NULL,
  `exp3` varchar(256) DEFAULT NULL,
  `condition` tinyint(1) DEFAULT NULL COMMENT '预警条件：1-自定义     2-引用指标阈值',
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10429 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for risk_data_balance
-- ----------------------------
DROP TABLE IF EXISTS `risk_data_balance`;
CREATE TABLE `risk_data_balance` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_set_id` bigint(20) DEFAULT NULL,
  `period` varchar(20) DEFAULT NULL,
  `subject_id` bigint(20) DEFAULT NULL COMMENT '科目ID',
  `subject_code` varchar(50) DEFAULT NULL,
  `super_code` varchar(50) DEFAULT NULL COMMENT '上级科目代码',
  `subject_name` varchar(255) DEFAULT NULL,
  `subject_full_name` varchar(255) DEFAULT NULL,
  `subject_inner_code` varchar(25) DEFAULT NULL COMMENT '科目内码',
  `subject_inner_name` varchar(255) DEFAULT NULL COMMENT '科目内部名称',
  `debit_value` decimal(20,2) DEFAULT NULL COMMENT '借方发生额',
  `credit_value` decimal(20,2) DEFAULT NULL COMMENT '贷方发生额',
  `balance_value` decimal(20,2) DEFAULT NULL COMMENT '余额',
  `subject_dir` tinyint(4) DEFAULT NULL,
  `end_level` tinyint(4) DEFAULT NULL COMMENT '是否末级科目',
  `source_id` bigint(20) DEFAULT NULL COMMENT '数据源ID',
  `is_auxiliary` tinyint(4) DEFAULT NULL COMMENT '是否辅助核算(0-否,1-是)',
  `subject_source_id` bigint(20) DEFAULT NULL,
  `customer` varchar(50) DEFAULT NULL COMMENT '客户辅助核算',
  `customer_number` varchar(50) DEFAULT NULL COMMENT '客户辅助核算编号',
  `supplier` varchar(50) DEFAULT NULL COMMENT '供应商辅助核算',
  `supplier_number` varchar(50) DEFAULT NULL COMMENT '供应商辅助核算编号',
  `person` varchar(50) DEFAULT NULL COMMENT '人员辅助核算',
  `person_number` varchar(50) DEFAULT NULL COMMENT '人员辅助核算编号',
  `project` varchar(50) DEFAULT NULL COMMENT '项目辅助核算',
  `project_number` varchar(50) DEFAULT NULL COMMENT '项目辅助核算编号',
  `department` varchar(50) DEFAULT NULL COMMENT '部门辅助核算',
  `department_number` varchar(50) DEFAULT NULL COMMENT '部门辅助核算编号',
  `inventory` varchar(50) DEFAULT NULL COMMENT '存货辅助核算',
  `inventory_number` varchar(50) DEFAULT NULL COMMENT '存货辅助核算编号',
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index1` (`account_set_id`,`period`,`subject_inner_code`) USING BTREE,
  KEY `index2` (`account_set_id`,`period`,`subject_inner_name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=43974 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for risk_data_bill_detail
-- ----------------------------
DROP TABLE IF EXISTS `risk_data_bill_detail`;
CREATE TABLE `risk_data_bill_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '发票明细ID',
  `company_code` bigint(20) NOT NULL COMMENT '企业ID',
  `bill_number` varchar(20) NOT NULL COMMENT '发票号码',
  `name` varchar(150) DEFAULT NULL COMMENT '货物或应税劳务名称，普票卷票【项目】',
  `model_number` varchar(50) DEFAULT NULL COMMENT '规格型号，普票卷票【项目】普票通行费【车牌号】',
  `model_unit` varchar(50) DEFAULT NULL COMMENT '单位，普票卷票【null】普票通行费【类型】',
  `model_count` decimal(20,2) DEFAULT NULL COMMENT '数量，普票卷票【数量】',
  `model_price` decimal(20,2) DEFAULT NULL COMMENT '单价，普票卷票【单价】',
  `bill_price` decimal(20,2) DEFAULT NULL COMMENT '金额，普票卷票【金额】',
  `tax_rate` decimal(20,2) DEFAULT NULL COMMENT '税率，普票卷票【税率】',
  `bill_tax_value` decimal(20,2) DEFAULT NULL COMMENT '税额，普票卷票【税额】',
  `pass_start_date` varchar(20) DEFAULT NULL COMMENT '通行日期起，普票【通行费】',
  `pass_end_date` varchar(20) DEFAULT NULL COMMENT '通行日期止，普票【通行费】',
  `seq` int(11) DEFAULT NULL COMMENT '序号',
  `create_user` bigint(20) DEFAULT NULL COMMENT '创建用户',
  `update_user` bigint(20) DEFAULT NULL COMMENT '更新用户',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `deleted` tinyint(1) DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 COMMENT='发票详情';

-- ----------------------------
-- Table structure for risk_data_bill_index
-- ----------------------------
DROP TABLE IF EXISTS `risk_data_bill_index`;
CREATE TABLE `risk_data_bill_index` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '发票ID',
  `company_code` bigint(20) NOT NULL COMMENT '企业ID',
  `period` varchar(10) NOT NULL COMMENT '期间',
  `bill_date` varchar(10) NOT NULL COMMENT '开票日期',
  `bill_code` varchar(50) NOT NULL COMMENT '发票代码',
  `bill_number` varchar(50) NOT NULL COMMENT '发票号码',
  `bill_type` tinyint(2) NOT NULL COMMENT '发票类型',
  `direction` tinyint(1) NOT NULL COMMENT '进销项类型, -1: 进销项, 0: 进项, 1: 销项',
  `bill_tax_price` decimal(20,2) DEFAULT NULL COMMENT '价税合计',
  `bill_no_tax_value` decimal(20,2) DEFAULT NULL COMMENT '不含税金额',
  `bill_tax_value` decimal(20,2) DEFAULT NULL COMMENT '税额',
  `buy_name` varchar(50) DEFAULT NULL COMMENT '购货单位名称',
  `buy_taxpayer_number` varchar(50) DEFAULT NULL COMMENT '购货单位纳税人识别号',
  `buy_address` varchar(256) DEFAULT NULL COMMENT '购货单位地址',
  `buy_telephone` varchar(50) DEFAULT NULL COMMENT '购货单位电话',
  `buy_bank` varchar(256) DEFAULT NULL COMMENT '购货单位银行账号',
  `buy_addr_and_tel` varchar(256) DEFAULT NULL,
  `buy_bank_address` varchar(256) DEFAULT NULL COMMENT '购货单位开户行地址',
  `buy_bank_addr_and_account` varchar(256) DEFAULT NULL,
  `sell_name` varchar(50) DEFAULT NULL COMMENT '销货单位名称',
  `sell_taxpayer_number` varchar(50) DEFAULT NULL COMMENT '销货单位纳税人识别号',
  `sell_address` varchar(256) DEFAULT NULL COMMENT '销货单位地址',
  `sell_telephone` varchar(50) DEFAULT NULL COMMENT '销货单位电话',
  `sell_bank` varchar(256) DEFAULT NULL COMMENT '销货单位银行账号',
  `sell_addr_and_tel` varchar(256) DEFAULT NULL COMMENT '销货单位地址电话',
  `sell_bank_address` varchar(256) DEFAULT NULL COMMENT '销货单位开户行地址',
  `sell_bank_addr_and_account` varchar(256) DEFAULT NULL COMMENT '销货单位开户行地址账号',
  `bill_source` tinyint(1) NOT NULL COMMENT '发票来源1:导入 2:采集(税局) 3:本地提取 4:采集(认证平台)',
  `make_type` tinyint(1) DEFAULT NULL COMMENT '开票类型(开票类型(0自开,1代开))',
  `remark` varchar(256) DEFAULT NULL COMMENT '备注',
  `detail_status` tinyint(1) DEFAULT NULL COMMENT '详情状态(0:不支持,1:支持未获取或获取失败,2:支持已获取）',
  `bill_status` tinyint(1) DEFAULT NULL COMMENT '发票状态：0:正常,1:作废,2:红冲,3:认证,4:抵扣',
  `status_of_certification` varchar(2) DEFAULT NULL COMMENT '认证状态: 0 已认证, 1 未认证',
  `date_of_certification_date` varchar(10) DEFAULT NULL COMMENT '认证时间',
  `status_of_deduction` varchar(2) DEFAULT NULL COMMENT '抵扣状态: 0 已抵扣, 1 未抵扣, 2 不可抵扣',
  `date_of_deduction` varchar(10) DEFAULT NULL COMMENT '抵扣时间',
  `methon_of_deduction` varchar(2) DEFAULT NULL COMMENT '抵扣方式: 0 一般项目, 1 即征即退',
  `collection_method` varchar(2) DEFAULT NULL COMMENT '征收方式',
  `number_of_attachment` int(10) DEFAULT NULL COMMENT '附件数',
  `agricultural_invoice` varchar(2) DEFAULT NULL COMMENT '是否农产品: 0: 不是, 1: 是',
  `agricultural_product_business_type` varchar(2) DEFAULT NULL COMMENT '农产品业务类型: 0 非生加工, 1 原材料, 2 委托加工物资',
  `other_message` text COMMENT '扩展属性：1.国税通用机打发票:行业分类，机打代码，机打号码，机器编号，税控码\r\n            2.增值税普票卷票:机打号码，机器编号，收银员\r\n            机动车销售统一发票，二手车统一销售发票按票面冗余。',
  `cr_result` varchar(11) DEFAULT NULL COMMENT '长软返回状态码',
  `check_code` varchar(50) DEFAULT NULL COMMENT '效验码',
  `create_user` bigint(20) DEFAULT NULL COMMENT '创建用户',
  `update_user` bigint(20) DEFAULT NULL COMMENT '更新用户',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `deleted` tinyint(1) DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8 COMMENT='发票总表';

-- ----------------------------
-- Table structure for risk_data_mapper
-- ----------------------------
DROP TABLE IF EXISTS `risk_data_mapper`;
CREATE TABLE `risk_data_mapper` (
  `id` bigint(20) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `mapper_name` varchar(50) DEFAULT NULL,
  `report_id` int(4) DEFAULT NULL COMMENT '二级类别编号',
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for risk_data_personnel
-- ----------------------------
DROP TABLE IF EXISTS `risk_data_personnel`;
CREATE TABLE `risk_data_personnel` (
  `id` bigint(20) NOT NULL,
  `account_set_id` bigint(20) DEFAULT NULL,
  `personnel_name` varchar(20) DEFAULT NULL,
  `personnel_id_type` varchar(20) DEFAULT NULL,
  `personnel_id_number` varchar(20) DEFAULT NULL,
  `personnel_status` int(2) DEFAULT NULL COMMENT '0-删除 1-正常',
  `nationality` varchar(20) DEFAULT NULL,
  `phone_number` bigint(20) DEFAULT NULL,
  `employee` varchar(20) DEFAULT NULL,
  `entry_time` datetime DEFAULT NULL,
  `departure_time` datetime DEFAULT NULL,
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for risk_data_personnel_status
-- ----------------------------
DROP TABLE IF EXISTS `risk_data_personnel_status`;
CREATE TABLE `risk_data_personnel_status` (
  `personnel_status_id` bigint(20) NOT NULL COMMENT '人员状态id',
  `personnel_id` bigint(20) NOT NULL COMMENT '人员id',
  `period` varchar(20) NOT NULL,
  `status` int(1) NOT NULL COMMENT '人员状态(1正常2非正常)',
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `deleted` int(1) DEFAULT NULL,
  PRIMARY KEY (`personnel_status_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='人员状态表';

-- ----------------------------
-- Table structure for risk_data_report
-- ----------------------------
DROP TABLE IF EXISTS `risk_data_report`;
CREATE TABLE `risk_data_report` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_set_id` bigint(20) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `value` decimal(18,2) DEFAULT '0.00' COMMENT '值',
  `report_id` int(4) DEFAULT NULL,
  `period` varchar(20) DEFAULT NULL,
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`),
  KEY `index1` (`account_set_id`,`report_id`,`period`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=25480 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for risk_data_report_annual
-- ----------------------------
DROP TABLE IF EXISTS `risk_data_report_annual`;
CREATE TABLE `risk_data_report_annual` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_set_id` bigint(20) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `report_id` int(4) DEFAULT NULL,
  `period` varchar(20) DEFAULT NULL,
  `value` varchar(50) DEFAULT NULL,
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`),
  KEY `index1` (`account_set_id`,`report_id`,`period`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='汇算清缴报表数据';

-- ----------------------------
-- Table structure for risk_data_salary
-- ----------------------------
DROP TABLE IF EXISTS `risk_data_salary`;
CREATE TABLE `risk_data_salary` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `account_set_id` bigint(20) DEFAULT NULL COMMENT '账套代码',
  `period` varchar(20) DEFAULT NULL COMMENT '期间',
  `personnel_id` bigint(20) DEFAULT NULL COMMENT '人员id',
  `income` decimal(18,2) DEFAULT NULL COMMENT '收入额',
  `personal_income_tax` decimal(18,2) DEFAULT NULL COMMENT '个税税额',
  `salary` decimal(18,2) DEFAULT NULL COMMENT '实发金额',
  `reduce_tax_income` decimal(18,2) DEFAULT NULL COMMENT '减免税额',
  `duty_free_income` decimal(18,2) DEFAULT NULL COMMENT '免税所得',
  `tax` decimal(18,2) DEFAULT NULL COMMENT '允许扣除的税费',
  `pension` decimal(18,2) DEFAULT NULL COMMENT '年金',
  `other_deductions` decimal(18,2) DEFAULT NULL COMMENT '其他扣除',
  `commercial_health_insurance` decimal(18,2) DEFAULT NULL COMMENT '商业健康保险',
  `housing_provident_fund` decimal(18,2) DEFAULT NULL COMMENT '住房公积金',
  `unemployment_insurance` decimal(18,2) DEFAULT NULL COMMENT '失业保险',
  `medical_insurance` decimal(18,2) DEFAULT NULL COMMENT '基本医疗保险',
  `old_age_insurance` decimal(18,2) DEFAULT NULL COMMENT '基本养老保险',
  `quick_calculation_deduction` decimal(18,2) DEFAULT NULL COMMENT '速算扣除数',
  `tax_rate` decimal(18,2) DEFAULT NULL COMMENT '税率',
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='工资-正常薪金明细';

-- ----------------------------
-- Table structure for risk_data_subject
-- ----------------------------
DROP TABLE IF EXISTS `risk_data_subject`;
CREATE TABLE `risk_data_subject` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_set_id` bigint(20) DEFAULT NULL,
  `annual_period` int(4) DEFAULT NULL,
  `subject_code` varchar(50) DEFAULT NULL COMMENT '业务科目内码',
  `subject_inner_code` varchar(25) DEFAULT NULL COMMENT '匹配科目编码',
  `subject_inner_name` varchar(255) DEFAULT NULL COMMENT '匹配科目名称',
  `super_code` varchar(50) DEFAULT NULL COMMENT '业务科目上级内码',
  `subject_name` varchar(255) DEFAULT NULL,
  `subject_full_name` varchar(255) DEFAULT NULL,
  `subject_type` varchar(10) DEFAULT NULL COMMENT '科目类型',
  `subject_dir` tinyint(1) DEFAULT NULL COMMENT '定义\r\n                        -1-贷方,1-借方',
  `subject_level` tinyint(1) DEFAULT NULL COMMENT '当前科目层级',
  `end_level` tinyint(4) DEFAULT NULL COMMENT '定义\r\n(0-否，1-是)',
  `is_enable_mapping` tinyint(1) DEFAULT NULL COMMENT '是否使用科目信息',
  `is_auxiliary` tinyint(1) DEFAULT '0' COMMENT '定义(0-否,1-是)',
  `source_id` bigint(20) DEFAULT NULL,
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(4) DEFAULT '0' COMMENT '是否删除(0-否,1-是)',
  PRIMARY KEY (`id`),
  KEY `nor_index` (`account_set_id`,`subject_code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6726 DEFAULT CHARSET=utf8 COMMENT='科目信息表';

-- ----------------------------
-- Table structure for risk_data_subject_auxiliary
-- ----------------------------
DROP TABLE IF EXISTS `risk_data_subject_auxiliary`;
CREATE TABLE `risk_data_subject_auxiliary` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_set_id` bigint(20) DEFAULT NULL COMMENT '账套ID',
  `subject_id` bigint(20) DEFAULT NULL,
  `customer` varchar(50) DEFAULT NULL,
  `supplier` varchar(50) DEFAULT NULL,
  `person` varchar(50) DEFAULT NULL,
  `project` varchar(50) DEFAULT NULL,
  `department` varchar(50) DEFAULT NULL,
  `inventory` varchar(50) DEFAULT NULL,
  `customer_number` varchar(50) DEFAULT NULL,
  `supplier_number` varchar(50) DEFAULT NULL,
  `person_number` varchar(50) DEFAULT NULL,
  `project_number` varchar(50) DEFAULT NULL,
  `department_number` varchar(50) DEFAULT NULL,
  `inventory_number` varchar(50) DEFAULT NULL,
  `source_id` bigint(20) DEFAULT NULL,
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(4) DEFAULT '0' COMMENT '是否删除(0-否,1-是)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for risk_data_sync_last
-- ----------------------------
DROP TABLE IF EXISTS `risk_data_sync_last`;
CREATE TABLE `risk_data_sync_last` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_set_id` bigint(20) DEFAULT NULL,
  `period` char(7) DEFAULT NULL COMMENT '期间',
  `type` char(3) DEFAULT NULL COMMENT '数据类型定义(001-账套,002-科目余额, 003-凭证,004-报表)',
  `type_desc` varchar(25) DEFAULT NULL COMMENT '类型描述',
  `last_version` varchar(25) DEFAULT NULL COMMENT '最后同步数据版本',
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='数据同步最近记录表';

-- ----------------------------
-- Table structure for risk_data_tax_report
-- ----------------------------
DROP TABLE IF EXISTS `risk_data_tax_report`;
CREATE TABLE `risk_data_tax_report` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `company_code` bigint(20) DEFAULT NULL COMMENT '企业编码',
  `tax_id` bigint(20) DEFAULT NULL COMMENT '申报税种id',
  `box_id` bigint(20) DEFAULT NULL COMMENT '报表模板id',
  `period` varchar(10) DEFAULT NULL COMMENT '会计期间',
  `report_name` varchar(50) DEFAULT NULL,
  `sheet_name` varchar(50) DEFAULT NULL COMMENT 'sheet名称',
  `name` varchar(50) DEFAULT NULL COMMENT '数据名',
  `value` varchar(255) DEFAULT NULL COMMENT '金额的话，单位分',
  `rpt_name` varchar(50) DEFAULT NULL COMMENT '数据全名',
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='采集报表数据';

-- ----------------------------
-- Table structure for risk_data_voucher
-- ----------------------------
DROP TABLE IF EXISTS `risk_data_voucher`;
CREATE TABLE `risk_data_voucher` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_set_id` bigint(20) DEFAULT NULL,
  `subject_id` bigint(20) DEFAULT NULL COMMENT '科目ID',
  `subject_code` varchar(50) DEFAULT NULL COMMENT '科目编号',
  `subject_name` varchar(255) DEFAULT NULL COMMENT '科目名称',
  `subject_full_name` text,
  `subject_inner_code` varchar(25) DEFAULT NULL COMMENT '科目内码',
  `subject_inner_name` varchar(255) DEFAULT NULL COMMENT '科目内部名称',
  `subject_source_id` bigint(20) DEFAULT NULL,
  `voucher_status` tinyint(1) DEFAULT NULL COMMENT '1.未审核，2已审核',
  `voucher_type` varchar(5) DEFAULT NULL COMMENT '记',
  `voucher_type_id` bigint(20) DEFAULT NULL COMMENT '记-1',
  `voucher_time` varchar(20) DEFAULT NULL COMMENT '日期',
  `summary` text COMMENT '摘要',
  `period` varchar(10) DEFAULT NULL COMMENT '期间',
  `file_num` int(4) DEFAULT NULL COMMENT '附件数',
  `voucher_price` decimal(30,6) DEFAULT NULL COMMENT '凭证总金额（废）',
  `debit_value` decimal(30,6) DEFAULT NULL COMMENT '借方金额',
  `credit_value` decimal(30,6) DEFAULT NULL COMMENT '贷方金额',
  `source_detail_id` bigint(20) DEFAULT NULL COMMENT '数据源凭证明细ID',
  `voucher_sources_id` varchar(50) DEFAULT NULL COMMENT '数据源凭证ID',
  `customer` varchar(50) DEFAULT NULL COMMENT '客户辅助核算',
  `supplier` varchar(50) DEFAULT NULL COMMENT '供应商辅助核算',
  `person` varchar(50) DEFAULT NULL COMMENT '人员辅助核算',
  `project` varchar(50) DEFAULT NULL COMMENT '项目辅助核算',
  `department` varchar(50) DEFAULT NULL COMMENT '部门辅助核算',
  `inventory` varchar(50) DEFAULT NULL COMMENT '存货辅助核算',
  `resource` varchar(4) DEFAULT NULL,
  `create_user_name` varchar(20) DEFAULT NULL,
  `audit_user_name` varchar(20) DEFAULT NULL,
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`),
  KEY `index1` (`account_set_id`,`period`,`subject_code`) USING BTREE,
  KEY `index2` (`account_set_id`,`period`,`subject_inner_code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=36597 DEFAULT CHARSET=utf8 COMMENT='凭证数据表';

-- ----------------------------
-- Table structure for risk_domain
-- ----------------------------
DROP TABLE IF EXISTS `risk_domain`;
CREATE TABLE `risk_domain` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `environ` varchar(20) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `code` varchar(20) DEFAULT NULL,
  `domain` varchar(255) DEFAULT NULL,
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='域名表';

-- ----------------------------
-- Table structure for risk_dwd_finance
-- ----------------------------
DROP TABLE IF EXISTS `risk_dwd_finance`;
CREATE TABLE `risk_dwd_finance` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `company_code` bigint(20) NOT NULL COMMENT '企业编码',
  `account_set_id` bigint(20) DEFAULT NULL COMMENT '本账套id',
  `source_set_id` varchar(36) NOT NULL COMMENT '来源的账套id',
  `message_id` bigint(20) NOT NULL COMMENT '消息唯一标识',
  `soft_id` bigint(20) DEFAULT NULL COMMENT '第三方软件id',
  `content` longtext NOT NULL COMMENT '存储的内容',
  `type` smallint(2) NOT NULL DEFAULT '1' COMMENT '临时存储的类型，1：科目余额表；2：凭证；3：账套',
  `create_user` bigint(20) DEFAULT NULL COMMENT '创建用户',
  `update_user` bigint(20) DEFAULT NULL COMMENT '更新用户',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `deleted` tinyint(1) DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`),
  KEY `idx_company_code_message_id` (`company_code`,`message_id`) USING BTREE COMMENT '公司编码、消息id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for risk_group_analyse_data
-- ----------------------------
DROP TABLE IF EXISTS `risk_group_analyse_data`;
CREATE TABLE `risk_group_analyse_data` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_set_id` bigint(20) DEFAULT NULL,
  `model_id` bigint(4) DEFAULT NULL,
  `item` varchar(20) DEFAULT NULL COMMENT '模型数据项名称',
  `item_value` decimal(20,4) DEFAULT NULL COMMENT '模型数据项名称',
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='集团模型视图数据';

-- ----------------------------
-- Table structure for risk_habit_config
-- ----------------------------
DROP TABLE IF EXISTS `risk_habit_config`;
CREATE TABLE `risk_habit_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_set_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `module_code` varchar(10) DEFAULT NULL COMMENT '定义\r\n            REPORT(报表)',
  `habit_code` varchar(25) DEFAULT NULL COMMENT '定义\r\n            下拉(SELECT)',
  `habit_value` varchar(10) DEFAULT NULL,
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for risk_import_status
-- ----------------------------
DROP TABLE IF EXISTS `risk_import_status`;
CREATE TABLE `risk_import_status` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `company_code` bigint(20) DEFAULT NULL COMMENT '企业码',
  `account_set_id` bigint(20) DEFAULT NULL,
  `import_type` tinyint(4) DEFAULT NULL COMMENT '1.余额数据，2期初，3凭证',
  `import_status` tinyint(4) DEFAULT NULL COMMENT '0未导入 1导入中 2导入成功 3导入失败',
  `import_count` bigint(4) DEFAULT NULL,
  `file_key` varchar(100) DEFAULT NULL,
  `import_message` mediumtext,
  `init_status` tinyint(4) DEFAULT NULL,
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`),
  KEY `index1` (`company_code`,`account_set_id`,`import_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for risk_index_ack
-- ----------------------------
DROP TABLE IF EXISTS `risk_index_ack`;
CREATE TABLE `risk_index_ack` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `report_id` bigint(20) DEFAULT NULL,
  `index_id` bigint(20) DEFAULT NULL,
  `description` varchar(256) DEFAULT NULL,
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for risk_index_agree
-- ----------------------------
DROP TABLE IF EXISTS `risk_index_agree`;
CREATE TABLE `risk_index_agree` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `report_id` bigint(20) DEFAULT NULL,
  `index_id` bigint(20) DEFAULT NULL,
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for risk_information
-- ----------------------------
DROP TABLE IF EXISTS `risk_information`;
CREATE TABLE `risk_information` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `issue_user_name` varchar(20) DEFAULT NULL COMMENT '发布人',
  `issue_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '发布时间',
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for risk_information_item
-- ----------------------------
DROP TABLE IF EXISTS `risk_information_item`;
CREATE TABLE `risk_information_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `information_id` bigint(20) DEFAULT NULL,
  `issue_type` tinyint(1) DEFAULT NULL COMMENT '0-草稿,1-预发布,2-已发布',
  `headline` varchar(50) DEFAULT NULL,
  `content` longtext,
  `author` varchar(20) DEFAULT NULL,
  `text_type` varchar(20) DEFAULT NULL COMMENT '0-纯文本,1-包含图片',
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for risk_information_read
-- ----------------------------
DROP TABLE IF EXISTS `risk_information_read`;
CREATE TABLE `risk_information_read` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `information_id` bigint(20) DEFAULT NULL,
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for risk_inventory_item
-- ----------------------------
DROP TABLE IF EXISTS `risk_inventory_item`;
CREATE TABLE `risk_inventory_item` (
  `id` bigint(20) NOT NULL,
  `type_id` bigint(20) DEFAULT NULL,
  `type_name` varchar(20) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `simple_name` varchar(20) DEFAULT NULL,
  `psort` int(4) DEFAULT NULL,
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for risk_message_read
-- ----------------------------
DROP TABLE IF EXISTS `risk_message_read`;
CREATE TABLE `risk_message_read` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `message_type` tinyint(4) DEFAULT NULL COMMENT '消息类型(1-公告,2-通知,3-预警)',
  `message_id` bigint(20) DEFAULT NULL,
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(4) DEFAULT '0' COMMENT '是否删除(0-否,1-是)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for risk_message_send
-- ----------------------------
DROP TABLE IF EXISTS `risk_message_send`;
CREATE TABLE `risk_message_send` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_set_id` bigint(20) DEFAULT NULL,
  `message_type_id` bigint(20) DEFAULT NULL,
  `send_channel_type` tinyint(4) DEFAULT NULL COMMENT '定义\r\n            1 站内, 2 短信, 3 EMAIL, 4 WECHAT',
  `message_param` varchar(256) DEFAULT NULL COMMENT '消息参数',
  `message_subject` varchar(256) DEFAULT NULL,
  `message_content` varchar(256) DEFAULT NULL,
  `push_state` tinyint(4) DEFAULT NULL COMMENT '定义\r\n            0 待推送; 1 推送成功; 2 推送失败; 3 已撤销',
  `error_reason` varchar(1000) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for risk_message_type
-- ----------------------------
DROP TABLE IF EXISTS `risk_message_type`;
CREATE TABLE `risk_message_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `message_type_code` varchar(25) DEFAULT NULL,
  `message_type_name` varchar(50) DEFAULT NULL,
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for risk_model_neeq_config
-- ----------------------------
DROP TABLE IF EXISTS `risk_model_neeq_config`;
CREATE TABLE `risk_model_neeq_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_set_id` bigint(20) DEFAULT NULL,
  `model_detail_id` bigint(20) DEFAULT NULL COMMENT '模型明细ID',
  `enabled` tinyint(4) DEFAULT NULL COMMENT '定义\r\n            0-禁用，1-启用',
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1852 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for risk_model_neeq_standard
-- ----------------------------
DROP TABLE IF EXISTS `risk_model_neeq_standard`;
CREATE TABLE `risk_model_neeq_standard` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `company_name` varchar(25) DEFAULT NULL,
  `company_sname` varchar(25) DEFAULT NULL,
  `stock_code` varchar(25) DEFAULT NULL,
  `company_type` int(7) DEFAULT NULL COMMENT '定义\r\n            0:基础层，1:创新层\r\n            ',
  `profession_id` bigint(20) DEFAULT NULL,
  `profession_name` varchar(25) DEFAULT NULL,
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`),
  UNIQUE KEY `stock_code` (`stock_code`),
  KEY `normal_index1` (`profession_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for risk_model_neeq_standard_detail
-- ----------------------------
DROP TABLE IF EXISTS `risk_model_neeq_standard_detail`;
CREATE TABLE `risk_model_neeq_standard_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `standard_id` bigint(20) DEFAULT NULL COMMENT '指标Id',
  `period_year` varchar(7) DEFAULT NULL,
  `index_id` bigint(20) DEFAULT NULL,
  `index_value` varchar(25) DEFAULT NULL,
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`),
  UNIQUE KEY `standard_id` (`standard_id`,`period_year`,`index_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for risk_online_config
-- ----------------------------
DROP TABLE IF EXISTS `risk_online_config`;
CREATE TABLE `risk_online_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `is_popup` int(1) DEFAULT NULL COMMENT '是否弹框 1:弹出 0:关闭',
  `btn_status` int(1) DEFAULT NULL COMMENT '按钮状态 1:打开 0:关闭',
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户在线客服配置表';

-- ----------------------------
-- Table structure for risk_open_app
-- ----------------------------
DROP TABLE IF EXISTS `risk_open_app`;
CREATE TABLE `risk_open_app` (
  `id` bigint(20) NOT NULL,
  `name` varchar(128) NOT NULL COMMENT '名称',
  `secret` varchar(128) DEFAULT NULL COMMENT '秘钥',
  `redirect_url` varchar(512) DEFAULT NULL COMMENT '跳转地址',
  `status` tinyint(3) NOT NULL DEFAULT '1' COMMENT '1-正常；2-冻结；0-删除',
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='开放应用表';

-- ----------------------------
-- Table structure for risk_operate_action
-- ----------------------------
DROP TABLE IF EXISTS `risk_operate_action`;
CREATE TABLE `risk_operate_action` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) DEFAULT NULL,
  `name` varchar(25) DEFAULT NULL,
  `pid` bigint(20) DEFAULT NULL,
  `type` tinyint(4) DEFAULT NULL COMMENT '定义\r\n                        1-菜单\r\n                        2-按钮\r\n                        3-链接',
  `url` varchar(100) DEFAULT NULL,
  `server_url` varchar(100) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL COMMENT '定义\r\n                        0-禁用,1-启用',
  `seq` bigint(20) DEFAULT NULL,
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='权限表';

-- ----------------------------
-- Table structure for risk_operate_role
-- ----------------------------
DROP TABLE IF EXISTS `risk_operate_role`;
CREATE TABLE `risk_operate_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(20) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `seq` int(20) DEFAULT NULL,
  `is_admin` tinyint(1) DEFAULT '0' COMMENT '定义\r\n                        0-否，1-是',
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色表';

-- ----------------------------
-- Table structure for risk_operate_role_action
-- ----------------------------
DROP TABLE IF EXISTS `risk_operate_role_action`;
CREATE TABLE `risk_operate_role_action` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) DEFAULT NULL,
  `action_id` bigint(20) DEFAULT NULL,
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色权限表';

-- ----------------------------
-- Table structure for risk_operate_user
-- ----------------------------
DROP TABLE IF EXISTS `risk_operate_user`;
CREATE TABLE `risk_operate_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(11) DEFAULT NULL,
  `real_name` varchar(20) DEFAULT NULL,
  `simple_name` varchar(20) DEFAULT NULL,
  `avatar` varchar(200) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL COMMENT '定义\r\n                        0-否，1-是',
  `status` tinyint(1) DEFAULT NULL COMMENT '0-禁用 1-启用',
  `is_admin` tinyint(1) DEFAULT '0' COMMENT '0-否 1-是',
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='运营平台用户表';

-- ----------------------------
-- Table structure for risk_operate_user_role
-- ----------------------------
DROP TABLE IF EXISTS `risk_operate_user_role`;
CREATE TABLE `risk_operate_user_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `role_id` bigint(20) DEFAULT NULL,
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户角色表';

-- ----------------------------
-- Table structure for risk_opinion_court_announcement
-- ----------------------------
DROP TABLE IF EXISTS `risk_opinion_court_announcement`;
CREATE TABLE `risk_opinion_court_announcement` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `company_code` bigint(20) DEFAULT NULL COMMENT '公司编号',
  `code` varchar(50) DEFAULT NULL COMMENT '公告编号',
  `case_no` varchar(255) DEFAULT NULL COMMENT '案号',
  `category` varchar(20) DEFAULT NULL COMMENT '种类',
  `prosecutor` text COMMENT '原告',
  `defendant` text COMMENT '被告',
  `case_reason` varchar(100) DEFAULT NULL COMMENT '案由',
  `published_date` varchar(20) DEFAULT NULL COMMENT '公布日期',
  `published_page` varchar(50) DEFAULT NULL COMMENT '公布、页',
  `court` varchar(50) DEFAULT NULL COMMENT '执行法院',
  `submit_date` varchar(20) DEFAULT NULL COMMENT '上传日期',
  `content` text COMMENT '内容',
  `oneself` tinyint(1) DEFAULT NULL COMMENT '0:企业风险，1:关联风险',
  `detail` tinyint(1) DEFAULT NULL COMMENT '是否查询明细（0：未查询，1：已查询）',
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='法院公告';

-- ----------------------------
-- Table structure for risk_opinion_court_notice
-- ----------------------------
DROP TABLE IF EXISTS `risk_opinion_court_notice`;
CREATE TABLE `risk_opinion_court_notice` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `company_code` bigint(20) DEFAULT NULL COMMENT '公司编号',
  `code` varchar(50) DEFAULT NULL COMMENT '公告编号',
  `case_no` varchar(255) DEFAULT NULL COMMENT '案号',
  `lian_date` varchar(20) DEFAULT NULL COMMENT '开庭日期',
  `case_reason` varchar(100) DEFAULT NULL COMMENT '案由',
  `prosecutor` text COMMENT '原告',
  `defendant` text COMMENT '被告',
  `execute_gov` varchar(50) DEFAULT NULL COMMENT '法院',
  `execute_unite` varchar(50) DEFAULT NULL COMMENT '法庭',
  `province` varchar(10) DEFAULT NULL COMMENT '省份',
  `schedule_time` varchar(20) DEFAULT NULL COMMENT '排期日期',
  `undertake_department` varchar(20) DEFAULT NULL COMMENT '承办部门',
  `chief_judge` varchar(10) DEFAULT NULL COMMENT '审判长/主审人',
  `notice_content` varchar(20) DEFAULT NULL COMMENT '公告内容',
  `third_party` varchar(20) DEFAULT NULL COMMENT '第三方人',
  `oneself` tinyint(1) DEFAULT NULL COMMENT '0:企业风险，1:关联风险',
  `detail` tinyint(1) DEFAULT NULL COMMENT '是否查询明细（0：未查询，1：已查询）',
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='开庭公告';

-- ----------------------------
-- Table structure for risk_opinion_judgment
-- ----------------------------
DROP TABLE IF EXISTS `risk_opinion_judgment`;
CREATE TABLE `risk_opinion_judgment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `company_code` bigint(20) DEFAULT NULL COMMENT '公司编号',
  `code` varchar(50) DEFAULT NULL COMMENT '公告编号',
  `case_type` varchar(10) DEFAULT NULL COMMENT '案件类型(ms:民事 xs:刑事 xz:行政 zscq:知识产权 pc:赔偿 zx:执行)',
  `case_no` varchar(255) DEFAULT NULL COMMENT '案号',
  `case_name` varchar(255) DEFAULT NULL COMMENT '裁判文书名字',
  `case_reason` varchar(100) DEFAULT NULL COMMENT '案由',
  `submit_date` varchar(20) DEFAULT NULL COMMENT '发布时间',
  `case_role` text COMMENT '涉案人员角色',
  `court` varchar(50) DEFAULT NULL COMMENT '法院',
  `judge_date` varchar(20) DEFAULT NULL COMMENT '裁判时间',
  `party_info` text COMMENT '当事人信息',
  `trial_procedure` text COMMENT '审理经过',
  `court_consider` text COMMENT '本院认为',
  `judge_result` text COMMENT '判决结果',
  `oneself` tinyint(1) DEFAULT NULL COMMENT '0:企业风险，1:关联风险',
  `detail` tinyint(1) DEFAULT NULL COMMENT '是否查询明细（0：未查询，1：已查询）',
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='裁判文书';

-- ----------------------------
-- Table structure for risk_platform_basic_data_item
-- ----------------------------
DROP TABLE IF EXISTS `risk_platform_basic_data_item`;
CREATE TABLE `risk_platform_basic_data_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type_id` bigint(20) DEFAULT NULL,
  `code` varchar(25) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `simple_name` varchar(20) DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL,
  `seq` int(10) DEFAULT NULL,
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1179 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for risk_platform_basic_data_type
-- ----------------------------
DROP TABLE IF EXISTS `risk_platform_basic_data_type`;
CREATE TABLE `risk_platform_basic_data_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(25) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL,
  `seq` int(10) DEFAULT NULL,
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for risk_platform_index
-- ----------------------------
DROP TABLE IF EXISTS `risk_platform_index`;
CREATE TABLE `risk_platform_index` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(20) DEFAULT NULL COMMENT '编码',
  `name` varchar(50) NOT NULL COMMENT '指标名称',
  `simple_name` varchar(50) DEFAULT NULL COMMENT '指标简码',
  `profession_id` varchar(256) DEFAULT NULL COMMENT '指标行业ID',
  `profession_name` varchar(512) DEFAULT NULL COMMENT '指标行业名称',
  `type_id` int(10) DEFAULT NULL,
  `type_name` varchar(20) DEFAULT NULL COMMENT '指标分类名称',
  `label_id` bigint(20) DEFAULT NULL COMMENT '标签ID',
  `description` text,
  `suggest` text,
  `mul_area` tinyint(1) DEFAULT '0' COMMENT '是否多区域(0:通用区域,1:多区域)',
  `mul_range` tinyint(1) DEFAULT '0' COMMENT '是否多行业((1:通用行业  2:多行业))-弃用',
  `enable_sync` tinyint(1) DEFAULT NULL COMMENT '1下移到企业，0不下移',
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_index1` (`code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=517 DEFAULT CHARSET=utf8 COMMENT='平台指标表';

-- ----------------------------
-- Table structure for risk_platform_index_area
-- ----------------------------
DROP TABLE IF EXISTS `risk_platform_index_area`;
CREATE TABLE `risk_platform_index_area` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `index_id` bigint(20) DEFAULT NULL COMMENT '指标Id',
  `province_id` bigint(20) DEFAULT NULL COMMENT '省份ID',
  `province_name` varchar(50) DEFAULT NULL COMMENT '省份名称',
  `mul_range` tinyint(1) DEFAULT '1' COMMENT '1:通用行业  2:多行业',
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_index1` (`index_id`,`province_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=272 DEFAULT CHARSET=utf8 COMMENT='平台指标区域表';

-- ----------------------------
-- Table structure for risk_platform_index_formula
-- ----------------------------
DROP TABLE IF EXISTS `risk_platform_index_formula`;
CREATE TABLE `risk_platform_index_formula` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `index_id` bigint(20) DEFAULT NULL COMMENT '指标ID',
  `system_id` bigint(20) DEFAULT NULL COMMENT '会计制度ID',
  `system_name` varchar(50) DEFAULT NULL COMMENT '会计制度名称',
  `expression` varchar(512) DEFAULT NULL COMMENT '显示公式',
  `formula` text COMMENT '计算公式',
  `is_common` tinyint(4) DEFAULT '0' COMMENT '是否通用 0:否  1:是',
  `exp1` varchar(512) DEFAULT NULL,
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_index1` (`index_id`,`system_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=924 DEFAULT CHARSET=utf8 COMMENT='平台指标公式表';

-- ----------------------------
-- Table structure for risk_platform_index_label
-- ----------------------------
DROP TABLE IF EXISTS `risk_platform_index_label`;
CREATE TABLE `risk_platform_index_label` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) DEFAULT NULL COMMENT '编码',
  `name` varchar(50) DEFAULT NULL COMMENT '名称',
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='平台指标标签表';

-- ----------------------------
-- Table structure for risk_platform_index_range
-- ----------------------------
DROP TABLE IF EXISTS `risk_platform_index_range`;
CREATE TABLE `risk_platform_index_range` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `index_id` bigint(20) DEFAULT NULL COMMENT '指标Id',
  `profession_id` bigint(20) DEFAULT NULL COMMENT '企业行业ID',
  `profession_name` varchar(50) DEFAULT NULL COMMENT '企业行业名称',
  `province_id` bigint(20) DEFAULT NULL COMMENT '省份ID',
  `province_name` varchar(50) DEFAULT NULL COMMENT '省份名称',
  `range_low` varchar(256) DEFAULT NULL COMMENT '存在风险展示公式',
  `range_low_formula` text COMMENT '存在风险公式',
  `range_high` varchar(256) DEFAULT NULL COMMENT '高等风险展示公式',
  `range_high_formula` text COMMENT '高等风险公式',
  `range_top` varchar(256) DEFAULT NULL COMMENT '极度危险展示公式',
  `range_top_formula` text COMMENT '极度危险公式',
  `low_dir_exp` varchar(256) DEFAULT NULL COMMENT '偏小方向公式',
  `range_1` varchar(256) DEFAULT NULL COMMENT '风险区间备用字段1',
  `range_2` varchar(256) DEFAULT NULL COMMENT '风险区间备用字段2',
  `range_3` varchar(256) DEFAULT NULL COMMENT '风险区间备用字段3',
  `exp1` varchar(256) DEFAULT NULL COMMENT '拓展字段1',
  `create_user` tinyint(20) DEFAULT NULL,
  `update_user` tinyint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_index1` (`index_id`,`profession_id`,`province_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=33535 DEFAULT CHARSET=utf8 COMMENT='平台指标表';

-- ----------------------------
-- Table structure for risk_platform_problem
-- ----------------------------
DROP TABLE IF EXISTS `risk_platform_problem`;
CREATE TABLE `risk_platform_problem` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `type` int(1) DEFAULT NULL COMMENT '问题类型 发票风险:3',
  `title` varchar(256) DEFAULT NULL COMMENT '问题标题',
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='平台问题表';

-- ----------------------------
-- Table structure for risk_platform_sources_history
-- ----------------------------
DROP TABLE IF EXISTS `risk_platform_sources_history`;
CREATE TABLE `risk_platform_sources_history` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL COMMENT '历史关键字',
  `system_id` varchar(20) DEFAULT NULL COMMENT '会计准则ID',
  `value` varchar(128) DEFAULT NULL COMMENT '内容',
  `show_value` varchar(128) DEFAULT NULL,
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=896 DEFAULT CHARSET=utf8 COMMENT='平台数据源选择历史表';

-- ----------------------------
-- Table structure for risk_platform_warn
-- ----------------------------
DROP TABLE IF EXISTS `risk_platform_warn`;
CREATE TABLE `risk_platform_warn` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type_id` bigint(20) DEFAULT NULL,
  `profession_id` bigint(20) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `simple_name` varchar(50) DEFAULT NULL,
  `description` text,
  `enabled` tinyint(1) DEFAULT NULL COMMENT '0-禁用，1-启用',
  `enable_sync` tinyint(1) DEFAULT NULL COMMENT '0-否，1-是',
  `suggest` text,
  `mul_range` tinyint(1) DEFAULT NULL COMMENT '若通用阈值为1，多行业为2，前端提供',
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for risk_platform_warn_range
-- ----------------------------
DROP TABLE IF EXISTS `risk_platform_warn_range`;
CREATE TABLE `risk_platform_warn_range` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `warn_id` bigint(20) DEFAULT NULL COMMENT '预警ID',
  `profession_id` bigint(20) DEFAULT NULL COMMENT '行业ID',
  `index_id` bigint(20) DEFAULT NULL COMMENT '指标ID',
  `name` varchar(20) DEFAULT NULL,
  `range_low` varchar(256) DEFAULT NULL COMMENT '存在风险',
  `range_low_formula` text COMMENT '存在风险公式',
  `range_high` varchar(256) DEFAULT NULL COMMENT '高等风险',
  `range_high_formula` text COMMENT '高等风险公式',
  `range_top` varchar(256) DEFAULT NULL COMMENT '极度风险',
  `range_top_formula` text COMMENT '极度危险公式',
  `enable` tinyint(1) DEFAULT NULL COMMENT '1模板启用，0禁用（预留字段）',
  `enable_sync` tinyint(1) DEFAULT NULL,
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for risk_problem_index
-- ----------------------------
DROP TABLE IF EXISTS `risk_problem_index`;
CREATE TABLE `risk_problem_index` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `problem_id` bigint(20) DEFAULT NULL COMMENT '问题编号',
  `index_id` bigint(20) DEFAULT NULL COMMENT '指标编号',
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='平台问题指标关联表';

-- ----------------------------
-- Table structure for risk_problem_news
-- ----------------------------
DROP TABLE IF EXISTS `risk_problem_news`;
CREATE TABLE `risk_problem_news` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `company_code` bigint(20) DEFAULT NULL COMMENT '公司编号',
  `hot` tinyint(1) DEFAULT NULL COMMENT '新闻热度（0：普通新闻，1：热点新闻）',
  `emotion_type` tinyint(1) DEFAULT NULL COMMENT '情感类别（1-消极，2-中立,3-积极）',
  `category` varchar(255) DEFAULT NULL COMMENT '新闻类别',
  `news_id` varchar(50) DEFAULT NULL COMMENT '新闻id',
  `source` varchar(100) DEFAULT NULL COMMENT '来源',
  `title` varchar(150) DEFAULT NULL COMMENT '新闻标题',
  `url` text COMMENT '新闻来源url',
  `publish_time` varchar(20) DEFAULT NULL COMMENT '发布时间',
  `news_tags` varchar(255) DEFAULT NULL COMMENT '新闻标签',
  `content` mediumtext COMMENT '新闻内容',
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=315 DEFAULT CHARSET=utf8 COMMENT='企业新闻';

-- ----------------------------
-- Table structure for risk_problem_tax_history
-- ----------------------------
DROP TABLE IF EXISTS `risk_problem_tax_history`;
CREATE TABLE `risk_problem_tax_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `company_code` bigint(20) DEFAULT NULL COMMENT '公司编号',
  `period` varchar(10) DEFAULT NULL COMMENT '会计期间',
  `batch_id` bigint(20) DEFAULT NULL COMMENT '批次号',
  `index_id` bigint(20) DEFAULT NULL COMMENT '指标id',
  `type` tinyint(2) DEFAULT NULL COMMENT '问题类型（2：增值税风险，3：发票风险，4：企业所得税风险，5：个人所得税风险，6：附加税风险，7：其他涉税风险）',
  `data` text COMMENT '数据',
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2146 DEFAULT CHARSET=utf8 COMMENT='涉税问题历史';

-- ----------------------------
-- Table structure for risk_problem_venture
-- ----------------------------
DROP TABLE IF EXISTS `risk_problem_venture`;
CREATE TABLE `risk_problem_venture` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `company_code` bigint(20) DEFAULT NULL COMMENT '公司编号',
  `type` tinyint(1) DEFAULT NULL COMMENT '风险类型(1：企业自身风险，2：判决文书，3：关联人风险，4：关联企业风险)',
  `info_type` tinyint(2) DEFAULT NULL COMMENT '风险项类型{企业自身风险：（1：被执行人，3：失信，4：司法拍案，5：开庭公告，6：税收违法，7：股权出质，8：动产抵押，9：股权冻结，10：法院公告，11：土地抵押，12：经营异常，13：法人变更，14：大股东变更，15：环保处罚，16：行政处罚），关联人风险：（1：失信，2：被执行，3：限制消费），关联企业风险：（1：法人变更，2：失信，3：执行，4：开庭公告，5：税收违法，6：判决文书，7：司法拍案，8：经营异常，9：股权出质，10：动产抵押，11：股权冻结，12：行政处罚，13：大股东变更，14：环保处罚，15：土地抵押）}',
  `count` bigint(20) DEFAULT NULL COMMENT '数量',
  `detail` text COMMENT '详情',
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9159 DEFAULT CHARSET=utf8 COMMENT='企业风险';

-- ----------------------------
-- Table structure for risk_profession
-- ----------------------------
DROP TABLE IF EXISTS `risk_profession`;
CREATE TABLE `risk_profession` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(20) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `pcode` varchar(20) DEFAULT NULL,
  `gbbm` bigint(20) DEFAULT NULL,
  `seq` int(20) DEFAULT NULL COMMENT '排序',
  `level` tinyint(4) DEFAULT NULL,
  `tail` tinyint(4) DEFAULT NULL COMMENT '0-否，1-是',
  `display` tinyint(4) DEFAULT NULL COMMENT '0-否，1-是',
  `exp1` varchar(255) DEFAULT NULL,
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_gbbm` (`gbbm`) USING BTREE,
  KEY `nor_index1` (`code`) USING BTREE,
  KEY `nor_index2` (`pcode`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9942 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for risk_profession_data
-- ----------------------------
DROP TABLE IF EXISTS `risk_profession_data`;
CREATE TABLE `risk_profession_data` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `province_id` bigint(20) DEFAULT NULL COMMENT '省份ID',
  `province_name` varchar(20) DEFAULT NULL COMMENT '省份名称',
  `profession_id` bigint(20) DEFAULT NULL COMMENT '行业编码',
  `profession_name` varchar(50) DEFAULT NULL COMMENT '行业名称',
  `name` varchar(20) DEFAULT NULL COMMENT '变量名称',
  `value` varchar(20) DEFAULT NULL COMMENT '变量值',
  `resource` varchar(20) DEFAULT NULL COMMENT '数据来源',
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`),
  KEY `index` (`profession_id`,`province_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=128077 DEFAULT CHARSET=utf8 COMMENT='行业数据表';

-- ----------------------------
-- Table structure for risk_report_info
-- ----------------------------
DROP TABLE IF EXISTS `risk_report_info`;
CREATE TABLE `risk_report_info` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(20) DEFAULT NULL COMMENT '报表编码',
  `name` varchar(25) DEFAULT NULL COMMENT '报告名称',
  `remark` varchar(256) DEFAULT NULL COMMENT '报告说明',
  `total_score` int(11) DEFAULT NULL COMMENT '报告总分数',
  `template` varchar(256) DEFAULT NULL COMMENT '报告模板',
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='报告信息表';

-- ----------------------------
-- Table structure for risk_report_item
-- ----------------------------
DROP TABLE IF EXISTS `risk_report_item`;
CREATE TABLE `risk_report_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sources_id` bigint(20) DEFAULT NULL,
  `report_name` varchar(50) DEFAULT NULL,
  `report_id` bigint(20) DEFAULT NULL COMMENT '报表类型id',
  `account_system` bigint(20) DEFAULT NULL,
  `name` varchar(256) DEFAULT NULL COMMENT '接口kZbbm清洗数据',
  `simple_name` varchar(256) DEFAULT NULL,
  `report_type` int(4) DEFAULT NULL,
  `psort` int(4) DEFAULT NULL COMMENT '报表字段排序',
  `expression` text,
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`),
  KEY `union_index` (`report_name`,`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=991008 DEFAULT CHARSET=utf8 COMMENT='报表数据模板表';

-- ----------------------------
-- Table structure for risk_report_item_annual
-- ----------------------------
DROP TABLE IF EXISTS `risk_report_item_annual`;
CREATE TABLE `risk_report_item_annual` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `report_id` bigint(11) DEFAULT NULL,
  `report_name` varchar(25) DEFAULT NULL COMMENT '报表头名称',
  `report_number` varchar(10) DEFAULT NULL COMMENT '报表编号',
  `simple_name` varchar(256) DEFAULT NULL COMMENT '拼音简码',
  `index_name` varchar(256) DEFAULT NULL COMMENT '指标报表项名称',
  `row_index` int(4) DEFAULT NULL COMMENT '模板位置行',
  `col_index` int(4) DEFAULT NULL COMMENT '模板位置列',
  `psort` int(4) DEFAULT NULL COMMENT '报表字段排序',
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='汇算清缴报表数据模板表';

-- ----------------------------
-- Table structure for risk_report_result
-- ----------------------------
DROP TABLE IF EXISTS `risk_report_result`;
CREATE TABLE `risk_report_result` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `company_code` bigint(20) DEFAULT NULL COMMENT '企业编码',
  `account_set_id` bigint(20) DEFAULT NULL COMMENT '账套ID',
  `report_id` bigint(20) DEFAULT NULL COMMENT '报告ID',
  `report_type_code` varchar(10) DEFAULT NULL COMMENT '报表类型(01：年报 02：半年报 03：季报 04：月报)',
  `compare_type` tinyint(4) DEFAULT NULL COMMENT '报告比较类型(0：同比  1：环比)',
  `period` varchar(10) DEFAULT NULL COMMENT '体检会计期间',
  `score` decimal(10,2) DEFAULT NULL COMMENT '体检得分',
  `status` tinyint(4) DEFAULT NULL COMMENT '0-取消,1-未完成,2-已完成',
  `integrate_desc` varchar(512) DEFAULT NULL COMMENT '综合话术',
  `path` varchar(128) DEFAULT NULL,
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`),
  KEY `normal_index` (`account_set_id`,`report_id`,`period`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='体检报告结果表';

-- ----------------------------
-- Table structure for risk_report_result_calc
-- ----------------------------
DROP TABLE IF EXISTS `risk_report_result_calc`;
CREATE TABLE `risk_report_result_calc` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `company_code` bigint(20) DEFAULT NULL COMMENT '企业编码',
  `account_set_id` bigint(11) DEFAULT NULL COMMENT '账套ID',
  `report_id` bigint(20) DEFAULT NULL COMMENT '报告ID',
  `period` varchar(10) DEFAULT NULL COMMENT '体检会计期间',
  `index_id` bigint(11) DEFAULT NULL COMMENT '指标ID',
  `index_value` varchar(25) DEFAULT NULL COMMENT '指标值',
  `score` decimal(10,2) DEFAULT NULL COMMENT '检查得分',
  `risk_level` int(11) DEFAULT NULL COMMENT '风险级别',
  `stray_dir` tinyint(4) DEFAULT NULL,
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_index` (`account_set_id`,`report_id`,`period`,`index_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=686 DEFAULT CHARSET=utf8 COMMENT='体检报告结果计算中间表';

-- ----------------------------
-- Table structure for risk_report_result_detail
-- ----------------------------
DROP TABLE IF EXISTS `risk_report_result_detail`;
CREATE TABLE `risk_report_result_detail` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `report_result_id` bigint(11) DEFAULT NULL COMMENT '报告结果ID',
  `index_id` bigint(11) DEFAULT NULL COMMENT '指标ID',
  `index_value` varchar(25) DEFAULT NULL COMMENT '指标值',
  `score` decimal(10,2) DEFAULT NULL COMMENT '检查得分',
  `risk_level` int(11) DEFAULT NULL COMMENT '风险级别',
  `stray_dir` tinyint(4) DEFAULT NULL,
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_index` (`report_result_id`,`index_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=951 DEFAULT CHARSET=utf8 COMMENT='体检报告结果明细表';

-- ----------------------------
-- Table structure for risk_report_result_history
-- ----------------------------
DROP TABLE IF EXISTS `risk_report_result_history`;
CREATE TABLE `risk_report_result_history` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `report_result_id` bigint(20) DEFAULT NULL COMMENT '报告结果ID',
  `account_set_id` bigint(20) DEFAULT NULL COMMENT '账套ID',
  `report_id` bigint(20) DEFAULT NULL COMMENT '报告ID',
  `report_type_code` varchar(10) DEFAULT NULL COMMENT '报表类型(01：年报 02：半年报 03：季报 04：月报)',
  `compare_type` tinyint(4) DEFAULT NULL COMMENT '报告比较类型(0：同比  1：环比)',
  `period` varchar(10) DEFAULT NULL COMMENT '体检会计期间',
  `score` decimal(10,2) DEFAULT NULL COMMENT '体检得分',
  `type_id` int(11) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL COMMENT '0-取消,1-未完成,2-已完成',
  `path` varchar(128) DEFAULT NULL,
  `integrate_desc` varchar(512) DEFAULT NULL COMMENT '综合话术',
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `version` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_index` (`account_set_id`,`period`,`type_id`,`version`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='体检报告结果历史表';

-- ----------------------------
-- Table structure for risk_report_score
-- ----------------------------
DROP TABLE IF EXISTS `risk_report_score`;
CREATE TABLE `risk_report_score` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `report_id` bigint(20) DEFAULT NULL COMMENT '报告id',
  `index_id` bigint(20) DEFAULT NULL COMMENT '指标Id',
  `range_relative` decimal(10,2) DEFAULT NULL COMMENT '相对安全评分权重',
  `range_low` decimal(10,2) DEFAULT NULL COMMENT '有风险评分权重',
  `range_high` decimal(10,2) DEFAULT NULL COMMENT '高风险评分权重',
  `range_top` decimal(10,2) DEFAULT NULL COMMENT '极度危险评分权重',
  `type_name` varchar(50) DEFAULT NULL COMMENT '类型名称',
  `seq` int(20) DEFAULT NULL COMMENT '排序',
  `range1` int(11) DEFAULT NULL COMMENT 'range1',
  `range2` int(11) DEFAULT NULL COMMENT 'range2',
  `range3` int(11) DEFAULT NULL COMMENT 'range3',
  `is_end` tinyint(4) DEFAULT NULL COMMENT '是否末尾(0-否,1-是)',
  `is_relate_ticket` tinyint(4) DEFAULT '0' COMMENT '是否关联单据(0-否,1-是)',
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8 COMMENT='报告指标分数表';

-- ----------------------------
-- Table structure for risk_sources
-- ----------------------------
DROP TABLE IF EXISTS `risk_sources`;
CREATE TABLE `risk_sources` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(20) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `psort` tinyint(4) DEFAULT '0' COMMENT '排序',
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='指标数据来源表';

-- ----------------------------
-- Table structure for risk_sources_history
-- ----------------------------
DROP TABLE IF EXISTS `risk_sources_history`;
CREATE TABLE `risk_sources_history` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL COMMENT '历史关键字：比如accountsetid、userid等',
  `value` varchar(128) DEFAULT NULL COMMENT '内容',
  `account_set_id` varchar(20) DEFAULT NULL COMMENT '分类',
  `show_value` varchar(128) DEFAULT NULL,
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=696 DEFAULT CHARSET=utf8 COMMENT='数据源选择历史表';

-- ----------------------------
-- Table structure for risk_statistics_item
-- ----------------------------
DROP TABLE IF EXISTS `risk_statistics_item`;
CREATE TABLE `risk_statistics_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type_id` bigint(20) DEFAULT NULL,
  `type_name` varchar(20) DEFAULT NULL,
  `name` varchar(128) DEFAULT NULL,
  `simple_name` varchar(50) DEFAULT NULL,
  `psort` int(4) DEFAULT NULL,
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for risk_steward_problem
-- ----------------------------
DROP TABLE IF EXISTS `risk_steward_problem`;
CREATE TABLE `risk_steward_problem` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `problem_name` varchar(20) DEFAULT NULL,
  `seq` tinyint(11) DEFAULT NULL,
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for risk_sys_config
-- ----------------------------
DROP TABLE IF EXISTS `risk_sys_config`;
CREATE TABLE `risk_sys_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `key_name` varchar(25) DEFAULT NULL COMMENT '系统配置名',
  `key_value` varchar(25) DEFAULT NULL COMMENT '系统配置值',
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_index` (`key_name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='系统配置表';

-- ----------------------------
-- Table structure for risk_tax_mapping
-- ----------------------------
DROP TABLE IF EXISTS `risk_tax_mapping`;
CREATE TABLE `risk_tax_mapping` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tax_id` bigint(20) DEFAULT NULL COMMENT '申报税种id',
  `report_name` varchar(50) DEFAULT NULL COMMENT '报表名称',
  `tax_mark` varchar(10) DEFAULT NULL COMMENT '国地税标识（国税：1 ，地税：2）',
  `tax_term` varchar(10) DEFAULT NULL COMMENT '纳税期限（1-月，2-季，3-半年，4-年，5-次）',
  `divide` varchar(20) DEFAULT NULL COMMENT '行政区划id',
  `tax_type` int(20) DEFAULT NULL COMMENT '税种类型（财务报表：-1，增值税：1，企业所得税：3）',
  `report_nature` varchar(10) DEFAULT NULL COMMENT '报表性质（会计准则ID(企业会计准则2017版->1,小企业会计准则2013版->3,企业会计制度->4)；纳税性质(001-一般纳税人,101-小规模纳税人)；征收方式（601-查账征收， 602-核定征收(按收入总额)，603-核定征收(按成本费用)，604-核定所得率征收(按收入)，605-核定应税所得率征收，606-代扣代缴，607-自行申报，608-委托代征(含代售印花税票)，609-代收代缴''））',
  `start_date` date DEFAULT NULL COMMENT '有效期起',
  `end_date` date DEFAULT NULL COMMENT '有效期止',
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='税表映射表';

-- ----------------------------
-- Table structure for risk_third_software_info
-- ----------------------------
DROP TABLE IF EXISTS `risk_third_software_info`;
CREATE TABLE `risk_third_software_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `company_code` bigint(20) DEFAULT NULL COMMENT '企业编码',
  `account_set_id` bigint(20) DEFAULT NULL COMMENT '账套编号',
  `kjnd` varchar(20) DEFAULT NULL COMMENT '会计年度',
  `enterprise` varchar(20) DEFAULT NULL COMMENT '厂商',
  `version` varchar(20) DEFAULT NULL COMMENT '版本',
  `name` varchar(50) DEFAULT NULL COMMENT '数据库名称',
  `address` varchar(50) DEFAULT NULL COMMENT '数据库连接地址',
  `account` varchar(50) DEFAULT NULL COMMENT '数据库连接用户名',
  `password` varchar(50) DEFAULT NULL COMMENT '数据库连接密码',
  `login_type` varchar(20) DEFAULT NULL COMMENT '数据库连接方式，值为windows或sa',
  `apid` varchar(20) DEFAULT NULL COMMENT '//101-财务初始化，102-一键登录税局',
  `zt_name` varchar(50) DEFAULT NULL COMMENT '账套名称',
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='第三方数据采集软件信息';

-- ----------------------------
-- Table structure for risk_thirdparty_history
-- ----------------------------
DROP TABLE IF EXISTS `risk_thirdparty_history`;
CREATE TABLE `risk_thirdparty_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `company_code` bigint(20) DEFAULT NULL COMMENT '公司编号',
  `service_name` varchar(50) DEFAULT NULL COMMENT '服务名称',
  `module_name` varchar(50) DEFAULT NULL COMMENT '模块名称',
  `param` text COMMENT '参数',
  `detail` longtext COMMENT '详情',
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1454 DEFAULT CHARSET=utf8 COMMENT='第三方接口历史';

-- ----------------------------
-- Table structure for risk_uac_auth_function
-- ----------------------------
DROP TABLE IF EXISTS `risk_uac_auth_function`;
CREATE TABLE `risk_uac_auth_function` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `func_id` bigint(20) NOT NULL COMMENT '功能ID',
  `func_name` varchar(255) DEFAULT NULL COMMENT '功能名称',
  `description` varchar(255) DEFAULT NULL COMMENT '功能描述',
  `parent_id` bigint(20) DEFAULT NULL COMMENT '上级功能ID',
  `url` varchar(255) DEFAULT NULL COMMENT 'url 链接',
  `perms` varchar(500) DEFAULT NULL COMMENT '授权标识(多个用逗号分隔，如：user:list,user:create)',
  `ico` varchar(255) DEFAULT NULL COMMENT '图标',
  `func_type` tinyint(4) DEFAULT '0' COMMENT '类型: 0 -menu;1-功能;2-按钮;3-接口',
  `seq` int(11) DEFAULT '0' COMMENT '排序',
  `status` tinyint(4) DEFAULT '0' COMMENT '状态： 0 - 启用， 1-停用',
  `module_id` bigint(20) DEFAULT NULL COMMENT '模块id',
  `is_basic_module` tinyint(2) DEFAULT NULL COMMENT '是否是基础模块，1:是，0:否',
  `source` tinyint(2) DEFAULT NULL COMMENT '0：核算；1：其他',
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8 COMMENT='功能列表';

-- ----------------------------
-- Table structure for risk_uac_operate_log
-- ----------------------------
DROP TABLE IF EXISTS `risk_uac_operate_log`;
CREATE TABLE `risk_uac_operate_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `user_name` varchar(20) DEFAULT NULL,
  `log_type` char(2) DEFAULT NULL,
  `log_type_name` varchar(25) DEFAULT NULL,
  `os` varchar(25) DEFAULT NULL,
  `browser` varchar(25) DEFAULT NULL,
  `ip` varchar(30) DEFAULT NULL,
  `class_name` varchar(255) DEFAULT NULL,
  `method_name` varchar(50) DEFAULT NULL,
  `request_url` varchar(200) DEFAULT NULL,
  `request_data` mediumtext,
  `response_data` mediumtext,
  `description` varchar(50) DEFAULT NULL,
  `excute_time` bigint(20) DEFAULT NULL,
  `host_info` varchar(255) DEFAULT NULL,
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for risk_uac_user_account_set
-- ----------------------------
DROP TABLE IF EXISTS `risk_uac_user_account_set`;
CREATE TABLE `risk_uac_user_account_set` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `company_code` bigint(20) DEFAULT NULL COMMENT '企业码',
  `account_set_id` bigint(20) DEFAULT NULL,
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for risk_uac_version_function
-- ----------------------------
DROP TABLE IF EXISTS `risk_uac_version_function`;
CREATE TABLE `risk_uac_version_function` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `version_id` varchar(10) NOT NULL COMMENT '版本号',
  `version_name` varchar(256) DEFAULT NULL COMMENT '版本名称',
  `func_id` bigint(20) NOT NULL COMMENT '功能ID',
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8 COMMENT='版本功能列表';

-- ----------------------------
-- Table structure for risk_user_default_account_set
-- ----------------------------
DROP TABLE IF EXISTS `risk_user_default_account_set`;
CREATE TABLE `risk_user_default_account_set` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户ID',
  `tenant_id` bigint(20) DEFAULT NULL COMMENT '租户ID',
  `company_code` bigint(20) DEFAULT NULL COMMENT '企业码',
  `account_set_id` bigint(20) DEFAULT NULL COMMENT '账套ID',
  `create_user` bigint(20) DEFAULT NULL COMMENT '最后操作人',
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户默认账套信息表';

-- ----------------------------
-- Table structure for risk_warn_config
-- ----------------------------
DROP TABLE IF EXISTS `risk_warn_config`;
CREATE TABLE `risk_warn_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_set_id` bigint(20) DEFAULT NULL,
  `enable_email` tinyint(1) DEFAULT NULL COMMENT '0-禁用，1-启用',
  `enable_sms` tinyint(1) DEFAULT NULL COMMENT '0-禁用，1-启用',
  `enable_wx` tinyint(1) DEFAULT NULL COMMENT '0-禁用，1-启用',
  `enable_week` tinyint(1) DEFAULT NULL COMMENT '0-禁用，1-启用',
  `start_time` varchar(10) DEFAULT NULL,
  `end_time` varchar(10) DEFAULT NULL,
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1597 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for risk_warn_event
-- ----------------------------
DROP TABLE IF EXISTS `risk_warn_event`;
CREATE TABLE `risk_warn_event` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_set_id` bigint(20) DEFAULT NULL,
  `period` varchar(10) DEFAULT NULL,
  `warn_id` bigint(20) DEFAULT NULL,
  `warn_level` int(2) DEFAULT NULL COMMENT '1-存在风险\r\n            2-高等风险\r\n            3-极度危险',
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=406 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for risk_warn_remind_config
-- ----------------------------
DROP TABLE IF EXISTS `risk_warn_remind_config`;
CREATE TABLE `risk_warn_remind_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_set_id` bigint(20) DEFAULT NULL,
  `remind_type` int(2) DEFAULT NULL,
  `remind_account` varchar(50) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3464 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for risk_warn_result
-- ----------------------------
DROP TABLE IF EXISTS `risk_warn_result`;
CREATE TABLE `risk_warn_result` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_set_id` bigint(20) DEFAULT NULL,
  `period` varchar(10) DEFAULT NULL,
  `warn_id` bigint(20) DEFAULT NULL,
  `warn_level` int(2) DEFAULT NULL COMMENT '1-存在风险\r\n            2-高等风险\r\n            3-极度危险',
  `create_user` bigint(20) DEFAULT NULL,
  `update_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0' COMMENT '0-否,1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

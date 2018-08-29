-- #### -- DROPping Existing Database If its available in the foodengine_dwh name
-- #### This script to be used for new customer environmental set-up 
-- #### By Running this script, we will lose all existing data


-- DROP DATABASE IF EXISTS foodengine_dwh ;
CREATE DATABASE IF NOT EXISTS foodengine_dwh;

USE foodengine_dwh;

-- DROP TABLE IF EXISTS fact_orderdetail;
CREATE TABLE IF NOT EXISTS fact_orderdetail(
ProcessId INT(11)	NOT NULL AUTO_INCREMENT 
,ProcessDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP 
,BranchId	INT(11)	NOT NULL 	DEFAULT 	0  COMMENT 'Id of dim_branch table'
,OrderId BIGINT(11) NOT NULL	DEFAULT 0 COMMENT 'source table order transaction id'
,OrderSummaryId BIGINT(11) NOT NULL	DEFAULT 0 COMMENT 'source table order summary transaction id'
,CustomerId INT(11)	NOT NULL 	DEFAULT 	0  COMMENT 'Id of dim_customer table'
,OrderTypeId	INT(11)	NOT NULL 	DEFAULT 	0  COMMENT 'Id of dDim_ordertype table'
,OnlinerefId	INT(11)	NOT NULL 	DEFAULT 	0  COMMENT 'Id of dim_onlinereferal table'
,FloorId	INT(11) NOT NULL DEFAULT 0  COMMENT 'Id of dim_tablefloor table'
,TableId	INT(11)	NOT NULL 	DEFAULT 	0 COMMENT 'Id of dim_tablefloor table'
,DepartmentId	INT(11)	NOT NULL 	DEFAULT 	0   COMMENT 'Id of dim_department table'
,MenuId	INT(11)	NOT NULL 	DEFAULT 	0      COMMENT 'Id of dim_menuitem table'
,CaptainId	INT(11)	NOT NULL 	DEFAULT 	0     COMMENT 'Id of dim_waiter table'
,WaiterId	INT(11)	NOT NULL 	DEFAULT 	0		COMMENT 'Id of dim_waiter table'
,OrderStatusId INT(11)	NOT NULL 	DEFAULT 	0 COMMENT 'Id of dim_orderstatus table' 
,DiscountTypeId SMALLINT(2) NOT NULL DEFAULT 0 COMMENT 'Id of dim_discounttype table'
,ComplimentaryStatusId SMALLINT(1) DEFAULT 0 COMMENT 'Id of dim_complimentary table'
,SplitTypeId  SMALLINT(1) DEFAULT 0 COMMENT 'Id of dim_splittype table'
,PaymodeId	INT(11)	NOT NULL 	DEFAULT 	0  COMMENT 'Id of dim_paymode table' 
,CardTypeId	INT(11)	NOT NULL 	DEFAULT 	0 COMMENT 'Id of dim_cardtype table'
,BillTimeId	INT(11)	NOT NULL 	DEFAULT 	0 COMMENT 'Id of dim_time table'
,CreateDateId	INT(11)	NOT NULL 	DEFAULT 	0 COMMENT 'Id of dim_date table'
,CreateDate	TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00'		
,NoOfPpl INT(11) NOT NULL DEFAULT 0
,Itemprice DECIMAL(10,2) DEFAULT '0.00'
,ItemQty DECIMAL(10,2) DEFAULT '0.00'
,OrderPrice DECIMAL(10,2) DEFAULT '0.00'
,DiscPer DECIMAL(5,2) DEFAULT '0.00'
,DiscPrice DECIMAL(10,2) DEFAULT '0.00'
,ServiceTax DECIMAL(10,2) DEFAULT '0.00'
,ServChargeTax DECIMAL(10,2) DEFAULT '0.00'
,ParcelCharge DECIMAL(10,2) DEFAULT '0.00'
,TaxAmount DECIMAL(10,2) DEFAULT '0.00'
,SalesAmount DECIMAL(10,2) DEFAULT '0.00'
,PRIMARY KEY (ProcessId)
,UNIQUE KEY uniq_order (OrderId,OrderSummaryId,BranchId)
,KEY idx_BranchId (BranchId)
,KEY idx_OrderId (OrderId)
,KEY idx_CustomerId (CustomerId)
,KEY idx_OrderTypeId (OrderTypeId)
,KEY idx_OnlinerefId (OnlinerefId)
,KEY idx_FloorId (FloorId)
,KEY idx_TableId (TableId)
,KEY idx_Department_Id (DepartmentId)
,KEY idx_MenuId (MenuId)
,KEY idx_CaptainId (CaptainId)
,KEY idx_WaiterId (WaiterId)
,KEY idx_OrderStatusId (OrderStatusId)
,KEY idx_DiscountTypeId (DiscountTypeId)
,KEY idx_ComplimentaryStatus_Id (ComplimentaryStatusId)
,KEY idx_SplitTypeId (SplitTypeId)
,KEY idx_PaymodeId (PaymodeId)
,KEY idx_CardTypeId (CardTypeId)
,KEY idx_BillTimeId (BillTimeId)
,KEY idx_CreatedateId (CreatedateId)
,KEY idx_CreateDate (CreateDate)
);

-- DROP TABLE IF EXISTS dim_ordertype;
CREATE TABLE IF NOT EXISTS dim_ordertype (
Id INT(11) NOT NULL AUTO_INCREMENT
,OrderTypeCode varchar(3) DEFAULT NULL
,OrderTypeDesc varchar(20) DEFAULT NULL
,PRIMARY KEY (Id)
,UNIQUE KEY uniq_ordertype (OrderTypeCode)
);

-- DROP TABLE IF EXISTS dim_branch;
CREATE TABLE IF NOT EXISTS dim_branch (
Id INT(11) NOT NULL AUTO_INCREMENT
,RestCode int(11) NOT NULL DEFAULT 0 COMMENT 'RestId from source branch master table'
,BranchCode varchar(11) NOT NULL DEFAULT '' COMMENT 'BranchId from source branch master table'
,BranchName  varchar(30) NOT NULL DEFAULT ''
,CreatedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
,LocationId INT(11) NOT NULL DEFAULT 0
,PRIMARY KEY (Id)
,UNIQUE KEY uniq_branch (RestCode,BranchCode)
);

-- DROP TABLE IF EXISTS dim_combotype;
CREATE TABLE IF NOT EXISTS dim_combotype (
Id INT(11) NOT NULL AUTO_INCREMENT
,ComboCode char(1) NOT NULL 
,ComboDesc varchar(10) NOT NULL 
,PRIMARY KEY (Id)
,UNIQUE KEY uniq_combo (comboCode)
);



-- DROP TABLE IF EXISTS dim_department;
CREATE TABLE IF NOT EXISTS dim_department (
Id INT(11) NOT NULL AUTO_INCREMENT
,BranchId INT(11) NOT NULL DEFAULT 0 COMMENT 'Id of Dim_Branch table'
,DeptID int(11) NOT NULL
,DeptName varchar(100) COLLATE utf8_bin NOT NULL
,NoofItems int(11) NOT NULL
,KotTitle varchar(100) COLLATE utf8_bin DEFAULT 'Kitchen Copy'
,CreatedDate timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
,Createdby int(11) DEFAULT NULL
,PRIMARY KEY (Id)
,UNIQUE KEY uniq_department (BranchId,DeptID)
);

-- DROP TABLE IF EXISTS dim_menuitem;
CREATE TABLE IF NOT EXISTS dim_menuitem (
Id INT(11) NOT NULL AUTO_INCREMENT
,BranchId INT(11) NOT NULL DEFAULT 0 COMMENT 'Id of Dim_Branch table'
,MenuId VARCHAR(15) CHARACTER SET latin1 NOT NULL
,MenuCode VARCHAR(30) CHARACTER SET latin1 DEFAULT NULL
,Name VARCHAR(255) CHARACTER SET latin1 DEFAULT NULL
,Price decimal(6,2) NOT NULL DEFAULT '0.00'
,AcPrice decimal(6,2) DEFAULT '0.00'
,ParcelPrice decimal(10,2) DEFAULT '0.00'
,RoomPrice decimal(10,2) DEFAULT '0.00'
,ItemLevel VARCHAR(15) CHARACTER SET latin1 NOT NULL 
,ItemParent VARCHAR(15) CHARACTER SET latin1
,ItemStatus VARCHAR(10) CHARACTER SET latin1 NOT NULL DEFAULT 'Actie' 
,ItemHide VARCHAR(10) CHARACTER SET latin1 DEFAULT 'Actie' 
,DisplayOrder INT(2) DEFAULT NULL
,DeptPrint CHAR(1) CHARACTER SET latin1 DEFAULT 'N'
,DepartmentID INT(11) DEFAULT '0' COMMENT 'Id of Dim_Department table'
,RewardPoints decimal(10,2) DEFAULT '0.00'
,LockType CHAR(10) CHARACTER SET latin1 DEFAULT 'Temporary' 
,ItemType CHAR(10) CHARACTER SET latin1 DEFAULT NULL
,CreatedDateId INT(11) NOT NULL DEFAULT 0
,CreatedDate TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP
,LastUpdated TIMESTAMP NULL DEFAULT '0000-00-00 00:00:00'
,ComboTypeId INT(4) NOT NULL DEFAULT 0 COMMENT 'Id of combotype dim table'
,DineInTax int(11) NOT NULL DEFAULT '0'
,TAwayTax int(11) NOT NULL DEFAULT '0'
,DelivTax int(11) NOT NULL DEFAULT '0'
,kotitemname varchar(100) DEFAULT NULL
,DeliveryPrice decimal(10,2) DEFAULT '0.00'
,TaxItem char(1) CHARACTER SET latin1 DEFAULT 'Y'
,AcDineInTax int(11) NOT NULL DEFAULT '0'
,NonAcDineInTax int(11) DEFAULT '0'
,RoomServTax int(11) DEFAULT '0'
,RegionID int(11) DEFAULT '0'
,MenuType char(1) CHARACTER SET latin1 DEFAULT 'L'
,HappyPrice decimal(10,2) DEFAULT '0.00'
,HappyAcPrice decimal(10,2) DEFAULT '0.00'
,PRIMARY KEY (Id)
,UNIQUE KEY uniq_menu (BranchId,MenuId)
,KEY idx_ComboTypeId (ComboTypeId)
);

-- DROP TABLE IF EXISTS dim_waiter;
CREATE TABLE IF NOT EXISTS dim_waiter (
Id INT(11) NOT NULL AUTO_INCREMENT
,BranchId INT(11) NOT NULL DEFAULT 0 COMMENT 'Id of Dim_Branch table'
,EmpCode varchar(30) NOT NULL
,WaiterName varchar(30) DEFAULT NULL
,EmpType char(1) DEFAULT NULL COMMENT 'E- Employee,C- Captain, W- Waiter'
,EmpStatus char(1) DEFAULT 'A'
,PRIMARY KEY (Id)
,UNIQUE KEY uniq_waiter (BranchId,EmpCode)
);

-- DROP TABLE IF EXISTS dim_customer;
CREATE TABLE IF NOT EXISTS dim_customer (
Id INT(11) NOT NULL AUTO_INCREMENT
,BranchId INT(11) NOT NULL DEFAULT 0 COMMENT 'Id of Dim_Branch table'
,CustMobile	VARCHAR(15)	COLLATE utf8_bin NOT NULL DEFAULT ''
,RedeemPoints	INT(11)	NOT NULL DEFAULT 0
,CustomerName	VARCHAR(200) NOT NULL DEFAULT ''
,CustomerAddr	TEXT	
,CustomerPhone	VARCHAR(15)	NOT NULL DEFAULT ''
,CustomerEmail	VARCHAR(60)	NOT NULL DEFAULT ''
,LandMark	VARCHAR(255) NOT NULL DEFAULT ''	
,Type	CHAR(1)	NOT NULL DEFAULT 'C'
,Area	VARCHAR(30)	 NOT NULL DEFAULT ''
,CreateDate	TIMESTAMP  NOT NULL DEFAULT CURRENT_TIMESTAMP		
,DOB	VARCHAR(15)	NOT NULL DEFAULT ''
,MarriageDate	VARCHAR(11)	NOT NULL DEFAULT ''
,MarriageStatus	CHAR(2)	NOT NULL DEFAULT ''
,RecAmount	DECIMAL(10,2) NOT NULL DEFAULT '0.00'
,UpdatedDate	TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00'
,CustVisitCnt	INT(11)	NOT NULL DEFAULT '0'
,CustomerID	INT(11)	NOT NULL DEFAULT 0
,PayStatus	CHAR(1) NOT NULL DEFAULT 'A'	
,PRIMARY KEY (Id)
,UNIQUE KEY uniq_customer (BranchId,CustMobile,Type)
);

-- DROP TABLE IF EXISTS dim_paymode;
CREATE TABLE IF NOT EXISTS dim_paymode (
Id INT(11) NOT NULL AUTO_INCREMENT
,BranchId INT(11) NOT NULL DEFAULT 0 COMMENT 'Id of Dim_Branch table'
,PayMstrID	INT(11)	NOT NULL DEFAULT 0
,PaymodeID	INT(10)	NOT NULL DEFAULT 0
,Descr	VARCHAR(100) NOT NULL DEFAULT ''
,Status	VARCHAR(2) NOT NULL DEFAULT 'N'
,PRIMARY KEY (Id)
,UNIQUE KEY uniq_paymode (BranchId,PaymodeID)
);

-- DROP TABLE IF EXISTS dim_orderstatus;
CREATE TABLE IF NOT EXISTS dim_orderstatus (
Id INT(11) NOT NULL AUTO_INCREMENT
,BranchId INT(11) NOT NULL DEFAULT 0 COMMENT 'Id of Dim_Branch table'
,OrderstatusCode  VARCHAR(2) NOT NULL DEFAULT ''
,OrderStatus VARCHAR(30) NOT NULL DEFAULT ''
,StatusType CHAR(1) NOT NULL DEFAULT '' COMMENT 'U - USER, A - ADMIN, B - BOTH'
,PRIMARY KEY (Id)
,UNIQUE KEY uniq_orderstatus (BranchId,OrderstatusCode)
);

-- DROP TABLE IF EXISTS dim_cardtype;
CREATE TABLE IF NOT EXISTS dim_cardtype (
Id INT(3) NOT NULL AUTO_INCREMENT
,CardID int(3)  NOT NULL DEFAULT 0
,Descr varchar(100)  COLLATE utf8_bin NOT NULL DEFAULT ''
,Status char(10) COLLATE utf8_bin DEFAULT 'Active' 
,PRIMARY KEY (Id)
,UNIQUE KEY uniq_cartype (CardID)
 );
 
-- DROP TABLE IF EXISTS dim_onlinereferal;
CREATE TABLE IF NOT EXISTS dim_onlinereferal (
Id INT(11) NOT NULL AUTO_INCREMENT
,OnlinerefId INT(11) NOT NULL DEFAULT 0
,BranchId INT(11) NOT NULL DEFAULT 0 COMMENT 'Id of Dim_Branch table'
,Descr VARCHAR(100) NOT NULL DEFAULT ''
,Status  VARCHAR(10) NOT NULL DEFAULT 'A'
,Commission DECIMAL(10,2) NOT NULL DEFAULT '0.00'
,AutoSettle CHAR(1) NOT NULL DEFAULT 'N'
,PRIMARY KEY (Id)
,UNIQUE KEY uniq_onlinereferal (BranchId,OnlinerefId)
);


-- DROP TABLE IF EXISTS dim_tablefloor;
CREATE TABLE IF NOT EXISTS dim_tablefloor (
Id INT(11) NOT NULL AUTO_INCREMENT
,BranchId INT(11) NOT NULL DEFAULT 0 COMMENT 'Id of Dim_Branch table'
,TblFloorID INT(11) NOT NULL DEFAULT 0
,TypeId SMALLINT(2) NOT NULL DEFAULT 0
,Descr VARCHAR(300) NOT NULL  DEFAULT ''
,Status VARCHAR(10) DEFAULT 'Active'
,AcFloor CHAR(1) NOT NULL DEFAULT 'N'
,PRIMARY KEY (Id)
,UNIQUE KEY uniq_tablefloor (BranchId,TblFloorID)
 );
 
 -- DROP TABLE IF EXISTS dim_tableno;
CREATE TABLE IF NOT EXISTS dim_tableno (
Id INT(11) NOT NULL AUTO_INCREMENT
,BranchId INT(11) NOT NULL DEFAULT 0 COMMENT 'Id of Dim_Branch table'
,TableNo VARCHAR(6) NOT NULL DEFAULT ''
,DisplayOrder INT(5) NOT NULL DEFAULT 0
,Status CHAR(1) NOT NULL DEFAULT 'A'
,Floor INT(2) NOT NULL DEFAULT 0
,ACtable CHAR(1) NOT NULL DEFAULT 'N'
,PRIMARY KEY (Id)
,UNIQUE KEY uniq_tableno (BranchId,TableNo)
 );

-- DROP TABLE IF EXISTS dim_complimentary;
CREATE TABLE IF NOT EXISTS dim_complimentary (
Id INT(11) NOT NULL AUTO_INCREMENT
,Status CHAR(1) NOT NULL DEFAULT 'N'
,Descr CHAR(4) NOT NULL DEFAULT 'No'
,PRIMARY KEY (Id)
 );
 
-- DROP TABLE IF EXISTS dim_discounttype;
CREATE TABLE IF NOT EXISTS dim_discounttype (
Id INT(11) NOT NULL AUTO_INCREMENT
,DiscType CHAR(1) NOT NULL DEFAULT ''
,Descr VARCHAR(10) NOT NULL DEFAULT ''
,PRIMARY KEY (Id)
 );
 
-- DROP TABLE IF EXISTS dim_splittype;
CREATE TABLE IF NOT EXISTS dim_splittype (
Id INT(11) NOT NULL AUTO_INCREMENT
,SplitType CHAR(1) NOT NULL DEFAULT ''
,Descr VARCHAR(20) NOT NULL DEFAULT ''
,PRIMARY KEY (Id)
 );
 
-- DROP TABLE IF EXISTS dim_date;
CREATE TABLE IF NOT EXISTS dim_date
(
 Id INT(11) NOT NULL AUTO_INCREMENT
, DimensionDate DATE  NOT NULL DEFAULT '0000-00-00'
, DateId BIGINT(11) NOT NULL DEFAULT 0
, Year INT(11) NOT NULL DEFAULT 0
, Quarter INT(11) NOT NULL DEFAULT 0
, Month INT(11) NOT NULL DEFAULT 0
, Day INT(11) NOT NULL DEFAULT 0
, Weekday  INT(11) NOT NULL DEFAULT 0
, MonthName VARCHAR(20) 
, MonthAbbreviation VARCHAR(20) 
, DayName VARCHAR(20) 
, DayAbbreviation VARCHAR(20) 
, YearInDimension INT(11) NOT NULL DEFAULT 0
, QuartersInDimension INT(11) NOT NULL DEFAULT 0
, MonthInDimension INT(11) NOT NULL DEFAULT 0
, DayInYear INT(11) NOT NULL DEFAULT 0
,PRIMARY KEY (Id)
);

-- DROP TABLE IF EXISTS dim_time;
CREATE TABLE IF NOT EXISTS dim_time
(
Id INT(11) NOT NULL AUTO_INCREMENT
, TimeId INT(11)  NOT NULL DEFAULT 0
, Hour INT(11)  NOT NULL DEFAULT 0
, Hour12 INT(11)  NOT NULL DEFAULT 0
, Minute INT(11)  NOT NULL DEFAULT 0
, Second INT(11)  NOT NULL DEFAULT 0
, AMPM VARCHAR(8)
, HMS VARCHAR(8)
, HM VARCHAR(5)
, HMS12 VARCHAR(20)
,PRIMARY KEY (Id)
);
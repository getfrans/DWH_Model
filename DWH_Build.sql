CREATE DATABASE IF NOT EXISTS foodengine_dwh;

DROP TABLE IF EXISTS fact_orderdetail;
CREATE TABLE IF NOT EXISTS fact_orderdetail(
Process_Id INT(11)	NOT NULL AUTO_INCREMENT 
,ProcessDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP 
,Branch_Id	INT(11)	NOT NULL 	DEFAULT 	0
,Order_Id BIGINT(11) NOT NULL	DEFAULT 0
,Customer_Id INT(11)	NOT NULL 	DEFAULT 	0
,OrderType_Id	INT(11)	NOT NULL 	DEFAULT 	0
,Onlineref_Id	INT(11)	NOT NULL 	DEFAULT 	0
,Floor_Id	INT(11) NOT NULL DEFAULT 0
,Table_Id	INT(11)	NOT NULL 	DEFAULT 	0
,Department_Id	INT(11)	NOT NULL 	DEFAULT 	0
,Menu_Id	INT(11)	NOT NULL 	DEFAULT 	0
,Captain_Id	INT(11)	NOT NULL 	DEFAULT 	0
,Waiter_Id	INT(11)	NOT NULL 	DEFAULT 	0
,OrderStatus_Id INT(11)	NOT NULL 	DEFAULT 	0
,DeliveryStatus_Id	INT(11)	NOT NULL 	DEFAULT 	0
,DiscBy_Id SMALLINT(2) NOT NULL DEFAULT 0
,ComplimentaryStatus_Id SMALLINT(1) DEFAULT 0
,SplitType_Id  SMALLINT(1) DEFAULT 0
,Paymode_Id	INT(11)	NOT NULL 	DEFAULT 	0
,CardType_Id	INT(11)	NOT NULL 	DEFAULT 	0
,BillTime_Id	INT(11)	NOT NULL 	DEFAULT 	0
,Createdate_Id	INT(11)	NOT NULL 	DEFAULT 	0
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
,PRIMARY KEY (Process_Id)
,UNIQUE KEY uniq_order (Order_Id,Branch_Id)
,KEY idx_Branch_Id (Branch_Id)
,KEY idx_Order_Id (Order_Id)
,KEY idx_Customer_Id (Customer_Id)
,KEY idx_OrderType_Id (OrderType_Id)
,KEY idx_Onlineref_Id (Onlineref_Id)
,KEY idx_Floor_Id (Floor_Id)
,KEY idx_Table_Id (Table_Id)
,KEY idx_Department_Id (Department_Id)
,KEY idx_Menu_Id (Menu_Id)
,KEY idx_Captain_Id (Captain_Id)
,KEY idx_Waiter_Id (Waiter_Id)
,KEY idx_OrderStatus_Id (OrderStatus_Id)
,KEY idx_DeliveryStatus_Id (DeliveryStatus_Id)
,KEY idx_DiscBy_Id (DiscBy_Id)
,KEY idx_ComplimentaryStatus_Id (ComplimentaryStatus_Id)
,KEY idx_SplitType_Id (SplitType_Id)
,KEY idx_Paymode_Id (Paymode_Id)
,KEY idx_CardType_Id (CardType_Id)
,KEY idx_BillTime_Id (BillTime_Id)
,KEY idx_Createdate_Id (Createdate_Id)
,KEY idx_CreateDate (CreateDate)
);

DROP TABLE IF EXISTS dim_ordertype;
CREATE TABLE IF NOT EXISTS dim_ordertype (
Id INT(11) NOT NULL AUTO_INCREMENT
,OrderType_code varchar(3) DEFAULT NULL
,OrderType_Desc varchar(20) DEFAULT NULL
,PRIMARY KEY (Id)
,UNIQUE KEY uniq_branch (OrderType_code)
);

DROP TABLE IF EXISTS dim_branch;
CREATE TABLE IF NOT EXISTS dim_branch (
Id INT(11) NOT NULL AUTO_INCREMENT
,RestID int(11) NOT NULL
,BranchID varchar(11) NOT NULL
,BranchName  varchar(30) NOT NULL
,CreatedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
,Location_Id INT(11) NOT NULL DEFAULT 0
,PRIMARY KEY (Id)
,UNIQUE KEY uniq_branch (RestID,BranchID)
,KEY idx_RestID (RestID)
,KEY idx_BranchID (BranchID)
);

DROP TABLE IF EXISTS dim_combotype;
CREATE TABLE dim_combotype (
Id INT(11) NOT NULL AUTO_INCREMENT
,comboCode char(1) NOT NULL 
,ComboDesc varchar(10) NOT NULL 
,PRIMARY KEY (Id)
,UNIQUE KEY uniq_combo (comboCode)
);
INSERT INTO dim_combotype (comboCode,ComboDesc) VALUES 
('S','Single'),('M','Multiple'),('F','Modifier');


DROP TABLE IF EXISTS dim_department;
CREATE TABLE IF NOT EXISTS dim_department (
Id INT(11) NOT NULL AUTO_INCREMENT
,Branch_Id INT(11) NOT NULL DEFAULT 0 COMMENT 'Id of Dim_Branch table'
,DeptID int(11) NOT NULL
,DeptName varchar(100) COLLATE utf8_bin NOT NULL
,NoofItems int(11) NOT NULL
,KotTitle varchar(100) COLLATE utf8_bin DEFAULT 'Kitchen Copy'
,CreatedDate timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
,Createdby int(11) DEFAULT NULL
,PRIMARY KEY (Id)
,UNIQUE KEY uniq_department (Branch_Id,DeptID)
,KEY idx_Branch_Id (Branch_Id)
,KEY idx_DeptID (DeptID)
);

DROP TABLE IF EXISTS dim_menuitem;
CREATE TABLE IF NOT EXISTS dim_menuitem (
Id INT(11) NOT NULL AUTO_INCREMENT
,Branch_Id INT(11) NOT NULL DEFAULT 0 COMMENT 'Id of Dim_Branch table'
,MenuId VARCHAR(15) CHARACTER SET latin1 NOT NULL
,Code VARCHAR(30) CHARACTER SET latin1 DEFAULT NULL
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
,Dept_ID INT(11) DEFAULT '0' COMMENT 'Id of Dim_Department table'
,RewardPoints decimal(10,2) DEFAULT '0.00'
,LockType CHAR(10) CHARACTER SET latin1 DEFAULT 'Temporary' 
,ItemType CHAR(10) CHARACTER SET latin1 DEFAULT NULL
,CreatedDate_Id INT(11) NOT NULL DEFAULT 0
,CreatedDate TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP
,LastUpdated TIMESTAMP NULL DEFAULT '0000-00-00 00:00:00'
,ComboType_Id INT(4) NOT NULL DEFAULT 0 COMMENT 'Id of combotype dim table'
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
,UNIQUE KEY uniq_menu (Branch_Id,MenuId)
,KEY idx_Branch_Id (Branch_Id)
,KEY idx_MenuId (MenuId)
,KEY idx_ComboType_Id (ComboType_Id)
);

DROP TABLE IF EXISTS dim_waiter;
CREATE TABLE IF NOT EXISTS dim_waiter (
Id INT(11) NOT NULL AUTO_INCREMENT
,Branch_Id INT(11) NOT NULL DEFAULT 0 COMMENT 'Id of Dim_Branch table'
,EmpCode varchar(30) NOT NULL
,WaiterName varchar(30) DEFAULT NULL
,Status char(1) DEFAULT NULL COMMENT 'E- Employee,C- Captain, W- Waiter'
,EmpStatus char(1) DEFAULT 'A'
,PRIMARY KEY (Id)
,UNIQUE KEY uniq_branch (Branch_Id,EmpCode)
);
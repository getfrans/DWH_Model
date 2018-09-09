
-- ### Source SQL

SELECT a.restid, a.branchID, a.orderid, a.billno, a.userid, a.orderstatus,
DATE_FORMAT(a.billdate,'%d-%m-%Y') AS BillDate, a.ordertype, a.onlineref, b.itemID, b.Itemprice, b.itemqty, a.orderprice, a.discper,
a.discprice, a.discby, a.servicetax, a.servCHARgetax, a.parcelCHARge, a.captainID, a.waiterId, a.nofpeople, a.tableno,
a.custmob, a.splittype, a.totalprice, b.halltype, b.itemcomplementary, a.paymentmode, b.itemprice + b.taxamount AS "Sale Amount",
createdate
FROM sr_orders_tbl a  LEFT JOIN  sr_order_smry_tbl b ON a.orderid=b.orderid

--Business Rule for Fact table
WHERE billtype="B" AND billedstatus="Y" AND a.billdate BETWEEN "2018-06-20" AND "2018-06-30"
ORDER BY a.restid, a.branchID, a.billdate, a.orderid ;


Department Id required
Discount
complimentary

--### Master Information 

menumaster - sr_menumstr_tbl
departmaster - sr_department_mstr
admins - sr_admins_tbl
branchestbl - sr_branches_tbl
branchtypetbl - sr_branchtype_tbl
waitername - sr_waiter_name_tbl
paymodemstr - sr_paymode_mstr
cardmstr - sr_cardmstr_tbl
onlinerefermast - sr_onlinereferal_mstr

---####################
SELECT a.restid, a.branchID, a.orderid, a.billno, a.userid, a.orderstatus,
DATE_FORMAT(a.billdate,'%d-%m-%Y') AS BillDate, a.ordertype, a.onlineref, b.itemID, b.Itemprice, b.itemqty, a.orderprice, a.discper,
a.discprice, a.discby, a.servicetax, a.servCHARgetax, a.parcelCHARge, a.captainID, a.waiterId, a.nofpeople, a.tableno,
a.custmob, a.splittype, a.totalprice, b.halltype, b.itemcomplementary, a.paymentmode, b.itemprice + b.taxamount AS "Sale Amount",
a.createdate, a.floorid
FROM sr_orders_tbl a  LEFT JOIN  sr_order_smry_tbl b ON a.orderid=b.orderid
WHERE billtype="B" AND billedstatus="Y" AND a.billdate BETWEEN "2018-06-20" AND "2018-06-30"
ORDER BY a.restid, a.branchID, a.billdate, a.orderid

menumaster - sr_menumstr_tbl
departmaster - sr_department_mstr
admins - sr_admins_tbl
branchestbl - sr_branches_tbl
branchtypetbl - sr_branchtype_tbl
waitername - sr_waiter_name_tbl
paymodemstr - sr_paymode_mstr
cardmstr - sr_cardmstr_tbl
onlinerefermast - sr_onlinereferal_mstr
custmstr - sr_custmaster_tbl
floormstr - sr_tablefloor_mstr
--------------------------------

SELECT a.RestID, a.BranchID, a.CustMobile, b.feedbackID, b.questid, b.ratings, b.comments,
    a.Orderid, a.empcode, a.tableno
FROM sr_custfeedback_tbl a LEFT JOIN sr_custfeedbacksmry_tbl b ON a.feedbackid = b.feedbackid
ORDER BY a.RestID, a.BranchID, a.CustMobile, b.feedbackID, b.questid

feedbackmstr - sr_feedback_mstr (ID)
------------------------------------

List of dimension to be created 
	Branch
	Customer
	OrderType
	Onlineref
	Floor
	Servicetable
	Department
	Menu
	Captain
	Waiter
	OrderStatus
	Deliverystatus
	DiscountBy
	Complimentary
	SplitType
	Paymmode
	CardType
	BillTime

	Location --Customize Dim
	DateDim --Customize Dim
	
menumaster - sr_menumstr_tbl  -- done
departmaster - sr_department_mstr  --done
admins - sr_admins_tbl
branchestbl - sr_branches_tbl  --done
branchtypetbl - sr_branchtype_tbl --done
waitername - sr_waiter_name_tbl-- done
paymodemstr - sr_paymode_mstr  -- done
cardmstr - sr_cardmstr_tbl --done 
onlinerefermast - sr_onlinereferal_mstr --done

--Business Rule for branch dim table: 
BranchType - COMMENT 'Branch order options ( B - Both Delivery & Pickup, D - Delivery only , P - Pickup'
(orderType)

--Business Rule for menuitem dim table: 
ItemLevel VARCHAR(1) CHARACTER SET latin1 NOT NULL COMMENT '1 - Parent Level, 2 - Child Level',
ItemParent VARCHAR(11) CHARACTER SET latin1 NOT NULL COMMENT 'null - if root node, menu item id of parent node',
ItemStatus VARCHAR(1) CHARACTER SET latin1 NOT NULL DEFAULT 'A' COMMENT 'A - active, I - Inactive',
ItemHide VARCHAR(1) CHARACTER SET latin1 DEFAULT 'A' COMMENT 'A - active, I - Inactive',
LockType CHAR(1) CHARACTER SET latin1 DEFAULT 'T' COMMENT 'T - Temporary, P -Permanent',
ItemType CHAR(1) CHARACTER SET latin1 DEFAULT NULL COMMENT 'V-Veg,N- Non VEG',
MenuType CHAR(1) CHARACTER SET latin1 DEFAULT 'L'

Business  rule dim_Cardrype
Status char(5) COLLATE utf8_bin DEFAULT 'A' COMMENT 'A - Active , I - Inactive',

-- #######
-- Dim Load Order 
1.Branch 
2.Department 
3.Combotype
4.Ordertype
5.CardType
6.Complimentary
7.Customer
8.DiscountType
9.Splittype
10.Menuitem
11.Waiter
12.Onlinereferal
13.Tablefloor
14.Tableno
15.Orderstatus
16.Paymode

PAYMODE
MenuItem 
Has the filter rows for Branch


Build.sql
DB Dumb
Cube XML


Error Handling
CDC logic


INSERT INTO dim_combotype (ComboCode,ComboDesc) VALUES 
('S','Single'),('M','Multiple'),('F','Modifier');

INSERT INTO dim_subscribeuser(RestCode) SELECT  DISTINCT RestId  FROM foodengine_ho.sr_branches_tbl;

BIuserAccount
insert into foodengine_dwh.dim_biuseraccount (LoginUserName,RestCode,BranchCode,BranchId) 
select 'Admin' as LoginUserName,RestCode,BranchCode,Id from foodengine_dwh.dim_branch;


Steps for Execution 

1) Run DWH_Default_Setup.bat
2) Run DWH_Subscriber_Entry.bat
3) Run DWH_Initial_Load.bat


DynamicSchemaProcessor
com.mondriandsp.DynamicSchemaProcessor
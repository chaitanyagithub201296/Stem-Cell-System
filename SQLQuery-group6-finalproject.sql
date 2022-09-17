-- Down Script


--Stem Cell Donation

if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
    where CONSTRAINT_NAME='FK_cell_donation_cell_type')
    alter table cell_donation drop constraint FK_cell_donation_cell_type

drop table if exists cell_donation

if exists(select * from sys.objects where name='blood_donation')
	drop table blood_donation

if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
    where CONSTRAINT_NAME='FK_blood_bank_blood_bank_lab_id')
    alter table blood_bank drop constraint FK_blood_bank_blood_bank_lab_id

drop table if exists blood_bank

if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
    where CONSTRAINT_NAME='FK_cell_cell_lab_id')
    alter table cell drop constraint FK_cell_cell_lab_id

drop table if exists cell

if exists(select * from sys.objects where name='lab')
	drop table lab

GO


-- Up Script

CREATE TABLE [dbo].[lab](
	[lab_id] [int]NOT NULL,
    [lab_name] [varchar](50) NOT NULL,
    [lab_location] [varchar](50) NOT NULL,
    [lab_capacity] [int] NOT NULL,
    [lab_num_researchers] [int] NULL,
    [lab_type] [varchar](60) NOT NULL,
    [lab_blood_type] [varchar](60) NOT NULL,
    [lab_blood_bank_id] [int] NOT NULL,
    [lab_cell_id] [int] NOT NULL,

 CONSTRAINT [PK_lab_lab_id] PRIMARY KEY ([lab_id])
 )


CREATE TABLE [dbo].[cell](
	[cell_id] [int] NOT NULL,
    [cell_name] [varchar](50) NOT NULL,
    [cell_type] [varchar](50) NOT NULL,
    [cell_source] [varchar](50) NOT NULL,
    [cell_purpose] [varchar](100) NOT NULL,
    [cell_lab_id] [int] NOT NULL,

 CONSTRAINT [PK_cell_cell_type] PRIMARY KEY ([cell_type]),

 CONSTRAINT [FK_cell_cell_lab_id] FOREIGN KEY (cell_lab_id) REFERENCES lab(lab_id)
 )


CREATE TABLE [dbo].[blood_bank](
	[blood_bank_id] [int] NOT NULL,
    [blood_bank_name] [varchar](50) NOT NULL,
    [blood_bank_region] [varchar](40) NOT NULL,
    [blood_bank_street] [varchar](40) NOT NULL,
    [blood_bank_capacity] [int] NOT NULL,
    [blood_bank_assistants] [int] NULL,
    [blood_bank_ph_num] [varchar](20) NOT NULL,
    [blood_bank_lab_id] [int] NOT NULL,
    [blood_bank_blood_donor_id] [int] NOT NULL,

 CONSTRAINT [FK_blood_bank_blood_bank_lab_id] FOREIGN KEY (blood_bank_lab_id) REFERENCES lab(lab_id),
 )  


CREATE TABLE [dbo].[blood_donation](
	[blood_donor_id] [int] NOT NULL,
    [blood_donor_fname] [varchar](50) NOT NULL,
    [blood_donor_lname] [varchar](50) NOT NULL,
    [blood_donor_region] [varchar](20) NOT NULL,
    [blood_donor_street] [varchar](20) NOT NULL,
    [blood_donor_city] [varchar](20) NOT NULL,
    [blood_donor_zip] [varchar](20) NOT NULL,
    [blood_donor_blood_type] [varchar](20) NOT NULL,
    [blood_donor_blood_bank_id] [int] NOT NULL,

 CONSTRAINT [PK_blood_donation_blood_donor_id] PRIMARY KEY ([blood_donor_id]),
 )  


CREATE TABLE [dbo].[cell_donation](
	[cell_donor_id] [int] NOT NULL,
    [cell_donor_fname] [varchar](50) NOT NULL,
    [cell_donor_lname] [varchar](50) NOT NULL,
    [cell_type] [varchar](50) NOT NULL,

 CONSTRAINT [PK_cell_donation_cell_donor_id] PRIMARY KEY ([cell_donor_id]),

 CONSTRAINT [FK_cell_donation_cell_type] FOREIGN KEY (cell_type) REFERENCES cell(cell_type)
 ) 


INSERT [dbo].[lab] ([lab_id], [lab_name], [lab_location], [lab_capacity], [lab_num_researchers], [lab_type], [lab_blood_type], [lab_blood_bank_id], [lab_cell_id])
VALUES (1, N'LeukoLab', N'Syracuse', 5000,100, N'Whole Blood Donation and Platelet Donation', N'Group B',101, 10)

INSERT [dbo].[lab] ([lab_id], [lab_name], [lab_location], [lab_capacity], [lab_num_researchers], [lab_type], [lab_blood_type], [lab_blood_bank_id], [lab_cell_id]) 
VALUES (2, N'RedCrossBlood', N'Newark',7500,80,N'Plasma Donation and Power Red Donation, Whole Blood Donation', N'Group(A,B,AB,O)',102, 11)

INSERT [dbo].[lab] ([lab_id], [lab_name], [lab_location], [lab_capacity], [lab_num_researchers], [lab_type], [lab_blood_type], [lab_blood_bank_id], [lab_cell_id]) 
VALUES (3, N'NYBloodCenter', N'New York City',12500,150, N'Platelet Donation and Plasma Donation', N'Group(B,AB,O)',103, 12)

INSERT [dbo].[lab] ([lab_id], [lab_name], [lab_location], [lab_capacity], [lab_num_researchers], [lab_type], [lab_blood_type], [lab_blood_bank_id], [lab_cell_id]) 
VALUES (4, N'LabCorp', N'Syracuse',3000,50, N'Platelet Donation and Plasma Donation', N'Group(B,AB,O)',104, 13)

INSERT [dbo].[lab] ([lab_id], [lab_name], [lab_location], [lab_capacity], [lab_num_researchers], [lab_type], [lab_blood_type], [lab_blood_bank_id], [lab_cell_id]) 
VALUES (5, N'Sanofi Genzyme', N'Syracuse',10500,90, N'Plasma Donation and Whole Blood Donation', N'Group(A,B,AB,O)',105, 14)

INSERT [dbo].[lab] ([lab_id], [lab_name], [lab_location], [lab_capacity], [lab_num_researchers], [lab_type], [lab_blood_type], [lab_blood_bank_id], [lab_cell_id]) 
VALUES (6, N'ARUP Laboratories', N'New York City City', N'8000',N'200', N'Platelet Donation and Power Red Donation', N'Group(B,O)',106, 15)
GO

INSERT [dbo].[cell] ([cell_id], [cell_name], [cell_type], [cell_source], [cell_purpose], [cell_lab_id]) 
VALUES (11,N'Stem Cell',N'Totipotent',N'Adult Stem Cell', N'Differentiate into all possible cell types', 2)

INSERT [dbo].[cell] ([cell_id], [cell_name], [cell_type], [cell_source], [cell_purpose], [cell_lab_id]) 
VALUES (12,N'Stem Cell',N'Multipotent',N'Embryonic Stem Cell' , N'Differentiate into a closely related family of cells', 3)

INSERT [dbo].[cell] ([cell_id], [cell_name], [cell_type], [cell_source], [cell_purpose], [cell_lab_id]) 
VALUES (13,N'Stem Cell',N'Oligopotent',N'Induced pluripotent stem cells',N'Differentiate into a few different cell types.',4)

INSERT [dbo].[cell] ([cell_id], [cell_name], [cell_type], [cell_source], [cell_purpose], [cell_lab_id]) 
VALUES (14,N'Stem Cell',N'Unipotent',N'Embryonic stem cells', N'Only produce cells of one kind, which is their own type', 5)

INSERT [dbo].[cell] ([cell_id], [cell_name], [cell_type], [cell_source], [cell_purpose], [cell_lab_id]) 
VALUES (15,N'Stem Cell',N'Pluripotent',N'Adult stem cells', N'Turn into almost any cell', 6)
GO

INSERT [dbo].[blood_bank] ([blood_bank_id], [blood_bank_name], [blood_bank_region], [blood_bank_street], [blood_bank_capacity], [blood_bank_assistants], [blood_bank_ph_num], [blood_bank_lab_id], [blood_bank_blood_donor_id]) 
VALUES (101, N'Upstate Cord Blood Bank', N'Syracuse', N'4910 Broad Rd', 14500, 100, N'6709108678',1,50)

INSERT [dbo].[blood_bank] ([blood_bank_id], [blood_bank_name], [blood_bank_region], [blood_bank_street], [blood_bank_capacity], [blood_bank_assistants], [blood_bank_ph_num], [blood_bank_lab_id], [blood_bank_blood_donor_id]) 
VALUES (102, N'New Jersey Cord Blood Bank', N'Newark', N'170 Park Ave', 10500, 80, N'3156901234',2,51)

INSERT [dbo].[blood_bank] ([blood_bank_id], [blood_bank_name], [blood_bank_region], [blood_bank_street], [blood_bank_capacity], [blood_bank_assistants], [blood_bank_ph_num], [blood_bank_lab_id], [blood_bank_blood_donor_id]) 
VALUES (103, N'New York Blood Center', N'New York City', N'East 67th Street', 11000, 150, N'8156795687',3,52)

INSERT [dbo].[blood_bank] ([blood_bank_id], [blood_bank_name], [blood_bank_region], [blood_bank_street], [blood_bank_capacity], [blood_bank_assistants], [blood_bank_ph_num], [blood_bank_lab_id], [blood_bank_blood_donor_id]) 
VALUES (101, N'Upstate Cord Blood Bank', N'Syracuse', N'4910 Broad Rd',14500, 100, N'6709108678',4,53)

INSERT [dbo].[blood_bank] ([blood_bank_id], [blood_bank_name], [blood_bank_region], [blood_bank_street], [blood_bank_capacity], [blood_bank_assistants], [blood_bank_ph_num], [blood_bank_lab_id], [blood_bank_blood_donor_id]) 
VALUES (105, N'Cord Blood Bank', N'Syracuse', N'Westcott Street', 14000, 200, N'5709108678',5,54)

INSERT [dbo].[blood_bank] ([blood_bank_id], [blood_bank_name], [blood_bank_region], [blood_bank_street], [blood_bank_capacity], [blood_bank_assistants], [blood_bank_ph_num], [blood_bank_lab_id], [blood_bank_blood_donor_id]) 
VALUES (106, N'NNY Blood Bank', N'New York City', N'EastAvenue Street',15500, 180, N'9701108678',6,55)
GO

INSERT [dbo].[blood_donation] ([blood_donor_id], [blood_donor_fname], [blood_donor_lname], [blood_donor_region], [blood_donor_street], [blood_donor_city], [blood_donor_zip], [blood_donor_blood_type], [blood_donor_blood_bank_id]) 
VALUES (50, N'Ron', N'Hemsworth', N'Syracuse', N'Harrison Street', N'Syracuse', N'13202',N'Group B',101)

INSERT [dbo].[blood_donation] ([blood_donor_id], [blood_donor_fname], [blood_donor_lname], [blood_donor_region], [blood_donor_street], [blood_donor_city], [blood_donor_zip], [blood_donor_blood_type], [blood_donor_blood_bank_id]) 
VALUES (51, N'Alexa', N'Williams', N'New Jersey', N'Princeton Street', N'New Jersey', N'07646',N'Group O',102)

INSERT [dbo].[blood_donation] ([blood_donor_id], [blood_donor_fname], [blood_donor_lname], [blood_donor_region], [blood_donor_street], [blood_donor_city], [blood_donor_zip], [blood_donor_blood_type], [blood_donor_blood_bank_id]) 
VALUES (52, N'Lilly', N'Scott', N'New York City', N'5th Avenue Street', N'New York City', N'10016',N'Group AB',103)

INSERT [dbo].[blood_donation] ([blood_donor_id], [blood_donor_fname], [blood_donor_lname], [blood_donor_region], [blood_donor_street], [blood_donor_city], [blood_donor_zip], [blood_donor_blood_type], [blood_donor_blood_bank_id]) 
VALUES (53, N'Michael', N'Daniels', N'Syracuse', N'Comstock Street', N'Syracuse', N'13202',N'Group O',101)

INSERT [dbo].[blood_donation] ([blood_donor_id], [blood_donor_fname], [blood_donor_lname], [blood_donor_region], [blood_donor_street], [blood_donor_city], [blood_donor_zip], [blood_donor_blood_type], [blood_donor_blood_bank_id]) 
VALUES (54, N'Lewk', N'Wright', N'Syracuse', N'Maple Street', N'Syracuse', N'13202',N'Group B',105)

INSERT [dbo].[blood_donation] ([blood_donor_id], [blood_donor_fname], [blood_donor_lname], [blood_donor_region], [blood_donor_street], [blood_donor_city], [blood_donor_zip], [blood_donor_blood_type], [blood_donor_blood_bank_id]) 
VALUES (55, N'Danny', N'Morrison', N'New York City', N'5th Avenue Street', N'New York City', N'10016',N'Group O',106)
GO

INSERT [dbo].[cell_donation] ([cell_donor_id], [cell_donor_fname], [cell_donor_lname], [cell_type]) 
VALUES (123, N'Jonny', N'Fredie', N'Totipotent')

INSERT [dbo].[cell_donation] ([cell_donor_id], [cell_donor_fname], [cell_donor_lname], [cell_type]) 
VALUES (124, N'Leo', N'Musk', N'Multipotent')

INSERT [dbo].[cell_donation] ([cell_donor_id], [cell_donor_fname], [cell_donor_lname], [cell_type]) 
VALUES (125, N'Catherine', N'McBroom', N'Unipotent')

INSERT [dbo].[cell_donation] ([cell_donor_id], [cell_donor_fname], [cell_donor_lname], [cell_type]) 
VALUES (126, N'Cassey', N'Broom', N'Unipotent')
GO

select * from lab

select * from cell

select * from blood_bank

select * from blood_donation

select * from cell_donation


--How many lab researchers assigned in capacity for top 3 largest blood banks ?

SELECT top 3 lab_name,lab_num_researchers, blood_bank_capacity
FROM blood_bank
JOIN lab ON blood_bank.blood_bank_lab_id = lab.lab_id
GROUP BY blood_bank_capacity 
ORDER BY blood_bank_capacity DESC


--List of people who donated blood in city with  zip code starting from 13. 

SELECT blood_donor_fname +' '+blood_donor_lname as blood_donor_name ,blood_bank_region , blood_bank_name
FROM blood_donation
JOIN blood_bank ON blood_donation.blood_donor_id = blood_bank.blood_bank_blood_donor_id
WHERE blood_donor_zip LIKE '13%'


--Comparison of lab and blood bank in terms of their capacity to workers 

SELECT DISTINCT ((lab_capacity)/(lab_num_researchers)) as ratio_lab,((blood_bank_capacity)/(blood_bank_assistants)) as ratio_blood_bank
FROM lab
JOIN blood_bank ON lab.lab_blood_bank_id = blood_bank.blood_bank_id
ORDER BY ratio_blood_bank DESC


--List of donors from new york city alongwith their blood groups they can donate to.

SELECT blood_donor_fname +' '+blood_donor_lname as blood_donor_name, blood_donor_blood_type,
CASE
    WHEN blood_donor_blood_type = 'GROUP A' THEN 'GROUP A AND AB'
    WHEN blood_donor_blood_type = 'GROUP B' THEN 'GROUP A AND AB'
    WHEN blood_donor_blood_type = 'GROUP AB' THEN 'GROUP AB'
    WHEN blood_donor_blood_type = 'GROUP O' THEN 'GROUP A, B, AB AND O'
END AS donate_to
FROM blood_donation
WHERE blood_donor_region = 'New York City'


--Retrieval of name of lab and blood bank based on cell source

SELECT lab_name,blood_bank_name,cell_source
from lab l
join cell c on l.lab_id=c.cell_lab_id
join blood_bank b on l.lab_id=b.blood_bank_lab_id
where cell_source like 'Adult%' OR cell_source like 'Embryonic%'


--Updating of blood donor’s blood bank for next time

drop procedure if exists p_upsert_blood_donation_banks
GO

create procedure p_upsert_blood_donation_banks (
@blood_donor_id int,
@blood_donor_blood_bank_id int
) as begin
if exists(select * from blood_donation where blood_donor_id = @blood_donor_id) begin 
update blood_donation  set blood_donor_blood_bank_id = @blood_donor_blood_bank_id  
where blood_donor_id = @blood_donor_id
end
else begin
insert into blood_donation (blood_donor_id, blood_donor_blood_bank_id) 
values (@blood_donor_id, @blood_donor_blood_bank_id)
end
end 
GO

select * from blood_donation 

exec dbo.p_upsert_blood_donation_banks 50, 101

exec dbo.p_upsert_blood_donation_banks 50, 102

select * from blood_donation 

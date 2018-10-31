
-- File name: to generate SQL tables All Tables

USE [Proj3_607]
GO

/****** Object:  Table [dbo].[characteristics]    Script Date: 10/31/2018 12:21:36 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[characteristics](
	[A] [varchar](50) NULL,
	[Title] [varchar](50) NULL,
	[SOC] [varchar](50) NULL,
	[OccupationType] [varchar](50) NULL,
	[2016Employment] [varchar](50) NULL,
	[2026Employment] [varchar](50) NULL,
	[2016EmplChange2016-26] [varchar](50) NULL,
	[2026EmplChange2016-26] [varchar](50) NULL,
	[2016Self-Empl_Prcnt] [varchar](50) NULL,
	[2016-26_AvgAnnual_OccOpenings] [varchar](50) NULL,
	[2017MedianAnnualWage] [varchar](50) NULL,
	[TypicalEntryLvlEduc] [varchar](50) NULL,
	[PreEmplExperience] [varchar](50) NULL,
	[PostEmplTraining] [varchar](50) NULL
) ON [PRIMARY]
GO


CREATE TABLE [dbo].[indeed_keyword_count_ca](
	[RowNum] [varchar](50) NULL,
	[Keyword] [varchar](50) NULL,
	[n] [varchar](50) NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[salary](
	[""] [varchar](50) NULL,
	["SOC"] [varchar](50) NULL,
	["No Employees"] [varchar](50) NULL,
	["RSE"] [varchar](50) NULL,
	["Mean Hourly Wage"] [varchar](50) NULL,
	["Mean Annual Wage"] [varchar](50) NULL,
	["Wage RSE"] [varchar](50) NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[skills](
	[""] [varchar](50) NULL,
	["SOC"] [varchar](50) NULL,
	["Active Learning"] [varchar](50) NULL,
	["Active Listening"] [varchar](50) NULL,
	["Complex Problem Solving"] [varchar](50) NULL,
	["Coordination"] [varchar](50) NULL,
	["Critical Thinking"] [varchar](50) NULL,
	["Equipment Maintenance"] [varchar](50) NULL,
	["Equipment Selection"] [varchar](50) NULL,
	["Installation"] [varchar](50) NULL,
	["Instructing"] [varchar](50) NULL,
	["Judgment and Decision Making"] [varchar](50) NULL,
	["Learning Strategies"] [varchar](50) NULL,
	["Management of Financial Resources"] [varchar](50) NULL,
	["Management of Material Resources"] [varchar](50) NULL,
	["Management of Personnel Resources"] [varchar](50) NULL,
	["Mathematics"] [varchar](50) NULL,
	["Monitoring"] [varchar](50) NULL,
	["Negotiation"] [varchar](50) NULL,
	["Operation and Control"] [varchar](50) NULL,
	["Operation Monitoring"] [varchar](50) NULL,
	["Operations Analysis"] [varchar](50) NULL,
	["Persuasion"] [varchar](50) NULL,
	["Programming"] [varchar](50) NULL,
	["Quality Control Analysis"] [varchar](50) NULL,
	["Reading Comprehension"] [varchar](50) NULL,
	["Repairing"] [varchar](50) NULL,
	["Science"] [varchar](50) NULL,
	["Service Orientation"] [varchar](50) NULL,
	["Social Perceptiveness"] [varchar](50) NULL,
	["Speaking"] [varchar](50) NULL,
	["Systems Analysis"] [varchar](50) NULL,
	["Systems Evaluation"] [varchar](50) NULL,
	["Technology Design"] [varchar](50) NULL,
	["Time Management"] [varchar](50) NULL,
	["Troubleshooting"] [varchar](50) NULL,
	["Writing"] [varchar](50) NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[TechnicalSkillsONET](
	[F1] [float] NULL,
	[jobNoNA] [nvarchar](255) NULL,
	[jobcodeNoNA] [nvarchar](255) NULL,
	[Apache Cassandra] [float] NULL,
	[Apache Hadoop] [float] NULL,
	[Apache Hive] [float] NULL,
	[Apache Pig] [float] NULL,
	[C] [float] NULL,
	[C# ] [float] NULL,
	[C++ ] [float] NULL,
	[Computational statistics software] [float] NULL,
	[Django] [float] NULL,
	[Hypertext markup language HTML] [float] NULL,
	[IBM SPSS Statistics] [float] NULL,
	[JavaScript] [float] NULL,
	[JavaScript Object Notation JSON] [float] NULL,
	[Micosoft SQL Server Analysis Services SSAS] [float] NULL,
	[Microsoft SQL Server] [float] NULL,
	[Microsoft SQL Server Integration Services SSIS] [float] NULL,
	[MongoDB] [float] NULL,
	[MySQL] [float] NULL,
	[NCR Teradata Warehouse Miner] [float] NULL,
	[NeuroSolutions for MatLab] [float] NULL,
	[NoSQL] [float] NULL,
	[Oracle Java] [float] NULL,
	[Oracle JavaServer Pages JSP] [float] NULL,
	[Oracle PL/SQL] [float] NULL,
	[Oracle SQL Loader] [float] NULL,
	[Oracle SQL Plus] [float] NULL,
	[PostgreSQL] [float] NULL,
	[Python                                                          ] [float] NULL,
	[R] [float] NULL,
	[Redgate SQL Server] [float] NULL,
	[Ruby] [float] NULL,
	[Ruby on Rails] [float] NULL,
	[SAS] [float] NULL,
	[SAS Enterprise Miner] [float] NULL,
	[SAS JMP] [float] NULL,
	[SAS/CONNECT] [float] NULL,
	[STATISTICA] [float] NULL,
	[Statistical software] [float] NULL,
	[Statistical Solutions BMDP] [float] NULL,
	[Structured query language SQL] [float] NULL,
	[Sun Microsystems Java 2 Platform Enterprise Edition J2EE] [float] NULL,
	[SuperANOVA] [float] NULL,
	[Tableau] [float] NULL,
	[Teradata Enterprise Data Warehouse] [float] NULL,
	[The MathWorks MATLAB] [float] NULL,
	[UNISTAT Statistical Package] [float] NULL
) ON [PRIMARY]
GO



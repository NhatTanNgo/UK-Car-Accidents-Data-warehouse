use master
go
create database [MetaData_DATH]
go
USE MetaData_DATH
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Data_Flow](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[LSET] [datetime] NULL,
	[CET] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

--This proc is used to add a new row into metadata if it doesn't exsist
--If it's exists, update CET then return CET and LSET
--Name rule: [TableName_Stage|DDS]
--Ex: Accidents_Stage
CREATE PROCEDURE GET_CET_LSET 
@name NVARCHAR(50)
AS
BEGIN 
DECLARE
	@result NVARCHAR(50),
	@date DATETIME
SELECT @date = GETDATE(),
	   @result = NULL

	SELECT @result = Name
	FROM dbo.Data_Flow
	WHERE Name = @name

	IF(@result IS NULL)
		BEGIN
			INSERT INTO dbo.Data_Flow
			VALUES
			(   @name,        -- Name - varchar(50)
			    '1/1/1900', -- LSET - datetime
			    @date  -- CET - datetime
			)
		END;
	ELSE
		BEGIN
			UPDATE dbo.Data_Flow
			SET CET = @date
			WHERE Name = @result
		END;

	SELECT LSET, @date CET
	FROM dbo.Data_Flow
	WHERE Name = @name
END 

--EXEC dbo.GET_CET_LSET  N'test' -- nvarchar(50)
--TRUNCATE TABLE dbo.Data_Flow

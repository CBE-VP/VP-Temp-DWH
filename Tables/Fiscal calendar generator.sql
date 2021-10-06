
DECLARE
   @MyFiscalDateStart  DATE = '20191001'
 , @MyFiscalMonthStart INT
 , @OffSet             INT;
SET @MyFiscalMonthStart = MONTH(@MyFiscalDateStart);

--SELECT
--   @MyFiscalDateStart
-- , @MyFiscalMonthStart;

SET @OffSet = @MyFiscalMonthStart - 1;
--SELECT
--   @OffSet

;
WITH CTE_DatesTable
AS (
   SELECT
   MyDate = @MyFiscalDateStart

   UNION ALL

   SELECT
   DATEADD(DAY, 1, MyDate)
   FROM CTE_DatesTable
   WHERE DATEADD(DAY, 1, MyDate) < DATEADD(YEAR, 10, @MyFiscalDateStart) -- goes 10 years out, can change number part to suit your needs
   )

SELECT
DateKey = MyDate,
CalMonthNumber    = DATEPART(MONTH, MyDate),
FiscalMonthNumber = CASE
                          WHEN DATEPART(MONTH, MyDate) - @OffSet < 0
                          THEN (DATEPART(MONTH, MyDate) - @OffSet) + 12
                          WHEN DATEPART(MONTH, MyDate) - @OffSet = 0
                          THEN 12
                          ELSE DATEPART(MONTH, MyDate) - @OffSet
                       END,
MonthLongName     = DATENAME(MONTH, MyDate),
MonthShortName    = SUBSTRING(LTRIM(DATENAME(MONTH, MyDate)), 0, 4),
CalendarYear      = DATEPART(YEAR, MyDate),
CalQtrNumber      = DATENAME(QUARTER, MyDate),
FYQtrNumber       = CASE
                    WHEN MyDate >= DATEADD(MONTH, -12, DATEADD(MONTH
                                                         , 13 - CASE
                                                                   WHEN DATEPART(MONTH, MyDate) - @OffSet < 0
                                                                   THEN (DATEPART(MONTH, MyDate) - @OffSet) + 12
                                                                   WHEN DATEPART(MONTH, MyDate) - @OffSet = 0
                                                                   THEN 12
                                                                   ELSE DATEPART(MONTH, MyDate) - @OffSet
                                                                END
                                                         , DATEADD(DAY, 1, EOMONTH(MyDate, -1))
                                                        )
                                                )

                               AND MyDate < DATEADD(MONTH, 3, DATEADD(MONTH
                                                          , -12
                                                          , DATEADD(  MONTH
                                                                    , 13 - CASE
                                                                              WHEN DATEPART(MONTH, MyDate) - @OffSet < 0
                                                                              THEN (DATEPART(MONTH, MyDate) - @OffSet) + 12
                                                                              WHEN DATEPART(MONTH, MyDate) - @OffSet = 0
                                                                              THEN 12
                                                                              ELSE DATEPART(MONTH, MyDate) - @OffSet
                                                                           END
                                                                    , DATEADD(DAY, 1, EOMONTH(MyDate, -1))
                                                                   )
                                                           )
                                                   )
                          THEN 1
                          WHEN MyDate >= DATEADD(MONTH, 3, DATEADD(MONTH
                                                       , -12
                                                       , DATEADD(  MONTH
                                                                 , 13 - CASE
                                                                           WHEN DATEPART(MONTH, MyDate) - @OffSet < 0
                                                                           THEN (DATEPART(MONTH, MyDate) - @OffSet) + 12
                                                                           WHEN DATEPART(MONTH, MyDate) - @OffSet = 0
                                                                           THEN 12
                                                                           ELSE DATEPART(MONTH, MyDate) - @OffSet
                                                                        END
                                                                 , DATEADD(DAY, 1, EOMONTH(MyDate, -1))
                                                                )
                                                        )
                                                )

                               AND MyDate < DATEADD(MONTH, 6, DATEADD(MONTH
                                                          , -12
                                                          , DATEADD(  MONTH
                                                                    , 13 - CASE
                                                                              WHEN DATEPART(MONTH, MyDate) - @OffSet < 0
                                                                              THEN (DATEPART(MONTH, MyDate) - @OffSet) + 12
                                                                              WHEN DATEPART(MONTH, MyDate) - @OffSet = 0
                                                                              THEN 12
                                                                              ELSE DATEPART(MONTH, MyDate) - @OffSet
                                                                           END
                                                                    , DATEADD(DAY, 1, EOMONTH(MyDate, -1))
                                                                   )
                                                           )
                                                   )
                          THEN 2
                          WHEN MyDate >= DATEADD(MONTH, 6, DATEADD(MONTH
                                                       , -12
                                                       , DATEADD(  MONTH
                                                                 , 13 - CASE
                                                                           WHEN DATEPART(MONTH, MyDate) - @OffSet < 0
                                                                           THEN (DATEPART(MONTH, MyDate) - @OffSet) + 12
                                                                           WHEN DATEPART(MONTH, MyDate) - @OffSet = 0
                                                                           THEN 12
                                                                           ELSE DATEPART(MONTH, MyDate) - @OffSet
                                                                        END
                                                                 , DATEADD(DAY, 1, EOMONTH(MyDate, -1))
                                                                )
                                                        )
                                                )

                               AND MyDate < DATEADD(MONTH, 9, DATEADD(MONTH
                                                          , -12
                                                          , DATEADD(  MONTH
                                                                    , 13 - CASE
                                                                              WHEN DATEPART(MONTH, MyDate) - @OffSet < 0
                                                                              THEN (DATEPART(MONTH, MyDate) - @OffSet) + 12
                                                                              WHEN DATEPART(MONTH, MyDate) - @OffSet = 0
                                                                              THEN 12
                                                                              ELSE DATEPART(MONTH, MyDate) - @OffSet
                                                                           END
                                                                    , DATEADD(DAY, 1, EOMONTH(MyDate, -1))
                                                                   )
                                                           )
                                                   )
                          THEN 3
                          WHEN MyDate >= DATEADD(MONTH, 9, DATEADD(MONTH
                                                       , -12
                                                       , DATEADD(  MONTH
                                                                 , 13 - CASE
                                                                           WHEN DATEPART(MONTH, MyDate) - @OffSet < 0
                                                                           THEN (DATEPART(MONTH, MyDate) - @OffSet) + 12
                                                                           WHEN DATEPART(MONTH, MyDate) - @OffSet = 0
                                                                           THEN 12
                                                                           ELSE DATEPART(MONTH, MyDate) - @OffSet
                                                                        END
                                                                 , DATEADD(DAY, 1, EOMONTH(MyDate, -1))
                                                                )
                                                        )
                                                )

                               AND MyDate < DATEADD(MONTH, 12, DATEADD(MONTH
                                                          , -12
                                                          , DATEADD(  MONTH
                                                                    , 13 - CASE
                                                                              WHEN DATEPART(MONTH, MyDate) - @OffSet < 0
                                                                              THEN (DATEPART(MONTH, MyDate) - @OffSet) + 12
                                                                              WHEN DATEPART(MONTH, MyDate) - @OffSet = 0
                                                                              THEN 12
                                                                              ELSE DATEPART(MONTH, MyDate) - @OffSet
                                                                           END
                                                                    , DATEADD(DAY, 1, EOMONTH(MyDate, -1))
                                                                   )
                                                           )
                                                   )
                          THEN 4
                          ELSE NULL
                       END
 , FirstDayOfMonth   = DATEADD(DAY, 1, EOMONTH(MyDate, -1))
 , FYStartDate       = DATEADD(MONTH, -12, DATEADD(  MONTH
                                       , 13 - CASE
                                                 WHEN DATEPART(MONTH, MyDate) - @OffSet < 0
                                                 THEN (DATEPART(MONTH, MyDate) - @OffSet) + 12
                                                 WHEN DATEPART(MONTH, MyDate) - @OffSet = 0
                                                 THEN 12
                                                 ELSE DATEPART(MONTH, MyDate) - @OffSet
                                              END
                                       , DATEADD(DAY, 1, EOMONTH(MyDate, -1))
                                      )
                              )
 , FYEndDate         = EOMONTH(DATEADD(MONTH, 12 - CASE
                                                 WHEN DATEPART(MONTH, MyDate) - @OffSet < 0
                                                 THEN (DATEPART(MONTH, MyDate) - @OffSet) + 12
                                                 WHEN DATEPART(MONTH, MyDate) - @OffSet = 0
                                                 THEN 12
                                                 ELSE DATEPART(MONTH, MyDate) - @OffSet
                                              END
                                       , DATEADD(DAY, 1, EOMONTH(MyDate, -1))
                                      )
                              )
 , FiscalYear        = YEAR(EOMONTH(DATEADD(  MONTH
                                            , 12 - CASE
                                                      WHEN DATEPART(MONTH, MyDate) - @OffSet < 0
                                                      THEN (DATEPART(MONTH, MyDate) - @OffSet) + 12
                                                      WHEN DATEPART(MONTH, MyDate) - @OffSet = 0
                                                      THEN 12
                                                      ELSE DATEPART(MONTH, MyDate) - @OffSet
                                                   END
                                            , DATEADD(DAY, 1, EOMONTH(MyDate, -1))
                                           )
                                   )
                           )
/*INTO
#DimDate 
  */
FROM
   CTE_DatesTable
   
OPTION (MAXRECURSION 0);

select distinct CalendarYear, FiscalYear, [Fiscal Quarter], FiscalMonthNumber 
from v_Calendar
where CalendarYear = 2020

select top 1 * from Calendar
GO
/*
INSERT INTO Calendar 
SELECT
DateKey,
CalendarYear,
CalMonthNumber,
CalQtrNumber,
FiscalYear,
FiscalMonthNumber,
FYQtrNumber,
FirstDayOfMonth,
FYStartDate,
FYEndDate
FROM
#DimDate

/*
TRUNCATE TABLE Calendar


*/

CREATE VIEW [dbo].[v_Calendar] AS 

SELECT 
DateKey,
CalendarYear,
CalMonthNumber,
FiscalYear,
FiscalMonthNumber,
CONCAT(CalendarYear,'-',FiscalYear,' Q',FYQtrNumber) as [Fiscal Quarter] -- Does not mtahc excel sheet exactly. Needed?
FROM Calendar 
*/
 
 /*
 BEGIN
   DROP TABLE #DimDate;
END;
*/

/****** Object:  Table [dbo].[Calendar]    Script Date: 30-04-2021 15:09:15 ******/

/*
CREATE TABLE [dbo].[Calendar](
	[DateKey] [date] NULL,
	[CalendarYear] [char](4) NULL,
	[CalMonthNumber] [int] NULL,
	[CalQtrNumber] [int] NULL,
	[FiscalYear] [int] NULL,
	[FiscalMonthNumber] [int] NULL,
	[FYQtrNumber] [int] NULL,
	[FirstDayOfMonth] [date] NULL,
	[FYStartDate] [date] NULL,
	[FYEndDate] [date] NULL
) ON [PRIMARY]
GO
*/



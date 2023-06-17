-- Creating Rotation Data view
-- A rotation is a unique combination of a date and a shift time, each assigned a unique ID
-- For example, a given date can have two shifts, leading to two rotations
-- The view contains inforamtion about all rotations of the pizzeria

CREATE VIEW [dbo].[Rotation Data]
AS
SELECT
  dbo.rotations.rota_id AS [rotation id],
  dbo.rotations.date,
  dbo.shifts.start_time AS [start time],
  dbo.shifts.end_time AS [end time],
  DATEDIFF(HOUR, dbo.shifts.start_time, dbo.shifts.end_time) AS duration
FROM dbo.rotations
INNER JOIN dbo.shifts
  ON dbo.rotations.shift_id = dbo.shifts.shift_id
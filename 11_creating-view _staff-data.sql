-- Creating Staff Data view
-- Contains information about who worked, their details and when they worked in the pizzeria

CREATE VIEW [dbo].[Staff Data]
AS
SELECT
  dbo.rotations.date,
  dbo.rotations.rota_id AS [rotation id],
  dbo.staff.staff_id AS [staff id],
  { FN CONCAT({ FN CONCAT(dbo.parties.firstname, ' ') }, dbo.parties.lastname) } AS [staff name],
  dbo.staff.position,
  dbo.staff.hourly_rate AS rate,
  DATEDIFF(HOUR, dbo.shifts.start_time, dbo.shifts.end_time) AS hours,
  dbo.staff.hourly_rate * DATEDIFF(HOUR, dbo.shifts.start_time, dbo.shifts.end_time) AS [labour cost]
FROM dbo.rotations
INNER JOIN dbo.shifts
  ON dbo.rotations.shift_id = dbo.shifts.shift_id
INNER JOIN dbo.worklog
  ON dbo.rotations.rota_id = dbo.worklog.rota_id
INNER JOIN dbo.staff
  ON dbo.worklog.staff_id = dbo.staff.staff_id
INNER JOIN dbo.parties
  ON dbo.staff.party_id = dbo.parties.party_id
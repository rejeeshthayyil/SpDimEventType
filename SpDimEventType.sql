USE [Onlinestore]
GO

/****** Object:  StoredProcedure [Data].[uspPopulateDimEventType]    Script Date: 31/07/2023 10:26:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [Data].[uspPopulateDimEventType]
AS
BEGIN

	SET NOCOUNT, XACT_ABORT ON;
				BEGIN TRY
					PRINT'Populating Data into [Report].DimEventType';

					IF OBJECT_ID ('tempdb.dbo.#DimEventType') IS NOT NULL
						DROP TABLE #DimEventType;

					SELECT *
					INTO #DimEventType
					FROM  [Report].DimEventType
					WHERE 0=1;

					INSERT INTO #DimEventType
					
					(
					EventTypeId,
					WorkFlowId,
					EventTypeName,
					LastUpdatedTimeStamp
					)

					VALUES
					(1,1, 'Unknown', GETDATE()),
					(2,2, 'OptionOrdered', GETDATE()),
					(3,2, 'OptionRecieved', GETDATE()),
					(4,2, 'OptionAssigned', GETDATE()),
					(5,2, 'OptionGoalRejected',GETDATE()),
					(6,2, 'OptionCompleted', GETDATE ()),
					(7,2, 'OptionRemoved', GETDATE ()),
					(8,2, 'OptionGoalsUpdated', GETDATE ()),
					(9,2, 'OptionSourceTagAdd', GETDATE ()),
					(10,2, 'OptionSourceTagRemoved', GETDATE ()),
					(11,2, 'OptionRecorded', GETDATE ()),
					(12,3, 'StudiosGoalsAdded', GETDATE ()),
					(13,3, 'StudiosAssetReceived', GETDATE ()),
					(14,3, 'StudiosAssetRemoved', GETDATE ()),
					(15,3, 'StudiosAssetTokenExpected', GETDATE ()),
					(16,3, 'StudiosGoalsApproved', GETDATE ()),
					(17,3, 'StudiosGoalsOverridenRemoved', GETDATE ()),
					(18,3, 'StudiosGoalsRemoved', GETDATE ()),
					(19,3, 'StudiosGoalsOverriden', GETDATE ()),
					(20,3, 'StudiosRejectionInitiated', GETDATE ()),
					(21,3, 'StudiosGoalsRejectedOut', GETDATE ()),
					(22,3, 'StudiosRejectionSentBack', GETDATE ()),
					(23,3, 'StudiosGoalApprovalRemoved', GETDATE ()),
					(24,3, 'StudiosAssetMovedToGoal', GETDATE ()),
					(25,3, 'StudiosShootComplete', GETDATE ()),
					(26,3, 'StudiosGoalsRejetedoutExternal', GETDATE ()),
					(27,3, 'StudiosShootNoteAdded', GETDATE ()),
					(28,3, 'StudiosShootNoteDelete', GETDATE ()),
					(29,4, 'OpsTeamAdded', GETDATE ()),
					(30,4, 'OpsTeamRemoved', GETDATE ()),
					(31,4, 'OpsTeamCleanup', GETDATE ()),
					(32,3, 'StudioProductRemoved', GETDATE ()),
					(33,3, 'StudiosModelNameChanged', GETDATE ()),
					(34,3, 'StudiosPhotographerGoalComplete', GETDATE ()),
					(35,3, 'StudiosOptionCompleted', GETDATE ()),
					(36,2, 'OptionMarkedAsReady', GETDATE ()),
					(37,3, 'StudioGoalsApprovalRemovedForShootOps', GETDATE ()),
					(38,3, 'SstudioPhotoGrapherGoalRejectd', GETDATE ()),
					(39,5, 'RetouchGoalsScheduled', GETDATE ()),
					(40,5, 'RetouchInitiated', GETDATE ()),
					(41,5, 'RetouchRetouchingLevelUpdated', GETDATE ()),
					(42,5, 'RetouchTagAdded', GETDATE ()),
					(43,5, 'RetouchTagRemoved', GETDATE ()),
					(44,5, 'RetouchCompleted', GETDATE ()),
					(45,5, 'RetouchAssigned', GETDATE ()),
					(46,5, 'RetouchGoalsRejectedOut', GETDATE ()),
					(47,5, 'RetoucherUnassigned', GETDATE ()),
					(48,5, 'RetouchGoalsREjectedIn', GETDATE ()),
					(49,5, 'RetouchGoalsOverriden', GETDATE ()),
					(50,5, 'RetouchGoalsOverridenRemoved', GETDATE ()),
					(51,5, 'RetouchOpptionCompleted',GETDATE ()),
					(52,5, 'RetouchCancelled', GETDATE ()),
					(53,3, 'StudiosTagAdded', GETDATE ()),
					(54,3, 'StudioTagRemoved',GETDATE()),
					(55,6, 'ShootTimingSet', GETDATE()),
					(56,6, 'ShootStarted', GETDATE()),
					(57,6, 'ShootPaused', GETDATE()),
					(58,6, 'ShootResume',GETDATE()),
					(59,6, 'ShootInitialised',GETDATE());

WITH  Cte_Date

AS (SELECT  EventTypeId,
				WorkFlowId,
					EventTypeName
					
					
				FROM #DimEventType)

MERGE [Report].[DimEventType] As t
USING cte_Date AS s
ON t.EventTypeId = S.EventTypeId
WHEN NOT MATCHED BY TARGET THEN

INSERT
(
EventTypeId,
WorkflowId,
EventTypeName,
LastUpdatedTimeStamp
)
VALUES (
 s.EventTypeId,
s.WorkflowId,
s.EventTypeName, getdate())
WHEN MATCHED THEN

	update set t.workflowId= s.workflowId,
				t.EventTypeName= s.EventTypeName,
				t.lastUpdatedTimeStamp =GETDATE();

			DROP TABLE #DimEventType;
END TRY

BEGIN CATCH

	THROW;
END CATCH;

SET NOCOUNT OFF;

END
GO



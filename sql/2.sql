WITH trace_period AS (
  SELECT MIN(start_time) AS trace_start, MAX(end_time) AS trace_end
  FROM `[PROJECT_ID].[LOCATION]._Trace.Spans._AllSpans`
  WHERE trace_id = "[TRACE_ID]"
)

SELECT
  log.timestamp AS log_timestamp,
  log.severity,
  log.resource.type AS resource_type,
  JSON_VALUE(log.resource.labels, '$."pod_name"') AS pod_name,
  COALESCE(
    log.text_payload,
    JSON_VALUE(log.json_payload, '$."message"'),
    JSON_VALUE(log.json_payload, '$."log"')) AS system_message,
  JSON_VALUE(log.json_payload, '$."reason"') AS event_reason
FROM
  `[PROJECT_ID].[LOCATION].[BUCKET_ID].[LOG_VIEW]` AS log
CROSS JOIN
  trace_period
WHERE
  log.timestamp BETWEEN TIMESTAMP_SUB(trace_period.trace_start, INTERVAL 10 SECOND)
                    AND TIMESTAMP_ADD(trace_period.trace_end, INTERVAL 10 SECOND)
  AND JSON_VALUE(log.resource.labels, '$."cluster_name"') = 'demo'
  AND log.severity >= "INFO"
  AND (log.resource.type = 'k8s_pod' OR log.log_name LIKE '%events%')
ORDER BY
  log_timestamp ASC
LIMIT 10

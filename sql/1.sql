-- 各コンテナのログサイズを取得し、降順で表示するクエリ
SELECT
  JSON_VALUE(resource.labels, '$."container_name"') AS container_name,
  SUM(storage_bytes) / 1024 / 1024 AS log_size_mb
FROM
  `[PROJECT_ID].[LOCATION].[BUCKET_ID].[LOG_VIEW]`
WHERE
  JSON_VALUE(resource.labels.cluster_name) = "demo"
  AND resource.type = "k8s_container"
GROUP BY
  container_name
ORDER BY
  log_size_mb DESC

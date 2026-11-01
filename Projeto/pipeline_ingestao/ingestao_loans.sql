-- Aula 22: ingestão gerenciada pelo Lakeflow.
-- O pipeline acompanha a pasta landing/loans e ingere cada arquivo novo uma única vez.
CREATE OR REFRESH STREAMING TABLE loans_ingestao_gerenciada
COMMENT 'Empréstimos ingeridos de forma incremental a partir do volume landing'
AS SELECT
  *,
  current_timestamp() AS _ingested_at,
  _metadata.file_path AS _source_file
FROM STREAM read_files(
  '/Volumes/${catalogo}/bronze/landing/loans/',
  format => 'parquet'
);

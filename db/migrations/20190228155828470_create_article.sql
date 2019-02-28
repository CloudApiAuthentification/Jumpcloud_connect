-- +micrate Up
CREATE TABLE articles (
  id INTEGER NOT NULL PRIMARY KEY,
  body TEXT,
  group_id BIGINT,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);
CREATE INDEX article_group_id_idx ON articles (group_id);

-- +micrate Down
DROP TABLE IF EXISTS articles;

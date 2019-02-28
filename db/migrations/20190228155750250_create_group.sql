-- +micrate Up
CREATE TABLE groups (
  id INTEGER NOT NULL PRIMARY KEY,
  name VARCHAR,
  external_id VARCHAR,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);


-- +micrate Down
DROP TABLE IF EXISTS groups;

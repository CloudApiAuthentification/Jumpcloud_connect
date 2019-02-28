-- +micrate Up
CREATE TABLE user_groups (
  id INTEGER NOT NULL PRIMARY KEY,
  user_id BIGINT,
  group_id BIGINT,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);
CREATE INDEX user_group_user_id_idx ON user_groups (user_id);
CREATE INDEX user_group_group_id_idx ON user_groups (group_id);

-- +micrate Down
DROP TABLE IF EXISTS user_groups;

<?php

class GameRepository {
    private $db;

    public function __construct(Database $db)
    {
        $this->db = $db;
    }

  public function Insert($user_id, $point)
  {
    $sql = 'INSERT INTO t_games (user_id, point) VALUES (:user_id, :point)';
    return $this->db->insertGame($sql, $user_id, $point);
  }

  public function Update($user_id, $time)
  {
    $sql = 'UPDATE t_games SET point=FALSE WHERE user_id=:user_id and created_at > :time - interval \'12 hours\'';
    return $this->db->updateGame($sql, $user_id, $time);
  }
}

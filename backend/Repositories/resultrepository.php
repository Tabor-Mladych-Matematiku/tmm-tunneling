<?php

class ResultRepository {
  private $db;

  public function __construct(Database $db)
  {
    $this->db = $db;
  }

  public function FindAll()
  {
    $sql = 'SELECT u.user_id, u.firstname, u.lastname, sum(case when g.point then 1 end) AS result FROM t_games g INNER JOIN t_users u ON u.user_id=g.user_id GROUP BY u.user_id, u.firstname, u.lastname ORDER BY result DESC';
    $results = $this->db->select($sql);
    return $results;
  }
  public function FindById($user_id)
  {
    $sql = 'SELECT u.user_id, u.firstname, u.lastname, u.password, sum(case when g.point then 1 else 0 end) AS points FROM t_games g right JOIN t_users u ON u.user_id=g.user_id WHERE u.user_id=:user_id GROUP BY u.user_id, u.firstname, u.lastname ORDER BY points DESC';
    $results = $this->db->selectUserById($sql,$user_id);
    return $results;
  }
}

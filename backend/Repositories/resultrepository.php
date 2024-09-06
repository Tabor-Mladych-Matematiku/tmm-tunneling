<?php

class ResultRepository {
  private $db;

  public function __construct(Database $db)
  {
    $this->db = $db;
  }

  public function FindAll()
  {
    $sql = 'SELECT u.user_id, u.firstname, u.lastname, sum(g.point) AS result FROM t_games g INNER JOIN t_users u ON u.user_id=g.user_id GROUP BY u.user_id, u.firstname, u.lastname ORDER BY result DESC';
    $results = $this->db->select($sql);
    return $results;
  }
}

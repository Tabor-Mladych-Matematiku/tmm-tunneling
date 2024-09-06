<?php

class LoginRepository {
  private $db;

  public function __construct(Database $db)
  {
    $this->db = $db;
  }

  public function Insert($user_id, $state)
  {
    $sql = 'INSERT INTO t_logins (user_id, state) VALUES (:user_id, :state)';
    return $this->db->insertLogin($sql, $user_id, $state);
  }

}

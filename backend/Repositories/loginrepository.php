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

  public function SelectById($user_id)
  {
    $sql = 'select sum(case when state then 1 else 0 end) as successes, sum(case when state then 0 else 1 end) as failures, max(time) as last_login from t_logins where user_id=:user_id';
    return $this->db->selectUserById($sql, $user_id);
  }

}

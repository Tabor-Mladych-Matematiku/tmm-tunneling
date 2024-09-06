<?php

class UserRepository {
  private $db;

  public function __construct(Database $db)
  {
    $this->db = $db;
  }

  public function FindbyUsername($user_id)
  {
    $sql = 'SELECT * from t_users where user_id=:user_id';
    $user = $this->db->selectUserById($sql, $user_id);
    return $user;
  }

  public function GetLogin($user_id)
  {
    $sql = 'SELECT user_id, password from t_users where user_id=:user_id';
    $user = $this->db->selectUserById($sql, $user_id);
    return $user;
  }

  public function Insert($user_id, $firstname, $lastname, $password)
  {
    $sql = 'INSERT INTO t_users (user_id, firstname, lastname, password)
    VALUES (:user_id, :firstname, :lastname, :password)';
    return $this->db->insertUser($sql, $user_id, $firstname, $lastname, $password);
  }

  public function LoginFail($user_id)
  {
    $fails = $this->FindbyUsername($user_id)['failed_attempts'] + 1;
    $sql = 'Update t_users set failed_attempts = :fails where user_id=:user_id';
    return $this->db->loginFail($sql, $user_id, $fails);
  }

  public function LoginOK($user_id)
  {
    $sql = 'UPDATE t_users SET failed_attempts = 0 WHERE user_id=:user_id';
    return $this->db->loginOK($sql, $user_id);
  }
}

<?php

class Database
{
  private $host;
  private $db_name;
  private $username;
  private $password;
  private $port;
  private $conn;



  public function __construct()
  {
  $this->host = getenv('POSTGRES_HOST');
  $this->db_name = getenv('POSTGRES_DB');
  $this->username = getenv('POSTGRES_USER');
  $this->password = getenv('POSTGRES_PASSWORD');
  $this->port = getenv('POSTGRES_PORT');
    $this->conn = null;
    try {
      $this->conn = new PDO('pgsql:host=' . $this->host . ';port=' . $this->port . ';dbname=' . $this->db_name, $this->username, $this->password);
      $this->conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    } catch (PDOException $e) {
      echo 'Host: ' . $this->host;
      echo 'Port: ' . $this->port;
      echo 'Connection Error: ' . $e->getMessage();
    }
    return $this->conn;
  }

  public function select($sql)
  {
    $stmt = $this->conn->prepare($sql);
    $stmt->execute();
    return $stmt->fetchAll();
  }

  public function selectUserById($sql, $user_id)
  {
    $stmt = $this->conn->prepare($sql);
    $stmt->execute([':user_id' => $user_id]);
    return $stmt->fetch();
  }

  public function insertGame($sql, $user_id, $point)
  {
    $stmt = $this->conn->prepare($sql);
    $stmt->bindparam(':user_id', $user_id);
    $stmt->bindparam(':point', $point);
    return $stmt->execute();
  }

  public function updateGame($sql, $user_id, $time)
  {
    $stmt = $this->conn->prepare($sql);
    $stmt->bindparam(':user_id', $user_id);
    $stmt->bindparam(':time', $time);
    return $stmt->execute();
  }

  public function insertLogin($sql, $user_id, $state)
  {
    $stmt = $this->conn->prepare($sql);
    $stmt->bindparam(':user_id', $user_id);
    $stmt->bindparam(':state', $state);
    return $stmt->execute();
  }

  public function insertUser($sql, $user_id, $firstname, $lastname, $password)
  {
    $stmt = $this->conn->prepare($sql);
    $stmt->bindparam(':user_id', $user_id);
    $stmt->bindparam(':firstname', $firstname);
    $stmt->bindparam(':lastname', $lastname);
    $stmt->bindparam(':password', $password);
    return $stmt->execute();
  }

  public function loginFail($sql, $user_id, $fails)
  {
    $stmt = $this->conn->prepare($sql);
    $stmt->bindparam(':user_id', $user_id);
    $stmt->bindparam(':fails', $fails);
    return $stmt->execute();
  }

  public function loginOK($sql, $user_id)
  {
    $stmt = $this->conn->prepare($sql);
    $stmt->bindparam(':user_id', $user_id);
    return $stmt->execute();
  }

}

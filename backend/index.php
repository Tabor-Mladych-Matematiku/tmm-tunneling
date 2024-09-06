<?php
  // $host = getenv('POSTGRES_HOST', true) ?: getenv('POSTGRES_HOST');
  // $db_name = getenv('POSTGRES_DB', true) ?: getenv('POSTGRES_DB');
  // $username = getenv('POSTGRES_USER', true) ?: getenv('POSTGRES_USER');
  // $password = getenv('POSTGRES_PASSWORD', true) ?: getenv('POSTGRES_PASSWORD');
  // $port = getenv('POSTGRES_PORT', true) ?: getenv('POSTGRES_PORT');

  $host = $_ENV['POSTGRES_HOST'];
  $db_name = $_ENV['POSTGRES_DB'];
  $username = $_ENV['POSTGRES_USER'];
  $password = $_ENV['POSTGRES_PASSWORD'];
  $port = $_ENV['POSTGRES_PORT'];

  echo "host: {$host}<br>";
  echo "db_name: {$db_name}<br>";
  echo "db_user: {$username}<br>";
  echo "db_pwd: {$password}<br>";
  echo "db_port: {$port}<br>";

<?php
header('Access-Control-Allow-Origin: *');
header('Content-type: aplicaton/json');
require_once '../../Repositories/database.php';
require_once '../../Repositories/userrepository.php';
require_once '../../Repositories/resultrepository.php';
$db = new Database();
$userrepo = new UserRepository($db);
$resultrepo = new ResultRepository($db);

$data = json_decode(file_get_contents("php://input"));
$user = $userrepo->FindbyUsername($data->admin_id);

if ($user['failed_attempts'] > 2 || !$user['is_admin'])
{
  exit(http_response_code(405));
}
if ($user['password'] != $data->admin_password)
{
  $userrepo->LoginFail($data->admin_id);
  exit(http_response_code(403));
}

$userrepo->LoginOK($data->user_id);

$user_data = $resultrepo->FindById($data->user_id);
$user_single = array(
  'user_id' => $user_data['user_id'],
  'firstname' => $user_data['firstname'],
  'lastname' => $user_data['lastname'],
  'password' => $user_data['password'],
  'points' => $user_data['points'],
);
echo json_encode($user_single);
exit(http_response_code(200));

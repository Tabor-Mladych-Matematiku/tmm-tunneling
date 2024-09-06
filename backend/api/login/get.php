<?php
header('Access-Control-Allow-Origin: *');
header('Content-type: aplicaton/json');
require_once '../../Repositories/database.php';
require_once '../../Repositories/userrepository.php';
require_once '../../Repositories/loginrepository.php';
$db = new Database();
$userrepo = new UserRepository($db);
$loginrepo = new LoginRepository($db);

$data = json_decode(file_get_contents("php://input"));
$user = $userrepo->FindbyUsername($data->admin_id);

if (!$user)
{
  exit(http_response_code(403));
}
if ($user['failed_attempts'] > 2 || !$user['is_admin'])
{
  exit(http_response_code(405));
}
if ($user['password'] != $data->admin_password)
{
  $userrepo->LoginFail($data->admin_id);
  $loginrepo->Insert($data->admin_id, false);
  exit(http_response_code(403));
}

$userrepo->LoginOK($data->admin_id);
$loginrepo->Insert($data->admin_id, true);

$user_data = $loginrepo->SelectById($data->user_id);
$user_single = array(
  'successes' => $user_data['successes'],
  'failures' => $user_data['failures'],
  'last_login' => $user_data['last_login'],
);
echo json_encode($user_single);
exit(http_response_code(200));

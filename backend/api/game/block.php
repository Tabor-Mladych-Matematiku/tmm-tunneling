<?php
header('Access-Control-Allow-Origin: *');
header('Content-type: aplicaton/json');
header('Access-Control-Allow-Method: POST');
header('Access-Control-Allow-Headers: Access-Control-Allow-Headers, Content-Type, Access-Control-Allow-Method, Authorization, X-Requested-With');
require_once '../../Repositories/database.php';
require_once '../../Repositories/userrepository.php';
require_once '../../Repositories/gamerepository.php';
require_once '../../Repositories/loginrepository.php';
$db = new Database();
$userrepo = new UserRepository($db);
$loginrepo = new LoginRepository($db);
$gamerepo = new GameRepository($db);

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
  $loginrepo->Insert($data->admin_id, "false");
  exit(http_response_code(403));
}

$userrepo->LoginOK($data->user_id);
$loginrepo->Insert($data->admin_id, "true");

$usercheck = $userrepo->FindbyUsername($data->user_id);
if (!$usercheck)
{
  exit(http_response_code(400));
}

gamerepo$->Block($data->user_id);
exit(http_response_code(200));


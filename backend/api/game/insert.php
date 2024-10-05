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
$gamerepo = new GameRepository($db);
$loginrepo = new LoginRepository($db);
$userrepo = new UserRepository($db);

$data = json_decode(file_get_contents("php://input"));
$user = $userrepo->FindbyUsername($data->user_id);

if (!$user) {
  exit(http_response_code(403));
}
if ($user['failed_attempts'] > 2)
{
  exit(http_response_code(405));
}
if ($user['password'] != $data->password)
{
  $userrepo->LoginFail($data->user_id);
  $loginrepo->Insert($data->user_id, "false");
  exit(http_response_code(403));
}

$userrepo->LoginOK($data->user_id);
$loginrepo->Insert($data->user_id, "true");
$gamerepo->Insert($data->user_id, $data->success);
exit(http_response_code(200));


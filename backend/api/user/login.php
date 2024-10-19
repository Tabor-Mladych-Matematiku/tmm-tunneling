<?php
header('Access-Control-Allow-Origin: *');
header('Content-type: aplicaton/json');
header('Access-Control-Allow-Method: POST');
header('Access-Control-Allow-Headers: Access-Control-Allow-Headers, Content-Type, Access-Control-Allow-Method, Authorization, X-Requested-With');
require_once '../../Repositories/database.php';
require_once '../../Repositories/loginrepository.php';
require_once '../../Repositories/userrepository.php';
$db = new Database();
$userrepo = new UserRepository($db);
$loginrepo = new LoginRepository($db);

$data = json_decode(file_get_contents("php://input"));
$user = $userrepo->FindbyUsername($data->user_id);

if (!$user) {
  exit(http_response_code(403));
}
if ($user['password'] != $data->password)
{
  $userrepo->LoginFail($data->user_id);
  $loginrepo->Insert($data->user_id, "false");
  exit(http_response_code(403));
}
$loginrepo->Insert($data->user_id, "true");
$userrepo->LoginOK($data->user_id);

exit(http_response_code(200));


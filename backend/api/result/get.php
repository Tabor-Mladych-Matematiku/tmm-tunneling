<?php
header('Access-Control-Allow-Origin: *');
header('Content-type: aplicaton/json');
require_once '../../Repositories/database.php';
require_once '../../Repositories/userrepository.php';
require_once '../../Repositories/loginrepository.php';
require_once '../../Repositories/resultrepository.php';
$db = new Database();
$userrepo = new UserRepository($db);
$loginrepo = new LoginRepository($db);
$resultrepo = new ResultRepository($db);

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

$result_data = $resultrepo->FindAll();
$result_arr = array();

for ($i = 0; $i < count($result_data); $i++) {
  $result_single = array(
    'id' => $result_data[$i]['user_id'],
    'firstname' => $result_data[$i]['firstname'],
    'lastname' => $result_data[$i]['lastname'],
    'points' => $result_data[$i]['points'],
  );
  array_push($result_arr, $result_single);
}
echo json_encode($result_arr);
exit(http_response_code(200));

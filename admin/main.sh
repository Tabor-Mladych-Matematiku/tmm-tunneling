#!/usr/bin/env bash
source .env

while : ; do
  echo "Zvolte akci"
  echo "1. Zablokování hráče (Default)"
  echo "2. Konec"

  read -r input
  case $input in
    "5")
      echo "Ukončuji systém"
      break;
      ;;
    *)
      echo "Zadejte id hráče"
      read -r user_id
      curl --request POST \
        --data "{\"admin_id\":$ADMIN_ID,\"admin_password\":\"$ADMIN_PASSWORD\",\"user_id\":$user_id}" \
        http://192.168.0.105:8080/api/game/block.php -i
      ;;
  esac
done

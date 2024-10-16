#!/bin/sh
echo -ne '\033c\033]0;Tunneling client\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Tunneling client.x86_64" "$@"

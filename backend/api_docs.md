# API Docs

Server is logging every request and locks user if 3 wrong attempts are made in a row. If locked, user has to be changed directly in database by setting t_users.failedAttempts=0.

## Users

### POST /api/game/insert.php

#### body params

```json
{
  "user_id": int,
  "password": string,
  "success": bool,
}
```

#### returns

200 if ok

405 if banned

403 if wrong credentials

## POST /api/user/login.php

#### body params

```json
{
  "user_id": int,
  "password": string,
}
```

#### returns

200 if success

405 if banned

403 if wrong credentials

## Admin

### POST /api/user/insert.php

#### body params

```json
{
  "user_id": int,
  "firstname": string,
  "lastname": string,
  "password": string,
  "admin_id": int,
  "admin_password": string,
}
```

#### returns

200 if ok

400 if error (user_id already exists)

403 if wrong credentials

405 if banned

### GET /api/user/get.php

#### body params

```json
{
  "user_id": int,
  "admin_id": int,
  "admin_password": string,
}
```

#### returns:

```json
{
  "user_id": int,
  "firstname": string,
  "lastname": string,
  "password": string,
  "points": int,
}
```

200 if ok

403 if wrong credentials

405 if banned

### GET /api/user/login/get.php

#### body params

```json
{
  "user_id": int,
  "admin_id": int,
  "admin_password": string,
}
```

#### returns

```json
{
  "successes": int,
  "failures": int,
  "last_login": timestamp,
}
```

### GET /api/result/get.php

#### body params

```json
{
  "admin_id": int,
  "admin_password": string,
}
```

#### returns:

```json
[
  {
    "user_id": int,
    "firstname": string,
    "lastname": string,
    "password": string,
    "points": int,
  }
]
```

200 if ok

403 if wrong credentials

405 if banned

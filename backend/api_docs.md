# API Docs

Server is logging every request and locks user if 3 wrong attempts are made in a row. Same gfx for admin but only one wrong attempt required to lock. in that case user needs to be unlocked directly in database.

## Users

### POST /api/game

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

## POST /api/users/login

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

### POST /api/user

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

### GET /api/user/:user_id

#### body params

```json
{
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
  "admin_id": int,
  "admin_password": string,
}
```

200 if ok

403 if wrong credentials

### POST /api/game/ban/:user_id

#### body params:

```json
{
  "user_id": int,
  "datetime": timestamp,
  "admin_id": int,
  "admin_password": string,
}
```

#### returns

200 if ok

403 if wrong credentials

### GET /api/user/logins/:user_id

#### body params

```json
{
  "admin_id": int,
  "admin_password",
}
```

#### returns

```json
{
  successes: int,
  failures: int,
  last_login: timestamp,
}
```

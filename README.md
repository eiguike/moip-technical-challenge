# moip-technical-challenge

This is a Payment REST API for the Moip Technical Challenge, with this API it is possible simulate new payments (using credit card or boleto) and getting its status.

## How to Build:
<details>
<summary>
Building and Running with Docker
</summary>

Build the image
```bash
$ docker-compose build
```

Execute migration and load a preset database
```bash
$ docker-compose run web rails db:reset db:seed
```

Run Server
```bash
$ docker-compose up
```

Run Specs
```bash
$ docker-compose run web rails spec
```
</details>

<details>
<summary>
Building and Running without Docker
</summary>

Install the dependencies
```bash
$ bundle install
```

Comment host parameter from `database.yml`
```
...
    #host db
...
```

Execute migration and load a preset database
```bash
$ rails db:reset db:seed
```

Run server
```bash
$ rails s
```

Run specs
```bash
$ rails specs
```
</details>

---
## Usage:
This API has two endpoints, one to create new payments and other one to get the payment status. The usage for these endpoints are written below:

* `POST v1/payments` create a payment 

**Request for credit card:**
```
{
  "payment": {
    "method_type": "Card",
      "amount": "500.50",
      "client": {
        "client_id": "1"
      },
      "buyer": {
        "name": "Darius Hamill",
        "email": "darius@gmail.com",
        "CPF": "123.123.123-12"
      },
      "method": {
        "holder_name": "DARIUS HAMILL",
        "number": "1234123412341234",
        "expiration_date": "2018-12-12",
        "cvv": "123"
      }
  }
}
```
**Response for credit card:**
```
{
    "id": 25,
    "status": "success"
}
```

**Request for boletos:**
```
{
  "payment": {
    "method_type": "Boleto",
      "amount": "500.50",
      "client": {
        "client_id": "1"	
      },
      "buyer": {
        "name": "Darius Hamill",
        "email": "darius@gmail.com",
        "CPF": "123.123.123-12"
      }
  }
}
```
**Response for boletos:**
```
{
    "id": 26,
    "number": "44883713286039411099542945642906502798614817748"
}
```

* `GET v1/payments/{id}` get the status from `{id}` payment

**Response for credit card:**
```
{
    "id": 25,
    "amount": 500.5,
    "method_type": "Card",
    "status": "success",
    "client": {
        "id": 1
    },
    "buyer": {
        "name": "Darius Hamill",
        "email": "darius@gmail.com",
        "CPF": "123.123.123-12"
    },
    "method": {
        "holder_name": "DARIUS HAMILL",
        "number": "1234123412341234",
        "expiration_date": "2018-12-12",
        "cvv": 123
    }
}
```
**Response for boletos:**
```
{
    "id": 26,
    "amount": 500.5,
    "method_type": "Boleto",
    "status": "success",
    "client": {
        "id": 1
    },
    "buyer": {
        "name": "Darius Hamill",
        "email": "darius@gmail.com",
        "CPF": "123.123.123-12"
    }
}
```

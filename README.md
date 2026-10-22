# README

About
Rails-based barangay SMS notification system that texts registered voters campaign and election updates, via an Arduino Uno + SIM900 GSM module with Twilio as a fallback gateway.

# Barangay SMS App (SIM900 Module)

A Ruby on Rails application that sends SMS notifications to registered voters
in a barangay for election campaign announcements, schedules, and reminders.

## Overview

The app manages a database of registered voters and lets barangay staff or
campaign coordinators compose messages and send them to individuals, groups
(e.g. by purok or precinct), or the full voter list. Messages are delivered
through one of two gateways:

- **Arduino Uno + SIM900 GSM module**: a local, low-cost gateway that sends
  SMS through a physical SIM card. The Rails app talks to the Arduino over a
  serial connection, which avoids per-message API costs and works where
  internet access is limited.
- **Twilio SMS API**: a cloud gateway used as a fallback or for higher volume.

## Features

- Voter registry (name, mobile number, precinct/purok)
- Compose and send single, group, or bulk SMS
- Selectable gateway: SIM900 (hardware) or Twilio (cloud)
- Delivery status logging and message history
- Opt-out handling for voters who no longer wish to receive messages

## Tech Stack

| Layer     | Technology                         |
|-----------|------------------------------------|
| Backend   | Ruby on Rails                      |
| Hardware  | Arduino Uno, SIM900 GSM/GPRS shield|
| Cloud SMS | Twilio Programmable Messaging      |
| Database  | (MySQL)                            |

## How It Works

1. Staff creates a message and selects recipients in the Rails UI.
2. Rails queues the messages as background jobs.
3. Each job dispatches via the chosen gateway:
   - **SIM900:** AT commands (`AT+CMGF=1`, `AT+CMGS`) sent to the Arduino over serial
   - **Twilio:** an authenticated REST call
4. The delivery result is stored for each recipient.

## Compliance Notice

Sending campaign messages to voters involves personal data. Make sure you
have a lawful basis or consent, honor opt-outs, and follow the Data Privacy
Act of 2012 (RA 10173) and applicable COMELEC campaign rules.

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

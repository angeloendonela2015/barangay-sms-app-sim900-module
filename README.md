# Barangay SMS App (SIM900 Module)

A Ruby on Rails application that sends SMS notifications to registered voters in a barangay for election campaign announcements, schedules, and reminders. Messages go out through an Arduino Uno with a SIM900 GSM module (local, low-cost) or through Twilio (cloud).

## Project Background

Built as a 3-month project for a barangay councilor to support election campaign communication with registered voters.

## Features

- Voter registry (name, mobile number, precinct/purok)
- Compose and send single, group, or bulk SMS
- Selectable gateway: SIM900 (hardware) or Twilio (cloud)
- Delivery status logging and message history
- Opt-out handling

## Ruby version

`ruby-3.0.0` (see `.ruby-version`)

```bash
rbenv install 3.0.0   # or: rvm install 3.0.0
```

## System dependencies

| Dependency | Purpose |
|---|---|
| Ruby 3.0.0 + Bundler | Rails runtime |
| Node.js + Yarn | JavaScript assets (`package.json`, `yarn.lock`) |
| SQL database (TODO: SQLite / PostgreSQL / MySQL) | Application data |
| Arduino IDE (or `arduino-cli`) | Flash the Arduino Uno sketch |
| Arduino Uno + SIM900 GSM shield | Local SMS gateway |
| Active SIM card with SMS load | Used by the SIM900 |
| External 5V power supply (about 2A) | SIM900 draws current spikes that USB alone cannot supply |
| Twilio account (optional) | Cloud SMS gateway |

## Configuration

Install gems and JS packages:

```bash
bundle install
yarn install
```

Never commit credentials. Use Rails credentials or environment variables:

| Variable | Description |
|---|---|
| `SMS_GATEWAY` | `sim900` or `twilio` |
| `SERIAL_PORT` | Arduino serial port, e.g. `/dev/ttyUSB0` or `/dev/ttyACM0` (Linux), `COM3` (Windows) |
| `SERIAL_BAUD_RATE` | Must match the Arduino sketch, e.g. `9600` |
| `TWILIO_ACCOUNT_SID` | Twilio account SID |
| `TWILIO_AUTH_TOKEN` | Twilio auth token |
| `TWILIO_PHONE_NUMBER` | Twilio sender number |

On Linux, give your user access to the serial port:

```bash
sudo usermod -aG dialout $USER   # log out and back in afterwards
```

### Arduino / SIM900 setup

1. Mount the SIM900 shield on the Arduino Uno and insert the SIM card.
2. Set the shield's serial jumpers (software serial vs. hardware serial) as your shield's datasheet describes, and match the pins in the sketch. (TODO: document your pins.)
3. Power the shield from the external supply, then connect the Arduino to the server by USB.
4. Flash the sketch from the Arduino IDE.
5. The app sends standard SIM900 AT commands over serial: `AT+CMGF=1` (text mode), then `AT+CMGS="<number>"` followed by the message and Ctrl+Z (`0x1A`).

## Database creation

```bash
bin/rails db:create
```

## Database initialization

```bash
bin/rails db:migrate
bin/rails db:seed   # use sample data only, never real voter records
```

## How to run the test suite

The `spec/` directory uses RSpec:

```bash
bundle exec rspec
```

Tests should mock both gateways (serial port and Twilio) so no real SMS is sent.

## Services

- **Background jobs (TODO: confirm adapter, e.g. Sidekiq/Solid Queue/Active Job async):** each SMS is queued as a job so the web request is not blocked and sends can be rate-limited and retried.
- **Gateways:** SIM900 over serial, Twilio over HTTPS.
- **Development:** `Procfile.dev` starts the app processes together:

```bash
bin/dev
```

Note: the SIM900 sends slowly and carriers may block a SIM that sends in bulk, so throttle bulk sends.

## Deployment instructions

1. Deploy to a server that the Arduino can be physically connected to if you use the SIM900 gateway. A cloud-only host can only use Twilio.
2. Set the environment variables above on the server.
3. Precompile assets and migrate:

```bash
RAILS_ENV=production bundle exec rails assets:precompile
RAILS_ENV=production bundle exec rails db:migrate
```

4. Run the app server (e.g. Puma behind NGINX) and the background job worker as services (systemd or similar).
5. Make sure the serial device path stays stable (a udev rule helps) and that the service user has serial port access.

## Compliance notice

Sending campaign messages to voters involves personal data. Obtain a lawful basis or consent, honor opt-outs, and follow the Data Privacy Act of 2012 (RA 10173) and applicable COMELEC campaign rules. Do not publish real voter data in this repository.

## License

See [LICENSE](LICENSE).

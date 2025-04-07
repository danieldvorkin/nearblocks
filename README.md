Got it! Here's a simplified README for a Ruby on Rails app:

---

# NearBlocks

NearBlocks is a Ruby on Rails application for interacting with the NEAR Protocol blockchain. It provides a simple interface to view blockchain data and transactions in real time.

## Features

- View recent blocks and transactions on the NEAR blockchain
- Search for accounts and smart contracts
- Real-time data visualization

## Installation

### Prerequisites

- Ruby >= 3.x
- Rails >= 7.x
- Node.js (for assets)

### Setup

1. Clone the repository:

```bash
git clone https://github.com/danieldvorkin/nearblocks.git
cd nearblocks
```

2. Install dependencies:

```bash
bundle install
```


3. Set up the database:

```bash
rails db:create db:migrate
```

4. Start the Rails server:

```bash
rails server
```

Your app will be running at `http://localhost:3000`.

## Usage

Once the app is running, visit `http://localhost:3000` to view real-time blockchain data, including:

- Recent transactions
- Block details
- Account and smart contract information

## Development

To set up the project for local development:

1. Clone the repo and install dependencies:

```bash
git clone https://github.com/danieldvorkin/nearblocks.git
cd nearblocks
bundle install
yarn install
```

2. Start the development server:

```bash
rails server
```

3. Open the app in your browser at `http://localhost:3000`.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.

---

This version simplifies the installation and usage instructions, making it more focused on the Ruby on Rails setup. Let me know if you need further changes!
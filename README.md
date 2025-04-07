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

## API Usage

### Root Route with `action_type` Parameter

The root route of the application accepts an optional `action_type` parameter to customize the data displayed. This parameter can be used to filter or specify the type of blockchain data you want to view.

#### Example Usage

1. **View Recent Transactions**  
    Append `?action_type=transactions` to the root URL:

    ```
    http://localhost:3000/?action_type=Transfer
    ```

    This will display a list of recent transactions on the NEAR blockchain.

2. **View Recent Blocks**  
    Append `?action_type=blocks` to the root URL:

    ```
    http://localhost:3000/?action_type=FunctionCall
    ```

    This will display a list of recent blocks on the NEAR blockchain.

3. **Search for Accounts**  
    Append `?action_type=accounts` to the root URL:

    ```
    http://localhost:3000/?action_type=AddKey
    ```

    This will allow you to search for specific accounts on the NEAR blockchain.

Make sure to replace `localhost:3000` with your deployed application's URL if running in a production environment.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.

---

This version simplifies the installation and usage instructions, making it more focused on the Ruby on Rails setup. Let me know if you need further changes!
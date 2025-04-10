Got it! Here's a simplified README for a Ruby on Rails app:

---

# NearBlocks

NearBlocks is a Ruby on Rails application for interacting with the NEAR Protocol blockchain. It provides a simple interface to view blockchain data and transactions in real time.

Current Problems:
- controller tests and factories are failing when creating a Transaction... not sure why, error claims "TypeError: no implicit conversion of String into Integer" but i checked the types and model configurations....


Implementation:
## Service, Caching, and Filtering

### Service Layer

NearBlocks uses a service-oriented architecture to handle interactions with the NEAR Protocol blockchain. The service layer is responsible for:

- Fetching data from the NEAR blockchain API
- Parsing and transforming the data into a format suitable for the application
- Handling business logic, such as filtering and sorting transactions or blocks

This separation of concerns ensures that the application remains modular and easy to maintain.

### Caching

To improve performance and reduce the number of API calls to the NEAR blockchain, NearBlocks implements caching mechanisms. Key features of the caching system include:

- **Rails Cache Store**: Frequently accessed data, such as recent blocks and transactions, is cached using Rails' built-in caching system.
- **Expiration Policies**: Cached data is automatically invalidated after a configurable time period to ensure that users always see up-to-date information.

### Filtering

NearBlocks provides robust filtering capabilities to help users find the data they need. Filters can be applied to:

- **Transaction Action Types**: Users can filter transactions by action types such as `Transfer`, `FunctionCall`, or `AddKey`.
- **Date Ranges**: Transactions and blocks can be filtered by specific date ranges to narrow down results.
- **Account and Contract Details**: Users can search for specific accounts or smart contracts to view related transactions and blocks.

These features are implemented using query parameters in the application's API and are processed in the service layer to ensure efficient data retrieval.

## Features

- View recent blocks and transactions on the NEAR blockchain
- Filter by transaction action type
- Real-time data visualization with caching

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

## Testing

This project uses RSpec for testing. To run the test suite, follow these steps:

1. Run the tests:

```bash
rspec
```

### Writing Tests

To add new tests, create files in the `spec` directory following the RSpec conventions. For example:

- Model tests go in `spec/models`
- Controller tests go in `spec/controllers`
- Feature tests go in `spec/features`

Refer to the [RSpec documentation](https://rspec.info/documentation/) for more details on writing tests.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.

---

This version simplifies the installation and usage instructions, making it more focused on the Ruby on Rails setup. Let me know if you need further changes!
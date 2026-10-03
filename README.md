// README: Novelvio Flutter Application
# Novelvio - Global Rewards Application

Novelvio is a Flutter application that allows users to earn rewards by watching ads, completing tasks, inviting friends, and shopping through partner offers.

## Features

- **Multi-language Support**: 17 languages including Arabic, English, German, French, Spanish, Italian, Turkish, Russian, Portuguese, Hindi, Indonesian, Chinese, Japanese, Korean, Dutch, Polish, and Ukrainian
- **Points System**: Earn points through various activities (1000 points = $1 USD)
- **Wallet Management**: Track your balance and manage withdrawals
- **Withdrawal System**: Request payouts via PayPal or USDT (Crypto)
- **Task Completion**: Complete daily tasks and earn rewards
- **Referral Program**: Invite friends and earn bonus points
- **Supabase Integration**: Secure backend with PostgreSQL database

## Project Structure

```
lib/
├── main.dart              # Application entry point
├── app/
│   ├── app.dart          # Main app configuration
│   ├── theme.dart        # App theming
│   └── routes.dart       # Navigation routes
├── core/
│   ├── constants/        # Application constants
│   ├── services/         # Services (Supabase, Localization)
│   ├── utils/            # Utility functions
│   └── widgets/          # Reusable widgets
├── models/               # Data models
├── providers/            # State management (Provider)
├── repositories/         # Data repositories
├── screens/              # UI screens
│   ├── home/
│   ├── auth/
│   ├── wallet/
│   ├── profile/
│   └── settings/
└── l10n/                 # Localization files (ARB)

supabase/
├── migrations/           # Database migrations
│   ├── 001_initial_schema.sql
│   └── 002_withdrawal_logic.sql
├── functions/            # Edge functions
└── seed.sql             # Database seeding

test/                     # Unit and widget tests
```

## Setup Instructions

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)
- Supabase account (https://supabase.com)

### Environment Variables

Create a `.env` file or set environment variables:

```bash
export SUPABASE_URL="your-supabase-url"
export SUPABASE_ANON_KEY="your-supabase-anon-key"
```

### Installation

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd Novelvio
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Generate localization files:
   ```bash
   flutter gen-l10n
   ```

4. Run the application:
   ```bash
   flutter run
   ```

## Database Schema

The application uses Supabase PostgreSQL with the following main tables:

- **profiles**: User profiles linked to Supabase auth
- **wallets**: User wallet with points balance
- **tasks**: Available tasks to complete
- **transactions**: Transaction history
- **referrals**: Referral tracking
- **withdrawals**: Withdrawal requests (server-side processing only)
- **fraud_flags**: Fraud detection
- **app_settings**: Application configuration

## Withdrawal Process

⚠️ **Important**: All actual payment processing happens **server-side only**. The mobile app:

1. Creates a withdrawal request with user_id, amount, and method
2. Sends it to the server
3. Server validates:
   - User has sufficient points
   - Amount >= $1 USD (1000 points)
   - User is verified
4. Server initiates actual payout via PayPal API or Blockchain RPC
5. Updates withdrawal status in database

**No payment API keys or credentials are stored in the mobile app.**

## Economics

- **1000 points** = **1 USD**
- **Minimum withdrawal** = **1 USD** (1000 points)
- **Maximum withdrawal** = **10,000 USD** (10,000,000 points) per request

## Localization

Localization files are in `lib/l10n/` using the ARB (Application Resource Bundle) format.

Supported languages:
- Arabic (ar)
- German (de)
- English (en)
- Spanish (es)
- French (fr)
- Hindi (hi)
- Indonesian (id)
- Italian (it)
- Japanese (ja)
- Korean (ko)
- Dutch (nl)
- Polish (pl)
- Portuguese (pt)
- Russian (ru)
- Turkish (tr)
- Ukrainian (uk)
- Chinese (zh)

## Testing

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Analyze code
flutter analyze
```

## Security

- All sensitive credentials are managed via environment variables
- Supabase Row Level Security (RLS) policies protect user data
- Users can only access their own wallets and transactions
- Payment processing happens server-side
- No hardcoded API keys or secrets

## Contributing

1. Create a feature branch
2. Make your changes
3. Run tests and analyzer
4. Submit a pull request

## License

This project is private. See LICENSE file for details.

## Support

For support, contact: support@novelvio.com

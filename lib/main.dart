import 'package:flutter/material.dart';

class Stock {
  final String symbol;
  final String name;
  int quantity;
  final double currentPrice;
  final double percentChange;

  Stock({
    required this.symbol,
    required this.name,
    required this.quantity,
    required this.currentPrice,
    required this.percentChange,
  });
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Financial App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
      ),
      home: const MyHomePage(title: 'Financial App Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _selectedPage = 'home';
  String? _selectedStockForAction;
  String? _actionType; // 'buy' or 'sell'
  double _balance = 12450.75;
  double _lowBalanceThreshold = 1000.0;

  final List<Stock> _stocks = [
    Stock(
      symbol: 'AAPL',
      name: 'Apple Inc.',
      quantity: 50,
      currentPrice: 175.43,
      percentChange: 5.2,
    ),
    Stock(
      symbol: 'GOOGL',
      name: 'Alphabet Inc.',
      quantity: 25,
      currentPrice: 140.82,
      percentChange: -2.1,
    ),
    Stock(
      symbol: 'MSFT',
      name: 'Microsoft Corp.',
      quantity: 30,
      currentPrice: 380.15,
      percentChange: 8.7,
    ),
    Stock(
      symbol: 'TSLA',
      name: 'Tesla Inc.',
      quantity: 15,
      currentPrice: 242.50,
      percentChange: -3.5,
    ),
    Stock(
      symbol: 'AMZN',
      name: 'Amazon.com Inc.',
      quantity: 20,
      currentPrice: 180.25,
      percentChange: 12.3,
    ),
  ];

  void _selectPage(String page) {
    setState(() {
      _selectedPage = page;
    });
  }

  String _getPageTitle(String page) {
    switch (page) {
      case 'home':
        return 'Dashboard';
      case 'investments':
        return 'Investments';
      case 'alerts':
        return 'Alerts';
      case 'graphs':
        return 'Graphs';
      case 'autopay':
        return 'AutoPay';
      default:
        return 'Dashboard';
    }
  }

  Widget _buildPageContent() {
    switch (_selectedPage) {
      case 'home':
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Account Overview',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildInfoCard(
                          label: 'Balance',
                          value: '\$${_balance.toStringAsFixed(2)}',
                          icon: Icons.wallet,
                        ),
                        _buildInfoCard(
                          label: 'Account Health',
                          value: 'Excellent',
                          icon: Icons.health_and_safety,
                        ),
                        _buildInfoCard(
                          label: 'Account ID',
                          value: 'ACC-2847-6923',
                          icon: Icons.badge,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Top Spending Categories',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 16),
                    _buildSpendingCategory(
                      category: 'Groceries',
                      amount: '\$1,245.32',
                      percentage: 35,
                    ),
                    const SizedBox(height: 12),
                    _buildSpendingCategory(
                      category: 'Utilities',
                      amount: '\$892.50',
                      percentage: 25,
                    ),
                    const SizedBox(height: 12),
                    _buildSpendingCategory(
                      category: 'Entertainment',
                      amount: '\$654.18',
                      percentage: 18,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.notifications_active,
                          color: Theme.of(context).colorScheme.error,
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Alert Center',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.error,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildAlert(
                      title: 'Unusual Activity',
                      message: 'Large purchase detected on 04/28',
                      severity: 'warning',
                    ),
                    const SizedBox(height: 12),
                    _buildAlert(
                      title: 'Bill Reminder',
                      message: 'Your electric bill is due on 05/05',
                      severity: 'info',
                    ),
                    const SizedBox(height: 12),
                    _buildAlert(
                      title: 'Low Balance Alert',
                      message: 'Your balance will fall below \$5,000 this month',
                      severity: 'warning',
                    ),
                  ],
                ),
              ),
            ],
          ),
        );      case 'investments':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Your Stock Portfolio',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Tooltip(
                  message: 'Coming soon',
                  child: ElevatedButton.icon(
                    onPressed: null,
                    icon: const Icon(Icons.add),
                    label: const Text('Buy Other Stocks'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  child: _buildStockTable(),
                ),
              ),
            ),
          ],
        );
      case 'alerts':
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Security Alerts',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 24),
              if (_balance < _lowBalanceThreshold)
                Column(
                  children: [
                    _buildAlertItem(
                      title: 'Low Account Balance',
                      description:
                          'Your account balance is below \$${_lowBalanceThreshold.toStringAsFixed(2)}. Current balance: \$${_balance.toStringAsFixed(2)}',
                      severity: 'high',
                      timestamp: 'Now',
                      onApprove: () => _approveAlert(0),
                      onDeny: () => _denyAlert(0),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              _buildAlertItem(
                title: 'Suspicious Activity Detected',
                description: 'Large purchase of \$5,250 detected on your account at 2:45 PM today.',
                severity: 'high',
                timestamp: 'Just now',
                onApprove: () => _approveAlert(1),
                onDeny: () => _denyAlert(1),
              ),
              const SizedBox(height: 16),
              _buildAlertItem(
                title: 'Unusual Location',
                description: 'Login attempt from a new location: New York, NY',
                severity: 'medium',
                timestamp: '2 hours ago',
                onApprove: () => _approveAlert(2),
                onDeny: () => _denyAlert(2),
              ),
              const SizedBox(height: 16),
              _buildAlertItem(
                title: 'Password Change',
                description: 'Your password was successfully changed.',
                severity: 'low',
                timestamp: '1 day ago',
                onApprove: () => _approveAlert(3),
                onDeny: () => _denyAlert(3),
              ),
            ],
          ),
        );
      default:
        return SizedBox.expand(
          child: Center(
            child: Text(
              '${_getPageTitle(_selectedPage)} content coming soon',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        );
    }
  }

  Widget _buildInfoCard({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 32),
        const SizedBox(height: 12),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildSpendingCategory({
    required String category,
    required String amount,
    required int percentage,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              category,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              amount,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: percentage / 100,
            minHeight: 8,
            backgroundColor: Theme.of(context).colorScheme.outlineVariant,
            valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '$percentage% of spending',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _buildAlert({
    required String title,
    required String message,
    required String severity,
  }) {
    Color severityColor = severity == 'warning'
        ? Theme.of(context).colorScheme.error
        : Theme.of(context).colorScheme.primary;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.white.withOpacity(0.7)
            : Colors.grey.shade900,
        border: Border.all(color: severityColor, width: 4),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            severity == 'warning' ? Icons.warning : Icons.info,
            color: severityColor,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlertItem({
    required String title,
    required String description,
    required String severity,
    required String timestamp,
    required VoidCallback onApprove,
    required VoidCallback onDeny,
  }) {
    Color severityColor;
    IconData severityIcon;

    switch (severity) {
      case 'high':
        severityColor = Colors.red;
        severityIcon = Icons.error;
        break;
      case 'medium':
        severityColor = Colors.orange;
        severityIcon = Icons.warning;
        break;
      case 'low':
        severityColor = Colors.blue;
        severityIcon = Icons.info;
        break;
      default:
        severityColor = Colors.grey;
        severityIcon = Icons.info;
    }

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(color: severityColor, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(severityIcon, color: severityColor, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      timestamp,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: onDeny,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: const Text('Deny', style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: onApprove,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: const Text('Approve', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _approveAlert(int index) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Alert approved')),
    );
    setState(() {});
  }

  void _denyAlert(int index) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Alert denied')),
    );
    setState(() {});
  }

  Widget _buildStockTable() {
    return DataTable(
      columns: const [
        DataColumn(label: Text('Symbol')),
        DataColumn(label: Text('Company')),
        DataColumn(label: Text('Quantity')),
        DataColumn(label: Text('Value')),
        DataColumn(label: Text('Change')),
        DataColumn(label: Text('Trend')),
        DataColumn(label: Text('Buy')),
        DataColumn(label: Text('Sell')),
      ],
      rows: _stocks.map((stock) {
        Color changeColor = stock.percentChange >= 0 ? Colors.green : Colors.red;
        IconData trendIcon = stock.percentChange >= 0 ? Icons.trending_up : Icons.trending_down;

        return DataRow(
          cells: [
            DataCell(Text(stock.symbol, style: const TextStyle(fontWeight: FontWeight.bold))),
            DataCell(Text(stock.name)),
            DataCell(Text(stock.quantity.toString())),
            DataCell(Text('\$${(stock.quantity * stock.currentPrice).toStringAsFixed(2)}')),
            DataCell(
              Text(
                '${stock.percentChange >= 0 ? '+' : ''}${stock.percentChange.toStringAsFixed(1)}%',
                style: TextStyle(color: changeColor, fontWeight: FontWeight.bold),
              ),
            ),
            DataCell(Icon(trendIcon, color: changeColor)),
            DataCell(
              ElevatedButton(
                onPressed: () => _showBuySellDialog(stock, 'buy'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: const Text('Buy', style: TextStyle(color: Colors.white)),
              ),
            ),
            DataCell(
              ElevatedButton(
                onPressed: () => _showBuySellDialog(stock, 'sell'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: const Text('Sell', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  void _showBuySellDialog(Stock stock, String action) {
    int quantity = 1;

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text('${action == 'buy' ? 'Buy' : 'Sell'} ${stock.symbol}'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Current price: \$${stock.currentPrice.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: quantity > 1
                            ? () => setDialogState(() => quantity--)
                            : null,
                      ),
                      SizedBox(
                        width: 60,
                        child: TextField(
                          controller: TextEditingController(text: quantity.toString()),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            int? parsed = int.tryParse(value);
                            if (parsed != null && parsed > 0) {
                              setDialogState(() => quantity = parsed);
                            }
                          },
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () => setDialogState(() => quantity++),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Total: \$${(quantity * stock.currentPrice).toStringAsFixed(2)}',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Update the stock quantity and balance
                    int stockIndex = _stocks.indexWhere((s) => s.symbol == stock.symbol);
                    if (stockIndex != -1) {
                      double transactionAmount = quantity * stock.currentPrice;
                      
                      if (action == 'buy') {
                        // Check if user has enough balance to buy
                        if (transactionAmount <= _balance) {
                          _stocks[stockIndex].quantity += quantity;
                          _balance -= transactionAmount;
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Insufficient balance. Need \$${transactionAmount.toStringAsFixed(2)}, have \$${_balance.toStringAsFixed(2)}',
                              ),
                            ),
                          );
                          return;
                        }
                      } else {
                        // Check if user has enough shares to sell
                        if (quantity <= _stocks[stockIndex].quantity) {
                          _stocks[stockIndex].quantity -= quantity;
                          _balance += transactionAmount;
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Cannot sell more than ${_stocks[stockIndex].quantity} shares'),
                            ),
                          );
                          return;
                        }
                      }
                      // Call parent setState to update the entire page
                      setState(() {});
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Successfully ${action == 'buy' ? 'bought' : 'sold'} $quantity shares of ${stock.symbol}',
                        ),
                      ),
                    );
                    Navigator.pop(context);
                  },
                  child: Text(action == 'buy' ? 'Buy' : 'Sell'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Row(
        children: [
          Container(
            width: 250,
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  color: Theme.of(context).colorScheme.primary,
                  child: Text(
                    'Applications',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.white),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.dashboard),
                  title: const Text('Dashboard'),
                  selected: _selectedPage == 'home',
                  onTap: () => _selectPage('home'),
                ),
                ListTile(
                  leading: const Icon(Icons.trending_up),
                  title: const Text('Investments'),
                  selected: _selectedPage == 'investments',
                  onTap: () => _selectPage('investments'),
                ),
                ListTile(
                  leading: const Icon(Icons.notifications),
                  title: const Text('Alerts'),
                  selected: _selectedPage == 'alerts',
                  onTap: () => _selectPage('alerts'),
                ),
                ListTile(
                  leading: const Icon(Icons.bar_chart),
                  title: const Text('Graphs'),
                  selected: _selectedPage == 'graphs',
                  onTap: () => _selectPage('graphs'),
                ),
                ListTile(
                  leading: const Icon(Icons.autorenew),
                  title: const Text('AutoPay'),
                  selected: _selectedPage == 'autopay',
                  onTap: () => _selectPage('autopay'),
                ),
              ],
            ),
          ),
          const VerticalDivider(width: 1),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Main Content',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceVariant,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.all(24),
                      child: _buildPageContent(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

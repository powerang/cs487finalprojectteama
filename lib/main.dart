import 'package:flutter/material.dart';

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
        return Column(
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
                        value: '\$12,450.75',
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
          ],
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

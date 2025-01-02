import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons_app/defines.dart';

void main() => runApp(AppView());

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Boxicons Demo',
      home: HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String searchQuery = '';

  void filterIcons(String query) {
    setState(() {
      searchQuery = query;
    });
  }

  List<Boxicon> getFilteredIcons(List<Boxicon> icons) {
    if (searchQuery.isEmpty) return icons;
    return icons
        .where((icon) =>
            icon.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Boxicons Demo'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Regular'),
              Tab(text: 'Solid'),
              Tab(text: 'Logo'),
            ],
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Search icons...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onChanged: filterIcons,
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  IconGridView(icons: getFilteredIcons(regularIcons)),
                  IconGridView(icons: getFilteredIcons(solidIcons)),
                  IconGridView(icons: getFilteredIcons(logoIcons)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IconGridView extends StatelessWidget {
  final List<Boxicon> icons;

  const IconGridView({
    super.key,
    required this.icons,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Wrap(
        children: icons.map((icon) {
          return IconView(icon: icon);
        }).toList(),
      ),
    );
  }
}

class IconView extends StatelessWidget {
  final Boxicon icon;

  const IconView({
    super.key,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final iconName = 'Boxicons.${icon.name}';
        FlutterClipboard.copy(iconName);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Copied $iconName to clipboard'),
          ),
        );
      },
      child: Card.outlined(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon.icon),
              const SizedBox(width: 12),
              Text(icon.name),
            ],
          ),
        ),
      ),
    );
  }
}

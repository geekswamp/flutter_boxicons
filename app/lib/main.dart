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

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Boxicons Demo'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Regular'),
              Tab(text: 'Solid'),
              Tab(text: 'Logo'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            RegularIconsView(),
            SolidIconsView(),
            LogoIconsView(),
          ],
        ),
      ),
    );
  }
}

class RegularIconsView extends StatelessWidget {
  const RegularIconsView({super.key});

  @override
  Widget build(BuildContext context) {
    return IconGridView(
      icons: regularIcons,
    );
  }
}

class SolidIconsView extends StatelessWidget {
  const SolidIconsView({super.key});

  @override
  Widget build(BuildContext context) {
    return IconGridView(
      icons: solidIcons,
    );
  }
}

class LogoIconsView extends StatelessWidget {
  const LogoIconsView({super.key});

  @override
  Widget build(BuildContext context) {
    return IconGridView(
      icons: logoIcons,
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
          return Card.outlined(
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
          );
        }).toList(),
      ),
    );
  }
}

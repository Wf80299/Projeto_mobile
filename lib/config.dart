import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  final Function(bool) onThemeChanged;
  final ThemeMode themeMode;

  const SettingsScreen({
    super.key,
    required this.onThemeChanged,
    required this.themeMode,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  @override
  Widget build(BuildContext context) {
    
    final bool isDark = widget.themeMode == ThemeMode.dark;

    return Scaffold(
      
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          // Cor do ícone vindo do tema
          color: Theme.of(context).colorScheme.onSurface,
          iconSize: 28,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            // Cor do ícone vindo do tema
            color: Theme.of(context).colorScheme.onSurface,
            iconSize: 28,
            onPressed: () {
              // Ação para a tela de perfil
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Configurações',
              // Estilo do texto vindo do Tema
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 30),

            _buildSettingsItem(
              context: context, 
              title: 'Tema',
              trailingWidget: Switch(
                value: isDark,
                onChanged: (value) {
                  widget.onThemeChanged(value);
                },
                activeColor: Theme.of(context).colorScheme.primary,
              ),
            ),

            const SizedBox(height: 20),

            _buildSettingsItem(
              context: context,
              title: 'Idioma',
              trailingWidget: Icon(
                Icons.language,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                size: 28,
              ),
            ),

            const Spacer(),

            _buildSettingsItem(
              context: context,
              title: 'Sobre',
              trailingWidget: Icon(
                Icons.arrow_forward_ios,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                size: 20,
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsItem({
    required BuildContext context,
    required String title,
    required Widget trailingWidget,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          trailingWidget,
        ],
      ),
    );
  }
}
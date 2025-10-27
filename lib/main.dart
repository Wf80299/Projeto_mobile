import 'package:flutter/material.dart';
// 1. Importe o novo arquivo
import 'package:meu_app/temperature_converter.dart'; // Mude 'seu_projeto' para o nome correto

void main() {
  runApp(MeuApp());
}

class MeuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workspace App',
      theme: ThemeData(
        // Removi o 'const' aqui pois a classe ThemeData não precisa dele, mas é opcional
        primarySwatch: Colors.blue,
      ),
      home: TelaInicial(),
    );
  }
}

class TelaInicial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workspace'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Aqui você pode adicionar ação de notificações
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Aqui você pode adicionar ação de configurações
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          // Espaço para imagem de destaque
          Container(
            height: 200,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(child: Text('Imagem do Workspace aqui')),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              // 2. Ação de Navegação: Adiciona a rota para a tela do conversor
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TemperatureConverterScreen(), // Navega para a nova tela
                ),
              );
            },
            child: const Text('Acessar Conversor de Temperatura'), // Mudei o texto do botão para clareza
          ),
        ],
      ),
    );
  }
}
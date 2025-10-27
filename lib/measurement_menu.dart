import 'package:flutter/material.dart';
import 'package:meu_app/temperature_converter.dart';

class MeasurementMenuScreen extends StatelessWidget {
  const MeasurementMenuScreen({super.key});

  // Widget auxiliar para criar botões com o estilo da imagem
  Widget _buildMenuButton(String text, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0), // Espaçamento entre os botões
      child: SizedBox(
        width: 250, // Largura fixa para replicar o visual
        height: 55,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue, // Fundo azul
            foregroundColor: Colors.white, // Cor do texto
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0), // Borda arredondada
              side: const BorderSide(color: Colors.black, width: 1.0), // Borda preta fina
            ),
            elevation: 0, // Sem sombra para o efeito da borda preta
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          ),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // Estica os elementos horizontalmente
          children: <Widget>[
            // 1. Cabeçalho com Ícone e Título
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 60.0), // Padding do cabeçalho
              child: Row(
                children: <Widget>[
                  const Icon(
                    Icons.settings, // Ícone de engrenagem
                    size: 28.0,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 15.0),
                  const Expanded(
                    child: Text(
                      'CONVERSOR\nDE MEDIDAS',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        height: 1.2, // Espaçamento entre as linhas
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 2. Botões de Menu Centralizados
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start, // Alinha os botões no topo da área expandida
                children: <Widget>[
                  _buildMenuButton(
                    'TEMPO',
                    () {
                      // Ação para navegar para o Conversor de TEMPO
                      debugPrint('Botão TEMPO pressionado');
                    },
                  ),
                  _buildMenuButton(
                  'TEMPERATURA',
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                        builder: (context) => const TemperatureConverterScreen(),
                        ),
                      );
                    },
                  ),
                  _buildMenuButton(
                    'COMPRIMENTO',
                    () {
                      // Ação para navegar para o Conversor de COMPRIMENTO
                      debugPrint('Botão COMPRIMENTO pressionado');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
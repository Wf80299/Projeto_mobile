import 'package:flutter/material.dart';

// --- Dados de Exemplo ---
// Como a funcionalidade não é o foco, vamos simular os seletores
const List<String> _temperaturas = ['°C', '°F', 'K'];

class TemperatureConverterScreen extends StatefulWidget {
  const TemperatureConverterScreen({super.key});

  @override
  State<TemperatureConverterScreen> createState() =>
      _TemperatureConverterScreenState();
}

class _TemperatureConverterScreenState
    extends State<TemperatureConverterScreen> {
  String _deUnidade = '°C';
  String _paraUnidade = '°F';

  // Widget para simular o seletor (DropdownButton) com o visual da imagem
  Widget _buildUnitSelector(String value, ValueChanged<String?> onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          icon: const Icon(Icons.arrow_drop_down), // Ícone 'v'
          style: const TextStyle(fontSize: 16.0, color: Colors.black),
          onChanged: onChanged,
          items: _temperaturas.map<DropdownMenuItem<String>>((String unit) {
            return DropdownMenuItem<String>(
              value: unit,
              child: Text(unit),
            );
          }).toList(),
        ),
      ),
    );
  }

  // Ação para trocar as unidades (o ícone de dupla seta)
  void _swapUnits() {
    setState(() {
      String temp = _deUnidade;
      _deUnidade = _paraUnidade;
      _paraUnidade = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar para o cabeçalho e o botão de voltar
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove o botão de voltar padrão
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // O ícone de seta para a esquerda
          onPressed: () {
 // Ação de voltar: use Navigator.pop(context) para voltar à tela anterior
             Navigator.pop(context); // Mude esta linha!
 },
        ),
        title: const Text(
          'CONVERSÃO DE\nTEMPERATURA',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0, // Remove a sombra
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // 1. Campo de Entrada de Temperatura
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Ex.: 24º',
                  border: InputBorder.none, // Remove a borda padrão do TextField
                ),
                keyboardType: TextInputType.number,
                style: TextStyle(fontSize: 24.0),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                'Insira o valor e escolha as unidades',
                style: TextStyle(color: Colors.grey, fontSize: 12.0),
              ),
            ),

            const SizedBox(height: 40.0), // Espaçamento

            // 2. Seletores "De" e "Para"
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // Seletor "De"
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text('De', style: TextStyle(fontSize: 18.0)),
                      const SizedBox(height: 8.0),
                      _buildUnitSelector(_deUnidade, (String? newValue) {
                        setState(() {
                          _deUnidade = newValue!;
                        });
                      }),
                    ],
                  ),
                ),

                // Ícone de troca (setas)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: IconButton(
                    icon: const Icon(Icons.swap_horiz, size: 30.0),
                    onPressed: _swapUnits,
                    color: Colors.grey,
                  ),
                ),

                // Seletor "Para"
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text('Para', style: TextStyle(fontSize: 18.0)),
                      const SizedBox(height: 8.0),
                      _buildUnitSelector(_paraUnidade, (String? newValue) {
                        setState(() {
                          _paraUnidade = newValue!;
                        });
                      }),
                    ],
                  ),
                ),
              ],
            ),

            const Spacer(), // Empurra o botão para a parte inferior

            // 3. Botão "Converter"
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Ação de conversão aqui
                  debugPrint("Botão Converter pressionado");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // A cor azul vibrante
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  elevation: 5, // Sombra sutil
                ),
                child: const Text(
                  'Converter',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10), // Espaçamento inferior
          ],
        ),
      ),
    );
  }

}


// Para rodar no 'main.dart':

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Conversor de Temperatura',
      home: TemperatureConverterScreen(),
    );
  }
}

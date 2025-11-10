import 'package:flutter/material.dart';

const List<String> _temperaturas = ['°C', '°F', 'K'];

class TemperatureConverterScreen extends StatefulWidget {
  const TemperatureConverterScreen({super.key});

  @override
  State<TemperatureConverterScreen> createState() =>
      _TemperatureConverterScreenState();
}

class _TemperatureConverterScreenState
    extends State<TemperatureConverterScreen> {
  // Controladores e Variáveis de Estado
  final TextEditingController _inputController = TextEditingController();
  String _deUnidade = '°C';
  String _paraUnidade = '°F';
  String _resultado = ''; 

  @override
  void dispose() {
    // Limpar o controlador ao sair da tela
    _inputController.dispose();
    super.dispose();
  }

  // Widget para simular o seletor (DropdownButton)
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
          icon: const Icon(Icons.arrow_drop_down),
          // MUDANÇA Cor do texto do seletor usa o Tema 
          style: TextStyle(
            fontSize: 16.0,
            color: Theme.of(context).colorScheme.onSurface,
          ),
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

  // Ação para trocar as unidades
  void _swapUnits() {
    setState(() {
      String temp = _deUnidade;
      _deUnidade = _paraUnidade;
      _paraUnidade = temp;
      _convert(); // Recalcula ao trocar
    });
  }

  // AÇÃO DE CONVERSÃO 
  void _convert() {
    double? input = double.tryParse(_inputController.text.replaceAll(',', '.'));

    if (input == null) {
      if (_inputController.text.isEmpty) {
         setState(() {
           _resultado = ''; 
         });
      } else {
         setState(() {
           _resultado = 'Valor inválido';
         });
      }
      return;
    }

    double output;
    String from = _deUnidade;
    String to = _paraUnidade;

    // Se for a mesma unidade
    if (from == to) {
      output = input;
    } else {
      // Converter a entrada para a unidade base (Celsius)
      double celsiusValue;
      if (from == '°C') {
        celsiusValue = input;
      } else if (from == '°F') {
        celsiusValue = (input - 32) * 5 / 9;
      } else { // Kelvin (K)
        celsiusValue = input - 273.15;
      }

      // Converter de Celsius para a unidade de saída
      if (to == '°C') {
        output = celsiusValue;
      } else if (to == '°F') {
        output = (celsiusValue * 9 / 5) + 32;
      } else { // Kelvin (K)
        output = celsiusValue + 273.15;
      }
    }

    setState(() {
      // Formata para 2 casas decimais e adiciona a unidade
      _resultado = '${output.toStringAsFixed(2)} $to';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar para o cabeçalho
      appBar: AppBar(
         automaticallyImplyLeading: false,
         leading: IconButton(
          // MUDANÇA Cor do ícone usa o Tema 
          icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onSurface),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'CONVERSÃO DE\nTEMPERATURA',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            //  MUDANÇA Cor do título usa o Tema 
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        centerTitle: true,
  
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0, 
      ),
      
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            //  Campo de Entrada de Temperatura
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: TextField(
                controller: _inputController, // Conectado ao controlador
                decoration: const InputDecoration(
                  hintText: 'Ex.: 24',
                  border: InputBorder.none,
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                
                style: TextStyle(
                  fontSize: 24.0,
                  color: Theme.of(context).colorScheme.onSurface
                ),
                onChanged: (value) => _convert(), // Converte ao digitar
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

            // Seletores "De" e "Para"
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
                          _convert(); 
                        });
                      }),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: IconButton(
                    icon: const Icon(Icons.swap_horiz, size: 30.0),
                    onPressed: _swapUnits, // Já chama o _convert()
                    color: Colors.grey,
                  ),
                ),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text('Para', style: TextStyle(fontSize: 18.0)),
                      const SizedBox(height: 8.0),
                      _buildUnitSelector(_paraUnidade, (String? newValue) {
                        setState(() {
                          _paraUnidade = newValue!;
                           _convert(); // Recalcula ao mudar
                        });
                      }),
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 30),

            if (_resultado.isNotEmpty)
              Center(
                child: Text(
                  _resultado,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                
                    color: _resultado == 'Valor inválido' 
                      ? Colors.red 
                      : Theme.of(context).colorScheme.primary, // Cor primária do tema
                  ),
                ),
              ),

            const Spacer(), 

            // Botão "Converter"
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: _convert, // Chama a função de conversão
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary, // Cor de fundo
                  foregroundColor: Theme.of(context).colorScheme.onPrimary, // Cor do texto
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  elevation: 5, 
                ),
                child: const Text(
                  'Converter',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
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
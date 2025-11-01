import 'package:flutter/material.dart';

// --- Dados de Exemplo ---
// Lista de unidades de comprimento
const List<String> _unidadesComprimento = [
  'Metros',
  'Centímetros',
];

class LengthConverterScreen extends StatefulWidget {
  const LengthConverterScreen({super.key});

  @override
  State<LengthConverterScreen> createState() =>
      _LengthConverterScreenState();
}

class _LengthConverterScreenState
    extends State<LengthConverterScreen> {
  String _deUnidade = 'Metros';
  String _paraUnidade = 'Centímetros';

  // 1. Controlador para o campo de texto
  final TextEditingController _controller = TextEditingController();
  String _resultado = '';

  @override
  void dispose() {
    // 2. Limpar o controlador ao sair da tela
    _controller.dispose();
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
          icon: const Icon(Icons.arrow_drop_down), // Ícone 'v'
          style: const TextStyle(fontSize: 16.0, color: Colors.black),
          onChanged: onChanged,
          items:
              _unidadesComprimento.map<DropdownMenuItem<String>>((String unit) {
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
      _converter(); // Recalcula ao trocar
    });
  }

  // 3. Lógica de Conversão
  void _converter() {
    // Tenta converter o texto de entrada para um número
    double? valorEntrada = double.tryParse(_controller.text.replaceAll(',', '.'));
    
    // Se a entrada for inválida ou vazia, limpa o resultado
    if (valorEntrada == null) {
      setState(() {
        _resultado = 'Valor inválido';
      });
      return;
    }

    double valorSaida;

    // Lógica principal de conversão
    if (_deUnidade == 'Metros' && _paraUnidade == 'Centímetros') {
      valorSaida = valorEntrada * 100;
    } else if (_deUnidade == 'Centímetros' && _paraUnidade == 'Metros') {
      valorSaida = valorEntrada / 100;
    } else {
      // Caso 'De' e 'Para' sejam iguais
      valorSaida = valorEntrada;
    }

    // Atualiza o estado com o resultado formatado
    setState(() {
      // .toStringAsFixed(2) para limitar a 2 casas decimais
      _resultado = '${valorSaida.toStringAsFixed(2)} $_paraUnidade';
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
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'CONVERSOR DE\nCOMPRIMENTO', // Título alterado
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
            // 1. Campo de Entrada de Comprimento
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: TextField( // Alterado de 'const'
                controller: _controller, // 4. Associar o controlador
                decoration: const InputDecoration(
                  hintText: 'Ex.: 1.75', // Dica alterada
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
                          _converter(); // Recalcula ao mudar unidade
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
                          _converter(); // Recalcula ao mudar unidade
                        });
                      }),
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 30),

            // 5. Exibição do Resultado
            if (_resultado.isNotEmpty)
              Center(
                child: Text(
                  _resultado,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade700,
                  ),
                ),
              ),

            const Spacer(), // Empurra o botão para a parte inferior

            // 3. Botão "Converter"
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: _converter, // 6. Chamar a função _converter
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



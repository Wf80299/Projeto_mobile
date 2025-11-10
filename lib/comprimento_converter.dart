import 'package:flutter/material.dart';

const List<String> _unidadesComprimento = [
  'Quilômetros',
  'Metros',
  'Centímetros',
  'Milímetros',
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

  final TextEditingController _controller = TextEditingController();
  String _resultado = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
          
          style: TextStyle(
            fontSize: 16.0,
            color: Theme.of(context).colorScheme.onSurface,
          ),
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

  void _swapUnits() {
    setState(() {
      String temp = _deUnidade;
      _deUnidade = _paraUnidade;
      _paraUnidade = temp;
      _converter(); 
    });
  }

  void _converter() {
    double? valorEntrada = double.tryParse(_controller.text.replaceAll(',', '.'));
    
    if (valorEntrada == null) {
      if (_controller.text.isEmpty) {
        setState(() { _resultado = ''; });
      } else {
        setState(() { _resultado = 'Valor inválido'; });
      }
      return;
    }

    double valorSaida;
    
    double valorEmMetros;
    if (_deUnidade == 'Quilômetros') {
      valorEmMetros = valorEntrada * 1000;
    } else if (_deUnidade == 'Centímetros') {
      valorEmMetros = valorEntrada / 100;
    } else if (_deUnidade == 'Milímetros') {
      valorEmMetros = valorEntrada / 1000;
    } else { 
      valorEmMetros = valorEntrada;
    }

    
    if (_paraUnidade == 'Quilômetros') {
      valorSaida = valorEmMetros / 1000;
    } else if (_paraUnidade == 'Centímetros') {
      valorSaida = valorEmMetros * 100;
    } else if (_paraUnidade == 'Milímetros') {
      valorSaida = valorEmMetros * 1000;
    } else { 
      valorSaida = valorEmMetros;
    }

    setState(() {
      _resultado = '${valorSaida.toStringAsFixed(2)} $_paraUnidade';
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, 
        leading: IconButton(
          
          icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onSurface),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'CONVERSOR DE\nCOMPRIMENTO',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
      
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Ex.: 1.75', 
                  border: InputBorder.none, 
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                
                style: TextStyle(
                  fontSize: 24.0,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                onChanged: (value) => _converter(), 
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                'Insira o valor e escolha as unidades',
                style: TextStyle(color: Colors.grey, fontSize: 12.0),
              ),
            ),

            const SizedBox(height: 40.0), 

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text('De', style: TextStyle(fontSize: 18.0)),
                      const SizedBox(height: 8.0),
                      _buildUnitSelector(_deUnidade, (String? newValue) {
                        setState(() {
                          _deUnidade = newValue!;
                          _converter(); 
                        });
                      }),
                    ],
                  ),
                ),

                
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: IconButton(
                    icon: const Icon(Icons.swap_horiz, size: 30.0),
                    onPressed: _swapUnits,
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
                          _converter();
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
                      : Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),

            const Spacer(), 
           
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: _converter, 
               
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
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
            const SizedBox(height: 10), 
          ],
        ),
      ),
    );
  }
}
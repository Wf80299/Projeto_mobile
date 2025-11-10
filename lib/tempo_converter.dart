import 'package:flutter/material.dart';

const List<String> _unidadesTempo = ['Horas', 'Minutos', 'Segundos']; 

class TimeConverterScreen extends StatefulWidget {
  const TimeConverterScreen({super.key});

  @override
  State<TimeConverterScreen> createState() =>
      _TimeConverterScreenState();
}

class _TimeConverterScreenState
    extends State<TimeConverterScreen> {
  // Controladores e Variáveis de Estado
  final TextEditingController _inputController = TextEditingController();
  String _deUnidade = 'Horas';
  String _paraUnidade = 'Minutos';
  String _resultado = '';

  @override
  void dispose() {
    _inputController.dispose();
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
          items: _unidadesTempo.map<DropdownMenuItem<String>>((String unit) {
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
      _convert(); 
    });
  }

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

    double valorEmMinutos;
    if (_deUnidade == 'Horas') {
      valorEmMinutos = input * 60;
    } else if (_deUnidade == 'Segundos') {
      valorEmMinutos = input / 60;
    } else {
      valorEmMinutos = input;
    }

  
    if (_paraUnidade == 'Horas') {
      output = valorEmMinutos / 60;
    } else if (_paraUnidade == 'Segundos') {
      output = valorEmMinutos * 60;
    } else {
      output = valorEmMinutos;
    }
    

    String formattedOutput;
    if (output == output.toInt()) {
      formattedOutput = output.toInt().toString();
    } else {
      formattedOutput = output.toStringAsFixed(2);
    }

    setState(() {
      _resultado = '$formattedOutput $_paraUnidade';
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
          'CONVERSOR DE\nTEMPO', 
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
                controller: _inputController, 
                decoration: const InputDecoration(
                  hintText: 'Ex.: 2.5', 
                  border: InputBorder.none,
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                
                style: TextStyle(
                  fontSize: 24.0,
                  color: Theme.of(context).colorScheme.onSurface
                ),
                onChanged: (value) => _convert(),
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
                          _convert(); 
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
                onPressed: _convert, 
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
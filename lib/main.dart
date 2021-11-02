import 'package:flutter/material.dart';

void main() => runApp(const BytebankApp());

class BytebankApp extends StatelessWidget {
  const BytebankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FormularioTransferencia(),
      )
    );
  }
}

class FormularioTransferencia extends StatelessWidget{
  FormularioTransferencia({Key? key}) : super(key: key);

  final TextEditingController _controladorCampoNumeroConta = TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Criando Transferência')),
      body: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _controladorCampoNumeroConta,
            style: const TextStyle(
              fontSize: 24,
            ),
            decoration: const InputDecoration(
              labelText: 'Número da conta',
              hintText: '0000',
            ),
            keyboardType: TextInputType.number,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _controladorCampoValor,
            style: const TextStyle(
              fontSize: 24,
            ),
            decoration: const InputDecoration(
              icon: Icon(Icons.monetization_on),
              labelText: 'Valor',
              hintText: '0.00',
            ),
            keyboardType: TextInputType.number,
          ),
        ),
        ElevatedButton(
          child: const Text('Confirmar'),
          onPressed: () {
            debugPrint('clicou no confirmar');
            debugPrint(_controladorCampoValor.text);

            final int? numeroConta = int.tryParse(_controladorCampoNumeroConta.text);
            final double? valor = double.tryParse(_controladorCampoValor.text);

            if(numeroConta != null && valor != null) {
              final transferenciaCriada = TransferenciaDto(valor, numeroConta);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Valor inválido 1!'),
                ),
              );
            }
          },
        ),
      ],
      ),
    );
  }
}


class ListaTransferencias extends StatelessWidget {
  const ListaTransferencias({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (
        Column(
          children: <Widget>[
            Transferencia(transferenciaDto: TransferenciaDto(300.0, 200)), 
            Transferencia(transferenciaDto: TransferenciaDto(200.0, 200)), 
            Transferencia(transferenciaDto: TransferenciaDto(300.0, 200)), 
            Transferencia(transferenciaDto: TransferenciaDto(900.0, 200)), 
          ],
        )
      ),
      appBar: AppBar(title: const Text('Transferências'),
      ),
    );
  }
}

class Transferencia extends StatelessWidget {
  
  TransferenciaDto transferenciaDto;

  Transferencia({Key? key, required this.transferenciaDto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Card(
            child: ListTile(
              leading: const Icon(Icons.monetization_on),
              title: Text(transferenciaDto.valor.toString()),
              subtitle: Text(transferenciaDto.numeroConta.toString()),
            ),
          );
  }
}

class TransferenciaDto {
  final double valor;
  final int numeroConta;

  TransferenciaDto(this.valor, this.numeroConta);
}
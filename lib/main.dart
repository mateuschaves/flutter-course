import 'package:flutter/material.dart';

void main() => runApp(const BytebankApp());

class BytebankApp extends StatelessWidget {
  const BytebankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListaTransferencias(),
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
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
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
              final int? numeroConta = int.tryParse(_controladorCampoNumeroConta.text);
              final double? valor = double.tryParse(_controladorCampoValor.text);
      
              if(numeroConta != null && valor != null) {
                final transferenciaCriada = TransferenciaDto(valor, numeroConta);
                Navigator.pop(context, transferenciaCriada);
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
      ),
    );
  }
}


// ignore: must_be_immutable
class ListaTransferencias extends StatefulWidget {
  ListaTransferencias({Key? key}) : super(key: key);

  final List<TransferenciaDto> _transferencias = List.empty(growable: true);

  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciasState();
  }
}

class ListaTransferenciasState extends State<ListaTransferencias> {
@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (
        ListView.builder(
          itemCount: widget._transferencias.length,
          itemBuilder: (context, index) {
            final transferencia = widget._transferencias[index];
            return Transferencia(transferenciaDto: transferencia);
          },
        )
      ),
      appBar: AppBar(title: const Text('Transferências')),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed:() {
          final Future<TransferenciaDto?> future = Navigator.push<TransferenciaDto>(context, MaterialPageRoute(builder: (context) {
            return FormularioTransferencia();
          }));

          future.then((transferenciaRecebida) => {
            if (transferenciaRecebida != null) {
              setState(() {
                widget._transferencias.add(transferenciaRecebida);
              })
            }
          });
        },
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
import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(
    home: Scaffold(
      body: const ListaTransferencias(),
      appBar: AppBar(title: const Text('Transferências'),),
    )
  )
);


class ListaTransferencias extends StatelessWidget {
  const ListaTransferencias({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (
      Column(
        children: <Widget>[
          Transferencia(transferenciaDto: TransferenciaDto(300.0, 200)), 
          Transferencia(transferenciaDto: TransferenciaDto(200.0, 200)), 
          Transferencia(transferenciaDto: TransferenciaDto(300.0, 200)), 
          Transferencia(transferenciaDto: TransferenciaDto(900.0, 200)), 
        ],
      )
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
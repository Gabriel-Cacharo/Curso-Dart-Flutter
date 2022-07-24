
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;

  const TransactionList(this.transactions, this.onRemove);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty ? LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
        children: <Widget>[
          const SizedBox(height: 20),
          Text('Nenhuma Transação Cadastrada', style: Theme.of(context).textTheme.headline6),
          const SizedBox(height: 20),
          SizedBox(
            height: constraints.maxHeight * 0.6,
            child: Image.asset(
              'assets/images/waiting.png', 
              fit: BoxFit.cover
            )
          )
        ]);
      }
    ) : ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (ctx, index) {
        final tr = transactions[index];
        return Card(
          elevation: 5,
          margin: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 5
          ),
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundColor: Theme.of(context).primaryColor,
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: FittedBox(
                  child: Text('R\$${tr.value}', style: const TextStyle(color: Colors.white),)
                ),
              )
            ),
            title: Text(
              tr.title,
              style: Theme.of(context).textTheme.headline6
            ),
            subtitle: Text(
              DateFormat('d MMM y').format(tr.date)
            ),
            trailing: MediaQuery.of(context).size.width > 400 ? 
            TextButton.icon(
              onPressed: () => onRemove(tr.id),
              icon: const Icon(Icons.delete_outlined),
              style: TextButton.styleFrom(primary: Theme.of(context).errorColor),
              label: const Text('Excluir'),
            )
            : IconButton(
              icon: const Icon(Icons.delete_outlined),
              color: Theme.of(context).errorColor,
              onPressed: () => onRemove(tr.id)
            ),
          ),
        );
      }
    );
  }
}
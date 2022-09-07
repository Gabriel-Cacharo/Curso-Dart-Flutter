import 'dart:math';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'components/chart.dart';
import 'components/transaction_form.dart';
import '../models/transaction.dart';
import 'components/transaction_list.dart';
import 'models/transaction.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp
    // ]);

    return MaterialApp(
      home: MyHomePage(), 
      theme: ThemeData(
        primaryColor: Colors.purple,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple).copyWith(secondary: Colors.amber),
        fontFamily: 'QuickSand', 
        textTheme: ThemeData.light().textTheme.copyWith(
          headline6: const TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 18,
              fontWeight: FontWeight.bold
          ),
          button: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          )
        ),
        appBarTheme: AppBarTheme(
          toolbarTextStyle: ThemeData.light().textTheme.copyWith(
            headline6: const TextStyle(
              fontFamily: 'OpenSans'
            )
          ).bodyText2, titleTextStyle: ThemeData.light().textTheme.copyWith(
            headline6: const TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold
            )
          ).headline6
        )
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final List<Transaction> _transactions = [];
  bool _showChart = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
  }

  @override
  void dispose() {
    super.dispose();

    WidgetsBinding.instance.removeObserver(this);
  }

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );
    
    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((element) => element.id == id);
    });
  }

  _openTransactionFromModal(BuildContext context) {
    showModalBottomSheet(
      context: context, 
      builder: (_) {
        return TransactionForm(_addTransaction);
      }
    );
  }

  Widget _getIconButton(IconData icon, Function() fn) {
    return Platform.isIOS ?
    GestureDetector(onTap: fn, child: Icon(icon)) :
    IconButton(icon: Icon(icon), onPressed: fn);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    final iconList = Platform.isIOS ? CupertinoIcons.refresh : Icons.list;
    final chartIcon = Platform.isIOS ? CupertinoIcons.refresh : Icons.show_chart;

    final actions = <Widget>[
      if(isLandscape)
        _getIconButton(_showChart ? iconList : chartIcon, () {
            setState(() {
              _showChart = !_showChart;
            });
          }),
      _getIconButton(Platform.isIOS ? CupertinoIcons.add : Icons.add, () => _openTransactionFromModal(context))
    ];

    final dynamic appBar = Platform.isIOS ? 
    CupertinoNavigationBar(
      middle: const Text('Despesas Pessoais'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: actions,
      ),
    )
    : AppBar(
      title: const Text(
        'Despesas Pessoais',
        // style: TextStyle(
        //   fontSize: 20 * mediaQuery.textScaleFactor,
        // )
      ),
      actions: actions
    );

    final availableHeight = mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top;

    final bodyPage = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // if(isLandscape) 
            //   Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       const Text('Exibir Gráfico'),
            //       Switch(
            //         value: _showChart, 
            //         onChanged: (value) {
            //           setState(() {
            //             _showChart = value;
            //           });
            //       }),
            //     ],
            //   ),
            if(_showChart || !isLandscape)
              SizedBox(
                height: availableHeight * (isLandscape ? 0.7 : 0.3),
                child: Chart(_recentTransactions)
              ),
            if(!_showChart || !isLandscape)
              SizedBox(
                height: availableHeight * (isLandscape ? 1.0 : 0.7),
                child: TransactionList(_transactions, _removeTransaction)
              ),
          ],
        ),
      )
    );

    return Platform.isIOS ? 
    CupertinoPageScaffold(
      navigationBar: appBar,
      child: bodyPage,
    )
     : Scaffold(
      appBar: appBar,
      body: bodyPage,
      floatingActionButton: Platform.isIOS ? Container() : FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () =>_openTransactionFromModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

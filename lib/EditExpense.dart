import 'package:expenses_log/Expense.dart';
import 'package:expenses_log/ExpensesModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class _EditExpenseState extends State<EditExpense> {
  double _price;
  String _name;
  DateTime _dateTime = DateTime.now();
  ExpensesModel _model;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int _index;

  _EditExpenseState(this._model, this._index);

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Expense")),
      body: Padding(
        padding: const EdgeInsets.only(top: 25.0, right: 32.0, bottom: 32.0, left: 32.0),
        child: Form( 
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              autovalidate: true,
              initialValue: _model.getObject(_index).price.toString(),
              decoration: new InputDecoration.collapsed(
                hintText: "0"
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (double.tryParse(value) != null) {
                  return null;
                } else {
                  return "Enter the valid price";
                }
              },
              onSaved: (value) {
                _price = double.parse(value);
              },
            ),
            TextFormField(
              initialValue: _model.getObject(_index).name,
              decoration: new InputDecoration.collapsed(
                hintText: "food"
              ),
              onSaved: (value) {
                _name = value;
              },
            ),
            Text(DateFormat('yyyy-MM-dd').format(_model.getObject(_index).date),
              style: TextStyle(
                height: 3.0,
                fontSize: 18
              ),
            ),
            Container(
              width: 200,
              height: 30,
              child: RaisedButton(
                child: Text("Choose another day"),
                onPressed: () {
                  showDatePicker(
                    context: context, 
                    initialDate: _model.getObject(_index).date, 
                    firstDate: DateTime(1990), 
                    lastDate: DateTime(3000)
                  ).then((date) {
                    setState(() {
                      _dateTime = date;
                    });
                  });
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Container(
                width: 100,
                height: 40,
                child: RaisedButton(
                  color: Colors.blue,
                  onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    _model.updateExpense(_index, _name, _price, _dateTime);
                    Navigator.pop(context);
                  }
                },
                  child: Center(child: Text("Save", style: TextStyle(
                    fontSize: 20, 
                    color: Colors.white
                    ),)
                  )
                ),
              )
            ),
          ],
        ),
        ),
      ),
    );
  }
}

class EditExpense extends StatefulWidget {
  final ExpensesModel _model;
  // final Expense _object;
  final int _index;

  EditExpense(this._model, this._index);

  @override 
  State<StatefulWidget> createState() => _EditExpenseState(_model, _index);
}
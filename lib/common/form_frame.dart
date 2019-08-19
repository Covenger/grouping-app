import 'package:flutter/material.dart';

class FormFrame extends StatelessWidget {
  static const _titleColor = Color(0xFF434343);

  final Widget content;
  final VoidCallback onSubmit;
  final List<Widget> confirmWidgets;
  final bool isFirstPage;

  const FormFrame({
    Key key,
    @required this.onSubmit,
    @required this.content,
    this.confirmWidgets = const <Widget>[
      const Text(
        'NEXT',
        style: TextStyle(fontSize: 16),
      ),
      const SizedBox(width: 5),
      const Icon(
        Icons.arrow_forward,
        color: Colors.white,
        size: 20,
      ),
    ],
    this.isFirstPage = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: _titleColor),
        textTheme: const TextTheme(
          title: const TextStyle(
            fontSize: 20,
            color: _titleColor,
            fontFamily: 'NotoSansCJKkr',
            fontWeight: FontWeight.normal,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        // brightness: Brightness.light,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context, rootNavigator: isFirstPage).pop(),
        ),
        centerTitle: true,
        title: const Text(
          'Create an account',
          textAlign: TextAlign.center,
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Expanded(child: content),
          FlatButton(
            onPressed: onSubmit,
            padding: const EdgeInsets.symmetric(vertical: 20),
            color: Theme.of(context).primaryColor,
            disabledColor: const Color(0xFFE1E1E1),
            disabledTextColor: Colors.white,
            textColor: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: confirmWidgets,
            ),
          ),
        ],
      ),
    );
  }
}

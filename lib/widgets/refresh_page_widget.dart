import 'package:flutter/material.dart';

refreshPageWidg(BuildContext context, Function f) {
  return Center(
    child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(30),
        ),
        padding: EdgeInsets.fromLTRB(20.0, 20.0, 15, 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Não foi possível accessar o servidor, tente novamente',
              style: TextStyle(
                fontSize: 19,
              ),
              textAlign: TextAlign.center,
            ),
            FlatButton(
              onPressed: () => f(),
              child: Text(
                'Recarregar',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
              color: Colors.green,
            )
          ],
        )),
  );
}

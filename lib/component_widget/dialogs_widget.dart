import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DialogWidget {
  waveLoadDialog(BuildContext context) {
    final spinkit = SpinKitWave(
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: index.isEven ? Colors.grey : Colors.black,
          ),
        );
      },
    );

    return spinkit;
  }

  loading(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (_) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  width: MediaQuery.of(context).size.width / 2,
                  height: 80,
                  padding: EdgeInsets.all(16),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: Colors.green,
                      ),
                      Text(
                        "Loading..",
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                ),
              ],
            ));
  }
}

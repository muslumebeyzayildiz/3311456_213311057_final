import "package:flutter/material.dart";
import "../main.dart";
import "../models/Konum_model.dart";
import "../services/db_utils.dart";

DbUtils utils = DbUtils();

class ListKonumlar extends StatefulWidget {
  @override
  _ListKonumlarState createState() => _ListKonumlarState();
}

class _ListKonumlarState extends State<ListKonumlar> {
  List<Konum> konumList = [];

  void getData() async {
    await utils.konumlar().then((result) => {
      setState(() {
        konumList = result;
      })
    });
    print(konumList);
  }

  void showAlert(String alertTitle, String alertContent) {
    AlertDialog alertDialog;
    alertDialog =
        AlertDialog(title: Text(alertTitle), content: Text(alertContent));
    showDialog(context: context, builder: (_) => alertDialog);
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(konumList.length.toString() + " Konumlar listelenmesi")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: konumList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(konumList[index].name),
                    onTap: () {
                      showAlert("Konum " + index.toString() + " clicked",
                          "Konum " + index.toString() + " clicked");
                    },
                    onLongPress: () async {
                      await utils.deleteKonum(konumList[index].id).then((value) => {
                        showAlert("Konum " + index.toString() + " deleted",
                            "Konum " + index.toString() + " deleted")
                      });
                      getData();
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {//},
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyApp()),
                    );
                  },
                  child: Text("Return Homepage")),
            ),
          ],
        ),
      ),
    );
  }
}
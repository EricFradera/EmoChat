import 'package:flutter/material.dart';

class ExpressionPage extends StatelessWidget {
  const ExpressionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ExpressiveSelector(),
    );
  }
}

class Item {
  Item({required this.headerName, this.isExpanded = false});
  String headerName;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (index) {
    return Item(headerName: "panel 1");
  });
}

class ExpressiveSelector extends StatefulWidget {
  const ExpressiveSelector({Key? key}) : super(key: key);

  @override
  State<ExpressiveSelector> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<ExpressiveSelector> {
  final List<Item> _data = generateItems(8);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: _buildPanel(),
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerName), //Feeling name
            );
          },
          body: ListTile(
            subtitle: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text("Choose your Font"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Chip(
                        label: Text('Type A'),
                        backgroundColor: Color.fromRGBO(230, 239, 218, 1),
                      ),
                      Chip(
                        label: Text('Type A'),
                        backgroundColor: Color.fromRGBO(230, 239, 218, 1),
                      ),
                      Chip(
                        label: Text('Type A'),
                        backgroundColor: Color.fromRGBO(230, 239, 218, 1),
                      ),
                      Chip(
                        label: Text('Type A'),
                        backgroundColor: Color.fromRGBO(230, 239, 218, 1),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text("Choose your emoji"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text("Choose your Color"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [],
                    ),
                  ),
                ],
              ),
            ),
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}

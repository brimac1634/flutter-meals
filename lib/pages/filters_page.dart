import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FiltersPage extends StatefulWidget {
  static const routeName = '/filters';

  @override
  _FiltersPageState createState() => _FiltersPageState();
}

class _FiltersPageState extends State<FiltersPage> {
  var _glutenFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;

  Widget _buildSwitchListTile(
      String title, String subtitle, bool value, Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      subtitle: Text(subtitle),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Filters'),
        ),
        drawer: MainDrawer(),
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'Adjust your meal selection.',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  _buildSwitchListTile('Gluten Free',
                      'Only include gluten free meals', _glutenFree, (value) {
                    setState(() {
                      _glutenFree = value;
                    });
                  }),
                  _buildSwitchListTile('Lactose Free',
                      'Only include lactose free meals', _lactoseFree, (value) {
                    setState(() {
                      _lactoseFree = value;
                    });
                  }),
                  _buildSwitchListTile('Vegetarian',
                      'Only include vegetarian meals', _vegetarian, (value) {
                    setState(() {
                      _vegetarian = value;
                    });
                  }),
                  _buildSwitchListTile(
                      'Vegan', 'Only include vegan meals', _vegan, (value) {
                    setState(() {
                      _vegan = value;
                    });
                  }),
                ],
              ),
            )
          ],
        ));
  }
}

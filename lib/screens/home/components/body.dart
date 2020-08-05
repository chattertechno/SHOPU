import 'package:backg/models/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../constant.dart';
import 'item_card.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
              child: Text(
                "Shop",
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          //  Categories(),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
                child: GridView.builder(
                  itemCount: state.products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
                    mainAxisSpacing: kDefaultPaddin,
                    crossAxisSpacing: kDefaultPaddin,
                    childAspectRatio:
                        orientation == Orientation.portrait ? 0.75 : 1.0,
                  ),
                  itemBuilder: (context, index) =>
                      ItemCard(product: state.products[index], press: () {}
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => ProductsPage(
                          //       product: products[index],
                          //     ),
                          //   ),
                          // ),
                          ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(0.1),
              child: Container(
                  width: double.infinity,
                  child: state.user != null
                      ? Text('')
                      : Row(
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            SizedBox(
                              height: 40,
                              width: 200,
                              child: FlatButton(
                                onPressed: () => Navigator.pushNamed(context, '/login'),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)),
                                color: Colors.orange,
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                        color: kTextColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            SizedBox(
                              height: 40,
                              width: 180,
                              child: FlatButton(
                                onPressed: () => Navigator.pushNamed(context, '/signup'),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                                color: Colors.blue,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text('Register', style: TextStyle(color: kTextColor),),
                                ),
                              ),
                            )
                          ],
                        )),
            ),
          ],
        );
      },
    );
  }
}

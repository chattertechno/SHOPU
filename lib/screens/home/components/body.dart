import 'package:backg/models/app_state.dart';
import 'package:backg/screens/home/components/categories.dart';
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
                "Cakes",
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Categories(),
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
              padding: const EdgeInsets.all(1.0),
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  width: double.infinity,
                  child: state.user != null
                      ? RaisedButton(
                          elevation: 8.0,
                          onPressed: () {
                            // showDialog(
                            //   context: context,
                            //   builder: (BuildContext context) {
                            //     return AlertDialog(
                            //       content: Stack(
                            //         overflow: Overflow.visible,
                            //         children: [
                            //           Positioned(
                            //             right: -40.0,
                            //             top: -40.0,
                            //             child: InkResponse(
                            //               onTap: () {
                            //                 Navigator.of(context).pop();
                            //               },
                            //               child: CircleAvatar(
                            //                 child: Icon(Icons.close),
                            //                 backgroundColor: Colors.red,
                            //               ),
                            //             ),
                            //           ),
                            //           Text('hey igly')
                            //         ],
                            //       ),
                            //     );
                            //   }
                            // );
                          },
                          padding: EdgeInsets.all(16.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0)),
                          color: Colors.black,
                          child: Text(
                            'Custom Order',
                            style: TextStyle(
                              color: Color(0xFF527DAA),
                              letterSpacing: 1.5,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
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

import 'dart:convert';

import 'package:backg/models/app_state.dart';
import 'package:backg/models/user.dart';
import 'package:backg/redux/actions.dart';
import 'package:backg/screens/home/components/item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:http/http.dart' as http;

class CartPage extends StatefulWidget {

  final void Function() onInit;
  CartPage({this.onInit});
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final _scaffoldkey = GlobalKey<ScaffoldState>();  

  void initState() {
    super.initState();
    widget.onInit();
    StripePayment.setOptions(StripeOptions(publishableKey: 'pk_test_S08JgsQMdhN4V0FTVE1mwnv6', merchantId: 'Test', androidPayMode: 'test'));
  }

  @override
  Widget build(BuildContext context) {
    Widget _cartTab() {
      final Orientation orientation = MediaQuery.of(context).orientation;
      return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (_, state) {
          return Column(
            children: [
              Expanded(
                child: SafeArea(
                  top: false,
                  bottom: false,
                  child: GridView.builder(
                    itemCount: state.cartProducts.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 4.0,
                      crossAxisSpacing: 4.0,
                      crossAxisCount:
                          orientation == Orientation.portrait ? 2 : 3,
                    ),
                    itemBuilder: (context, index) => ItemCard(
                      product: state.cartProducts[index],
                    ),
                  ),
                ),
              )
            ],
          );
        },
      );
    }

    Widget _cardsTab() {
      return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (_, state) {
           _addCard(renee) async {
             final User user =state.user;
             await http.put('https://sol.jephcakes.com/users/${user.id}', body: {
               "card_token": renee
             }, headers: {
               "Authorization": "Bearer ${user.jwt}"
             });
             http.Response response = await http.post('http://sol.jephcakes.com/card/add', body: {
               "source": renee, "customer": user.customerId
             });
             final responseData = json.decode(response.body);
             return responseData;

          }
          return Column(children: [
            Padding(padding: EdgeInsets.only(top: 10.0),),
            RaisedButton(
              color: Colors.blue,
              elevation: 8.0,
              child: Text('Add Card'),
              onPressed: () async {
                var renee = StripePayment.paymentRequestWithCardForm(CardFormPaymentRequest());
                var card = await _addCard(renee);
                StoreProvider.of<AppState>(context).dispatch(AddCardAction(card));
                StoreProvider.of<AppState>(context).dispatch(UpdateCardTokenAction(card['id']));

                final snackbar = SnackBar(
                  content: Text('card Added', style: TextStyle(color: Colors.green,),)
                );
                _scaffoldkey.currentState.showSnackBar(snackbar);
              },
            ),
            Expanded(
              child: ListView(
                children: state.cards.map<Widget>((c) => (ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.deepOrange,
                    child: Icon(
                      Icons.credit_card,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(''),
                  subtitle: Text(''),
                  trailing: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),

                    ),
                    child: Text('Set AS pRIMARY', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.pink),),
                    onPressed: () {},
                  ),
                )),).toList()
              ),
            )
          ],);
        },
      );
    }

    Widget _ordersTab() {
      return Text('orders');
    }

    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        key: _scaffoldkey,
        appBar: AppBar(
          title: Text('Cart'),
          bottom: TabBar(
            labelColor: Colors.yellow,
            unselectedLabelColor: Colors.black,
            tabs: [
              Tab(
                icon: SvgPicture.asset(
                  "assets/icons/cart.svg",
                  color: Colors.black,
                ),
              ),
              Tab(
                icon: Icon(Icons.credit_card),
              ),
              Tab(
                icon: Icon(Icons.receipt),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [_cartTab(), _cardsTab(), _ordersTab()],
        ),
      ),
    );
  }
}

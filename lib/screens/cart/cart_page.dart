import 'dart:convert';

import 'package:backg/models/app_state.dart';
import 'package:backg/models/order.dart';
import 'package:backg/models/user.dart';
import 'package:backg/redux/actions.dart';
import 'package:backg/screens/constant.dart';
import 'package:backg/screens/home/components/item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud/modal_progress_hud.dart';

class CartPage extends StatefulWidget {
  final void Function() onInit;
  CartPage({this.onInit});
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  bool _isSubmitting = false;

  void initState() {
    super.initState();
    widget.onInit();
    StripePayment.setOptions(StripeOptions(
        publishableKey: 'pk_test_S08JgsQMdhN4V0FTVE1mwnv6',
        merchantId: 'Test',
        androidPayMode: 'test'));
  }

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
                  padding: EdgeInsets.only(top: 10, left: 10),
                  itemCount: state.cartProducts.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
                    crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
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
        //  _addCard(cardToken) async {
        //    final User user =state.user;
        //    await http.put('https://sol.jephcakes.com/users/${user.id}', body: {
        //      "card_token": cardToken
        //    }, headers: {
        //      "Authorization": "Bearer ${user.jwt}"
        //    });
        //    http.Response response = await http.post('http://sol.jephcakes.com/card/add', body: {
        //      "source": cardToken, "customer": user.customerId
        //    });
        //    final responseData = json.decode(response.body);
        //    return responseData;

        // }
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10.0),
            ),
            RaisedButton(
              color: Colors.blue,
              elevation: 8.0,
              child: Text('Add Card'),
              onPressed: () async {
                // var cardToken = StripePayment.paymentRequestWithCardForm(CardFormPaymentRequest());
                // var card = await _addCard(cardToken);
                // StoreProvider.of<AppState>(context).dispatch(AddCardAction(card));
                // StoreProvider.of<AppState>(context).dispatch(UpdateCardTokenAction(card['id']));

                // final snackbar = SnackBar(
                //   content: Text('card Added', style: TextStyle(color: Colors.green,),)
                // );
                // _scaffoldkey.currentState.showSnackBar(snackbar);
              },
            ),
            Expanded(
              child: ListView(
                  children: state.cards
                      .map<Widget>(
                        (c) => (ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.deepOrange,
                            child: Icon(
                              Icons.credit_card,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                              '${c['exp_month']}/${c['exp_year']}, ${c['last4']}'),
                          subtitle: Text(
                            '${c['brand']}',
                            style: TextStyle(color: kTextColor),
                          ),
                          trailing: FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            child: Text(
                              'Set AS Primary',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.pink),
                            ),
                            onPressed: () {},
                          ),
                        )),
                      )
                      .toList()),
            )
          ],
        );
      },
    );
  }

  Widget _ordersTab(state) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) {
        return ListView(
            children: state.orders.length > 0
                ? state.orders
                    .map<Widget>((order) => (ListTile(
                          title: Text('\TSh ${order.amount}'),
                          subtitle: Text(order.createdAt),
                          leading: CircleAvatar(
                            backgroundColor: Colors.green,
                            child: Icon(Icons.attach_money),
                          ),
                        )))
                    .toList()
                : [
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.close,
                            size: 60.0,
                          ),
                          Text('No Orders Yet')
                        ],
                      ),
                    )
                  ]);
      },
    );
  }

  String calculateTotalPrice(cartProducts) {
    double totalprice = 0.0;
    cartProducts.forEach((cartProducts) {
      totalprice += cartProducts.price;
    });
    return totalprice.toStringAsFixed(2);
  }

Future _showSuccessDialog() {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        title: Text('Sucess'),
        children: [
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Text('Order Successfull'),
          )
        ],
      );
    }
  );
}
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (_, state) {
          return ModalProgressHUD(
            child: DefaultTabController(
              length: 3,
              initialIndex: 0,
              child: Scaffold(
                key: _scaffoldkey,
                floatingActionButton: state.cartProducts.length > 0
                    ? FloatingActionButton(
                        child: Icon(
                          Icons.local_atm,
                          color: Color(0xFFEEC60A),
                          size: 30.0,
                        ),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                String cartSummary = '';
                                state.cartProducts.forEach((cartProduct) {
                                  cartSummary +=
                                      '. ${cartProduct.name}, \Tsh ${cartProduct.price}\n';
                                });
                                return AlertDialog(
                                  title: Text('checkout'),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: [
                                        Text(
                                            'Cart Items (${state.cartProducts.length})'),
                                        Text('$cartSummary'),
                                        Text(
                                            'Order Total \Tsh ${calculateTotalPrice(state.cartProducts)}')
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    FlatButton(
                                      onPressed: () =>
                                          Navigator.pop(context, false),
                                      color: Colors.red,
                                      child: Text('Close'),
                                    ),
                                    RaisedButton(
                                      onPressed: () =>
                                          Navigator.pop(context, true),
                                      color: Colors.green,
                                      child: Text('checkout'),
                                    )
                                  ],
                                );
                              }).then((value) async {
                            _checkoutCartProducts() async {
                              // create new order in strapi
                              http.Response response = await http.post(
                                  'https://sol.jephcakes.com/orders',
                                  body: {
                                    "amount":
                                        calculateTotalPrice(state.cartProducts),
                                    "products": json.encode(state.cartProducts),
                                    "customer": state.user.customerId
                                  },
                                  headers: {
                                    'Authorization': 'Bearer ${state.user.jwt}'
                                  });
                              final responseData = json.decode(response.body);
                              return responseData;
                            }

                            if (value == true) {
                              // shwo loading spinner
                              setState(() => _isSubmitting = true);
                              // add data to strapi
                              final newOrderData =
                                  await _checkoutCartProducts();
                              // create order instance
                              Order newOrder = Order.fromJson(newOrderData);
                              // pass order instance to a new action
                              StoreProvider.of<AppState>(context)
                                  .dispatch(AddOrderAction(newOrder));
                              StoreProvider.of<AppState>(context)
                                  .dispatch(clearCartProductsAction);
                              setState(() => _isSubmitting = false);
                              _showSuccessDialog();
                            }
                          });
                        },
                      )
                    : Text(''),
                appBar: AppBar(
                  title: Text(
                      'Summary: ${state.cartProducts.length} Cakes . \Tsh ${calculateTotalPrice(state.cartProducts)}'),
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
                  children: [_cartTab(), _cardsTab(), _ordersTab(state)],
                ),
              ),
            ),
            inAsyncCall: _isSubmitting,
          );
        });
  }
}

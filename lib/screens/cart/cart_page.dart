import 'package:backg/models/app_state.dart';
import 'package:backg/screens/home/components/item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
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
    return Text('Cards');
  }

  Widget _ordersTab() {
    return Text('orders');
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Cart'),
          bottom: TabBar(
            labelColor: Colors.yellow,
            unselectedLabelColor: Colors.green,
            tabs: [
              Tab(
                icon: Icon(Icons.shopping_basket),
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

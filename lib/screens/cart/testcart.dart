// ListView(
//             children: state.orders.length > 0
//                 ? state.orders
//                     .map<Widget>((order) => (ListTile(
//                           title: Text('\TSh ${order.amount}'),
//                           subtitle: Text(order.createdAt),
//                           leading: CircleAvatar(
//                             backgroundColor: Colors.green,
//                             child: Icon(Icons.attach_money),
//                           ),
//                         )))
//                     .toList()
//                 : [
//                     Padding(
//                       padding: EdgeInsets.all(20.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.close,
//                             size: 60.0,
//                           ),
//                           Text('No Orders Yet')
//                         ],
//                       ),
//                     )
                    
//                   ]);
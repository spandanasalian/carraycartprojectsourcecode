class CheckoutModel {
  late String orderid, street, city, state, country, phone, totalPrice, date, deliverydate;

  CheckoutModel({
    required this.orderid,
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.phone,
    required this.totalPrice,
    required this.date,
    required this.deliverydate,

  });

  CheckoutModel.fromJson(Map<dynamic, dynamic> map) {
    orderid=map['orderid'];
    street = map['street'];
    city = map['city'];
    state = map['state'];
    country = map['country'];
    phone = map['phone'];
    totalPrice = map['totalPrice'];
    date = map['date'];
    deliverydate = map['deliverydate'];
  }

  toJson() {
    return {
      'orderid':orderid,
      'street': street,
      'city': city,
      'state': state,
      'country': country,
      'phone': phone,
      'totalPrice': totalPrice,
      'date': date,
      'deliverydate':deliverydate,
    };
  }
}

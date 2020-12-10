import 'dart:async';

import 'package:restaurant_finder_new/BLoC/bloc.dart';
import 'package:restaurant_finder_new/DataLayer/location.dart';
import 'package:restaurant_finder_new/DataLayer/restaurant.dart';
import 'package:restaurant_finder_new/DataLayer/zomato_client.dart';

class RestaurantBloc implements Bloc {
  final Location location;
  final _client = ZomatoClient();
  final _controller = StreamController<List<Restaurant>>();

  Stream<List<Restaurant>> get stream => _controller.stream;
  RestaurantBloc(this.location);

  void submitQuery(String query) async {
    final results = await _client.fetchRestaurants(location, query);
    _controller.sink.add(results);
  }

  @override
  void dispose() {
    _controller.close();
  }
}

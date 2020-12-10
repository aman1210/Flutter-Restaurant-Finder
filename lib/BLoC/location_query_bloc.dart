import 'dart:async';

import 'package:restaurant_finder_new/BLoC/bloc.dart';
import 'package:restaurant_finder_new/DataLayer/location.dart';
import 'package:restaurant_finder_new/DataLayer/zomato_client.dart';

class LocationQueryBloc implements Bloc {
  final _controller = StreamController<List<Location>>();
  final _client = ZomatoClient();
  Stream<List<Location>> get locationStream => _controller.stream;

  void submitQuery(String query) async {
    final results = await _client.fetchLocations(query);
    _controller.sink.add(results);
  }

  @override
  void dispose() {
    _controller.close();
    // TODO: implement dispose
  }
}

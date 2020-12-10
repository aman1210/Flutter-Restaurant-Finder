import 'package:flutter/material.dart';
import 'package:restaurant_finder_new/BLoC/bloc_provider.dart';
import 'package:restaurant_finder_new/BLoC/favourite_bloc.dart';
import 'package:restaurant_finder_new/DataLayer/restaurant.dart';
import 'package:restaurant_finder_new/UI/resturant_tile.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<FavoriteBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: StreamBuilder<List<Restaurant>>(
        stream: bloc.favoritesStream,
        // 1
        initialData: bloc.favorites,
        builder: (context, snapshot) {
          // 2
          List<Restaurant> favorites =
              (snapshot.connectionState == ConnectionState.waiting)
                  ? bloc.favorites
                  : snapshot.data;

          if (favorites == null || favorites.isEmpty) {
            return Center(child: Text('No Favorites'));
          }

          return ListView.separated(
            itemCount: favorites.length,
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) {
              final restaurant = favorites[index];
              return RestaurantTile(restaurant: restaurant);
            },
          );
        },
      ),
    );
  }
}

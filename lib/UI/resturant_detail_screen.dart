import 'package:flutter/material.dart';
import 'package:restaurant_finder_new/BLoC/bloc_provider.dart';
import 'package:restaurant_finder_new/BLoC/favourite_bloc.dart';
import 'package:restaurant_finder_new/DataLayer/restaurant.dart';
import 'package:restaurant_finder_new/UI/image_container.dart';

class RestaurantDetailsScreen extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantDetailsScreen({Key key, this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text(restaurant.name)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildBanner(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    restaurant.cuisines,
                    style: textTheme.subtitle2.copyWith(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    restaurant.address,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w100),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          _buildDetails(context),
          Center(child: _buildFavoriteButton(context))
        ],
      ),
    );
  }

  Widget _buildBanner() {
    return ImageContainer(
      height: 300,
      url: restaurant.imageUrl,
    );
  }

  Widget _buildDetails(BuildContext context) {
    final style = TextStyle(fontSize: 16);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Text(
              'Price: ${restaurant.priceDisplay}',
              style: style,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              'Rating: ${restaurant.rating.average}',
              style: style,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  // 1
  Widget _buildFavoriteButton(BuildContext context) {
    final bloc = BlocProvider.of<FavoriteBloc>(context);
    return StreamBuilder<List<Restaurant>>(
      stream: bloc.favoritesStream,
      initialData: bloc.favorites,
      builder: (context, snapshot) {
        List<Restaurant> favorites =
            (snapshot.connectionState == ConnectionState.waiting)
                ? bloc.favorites
                : snapshot.data;
        bool isFavorite = favorites.contains(restaurant);

        return FlatButton.icon(
          // 2
          onPressed: () => bloc.toggleRestaurant(restaurant),
          textColor: isFavorite ? Theme.of(context).accentColor : null,
          icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
          label: Text('Favorite'),
        );
      },
    );
  }
}

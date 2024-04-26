// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_place_app/core/constants/variables.dart';
import 'package:flutter_place_app/core/core.dart';
import 'package:flutter_place_app/data/model/response/get_places_response_model.dart';
import 'package:flutter_place_app/ui/bloc/delete_place/delete_place_bloc.dart';
import 'package:flutter_place_app/ui/pages/home_page.dart';
import 'package:flutter_place_app/ui/pages/place_edit_page.dart';

class PlaceDetailPage extends StatefulWidget {
  final Places places;
  const PlaceDetailPage({
    super.key,
    required this.places,
  });

  @override
  State<PlaceDetailPage> createState() => _PlaceDetailPageState();
}

class _PlaceDetailPageState extends State<PlaceDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Place'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
              onPressed: () {
                context.push(
                  PlaceEditPage(places: widget.places),
                );
              },
              icon: const Icon(Icons.edit))
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: NetworkImage(
                      "${Variables.imageBaseUrl}${widget.places.image}"),
                  fit: BoxFit.cover,
                )),
          ),
          const SpaceHeight(15),
          Text(
            widget.places.name!,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: AppColors.black,
            ),
          ),
          const SpaceHeight(15),
          Text(
            widget.places.address!,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: AppColors.black,
            ),
          ),
          const SpaceHeight(15),
          Text(
            widget.places.coordinates!,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: AppColors.black,
            ),
          ),
          const SpaceHeight(15),
          Text(
            widget.places.description ?? '',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: AppColors.black,
            ),
          ),
        ],
      ),
      floatingActionButton: BlocConsumer<DeletePlaceBloc, DeletePlaceState>(
        listener: (context, state) {
          state.maybeWhen(
            orElse: () {},
            error: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor: AppColors.red,
                ),
              );
            },
            loaded: (responseModel) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            },
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return FloatingActionButton(
                onPressed: () {
                  context
                      .read<DeletePlaceBloc>()
                      .add(DeletePlaceEvent.delete(widget.places.id!));
                },
                child: const Icon(Icons.delete),
              );
            },
            loading: () => const Align(
              alignment: Alignment.bottomRight,
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}

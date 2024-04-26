import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_place_app/ui/bloc/get_all_places/get_all_places_bloc.dart';
import 'package:flutter_place_app/ui/bloc/logout/logout_bloc.dart';
import 'package:flutter_place_app/ui/pages/crete_places_page.dart';
import 'package:flutter_place_app/ui/pages/place_detail_page.dart';
import 'package:flutter_place_app/ui/widgets/place_card_widget.dart';

import '../../core/core.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<GetAllPlacesBloc>().add(const GetAllPlacesEvent.fetch());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () {
              context.push(const PlaceCreatePage());
            },
            icon: const Icon(
              Icons.add_circle,
              color: AppColors.white,
            ),
          )
        ],
      ),
      body: BlocBuilder<GetAllPlacesBloc, GetAllPlacesState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return const SizedBox();
            },
            error: (message) {
              return Center(
                child: Text(message),
              );
            },
            loaded: (places) {
              return SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: places.length,
                  itemBuilder: (context, index) {
                    final data = places[index];
                    return PlaceCardWidget(
                      title: data.name ?? '',
                      address: data.address ?? '',
                      coordinate: data.coordinates ?? '',
                      onTap: () {
                        context.push(
                          PlaceDetailPage(
                            places: data,
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            },
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
      floatingActionButton: BlocConsumer<LogoutBloc, LogoutState>(
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
              context.pushReplacement(const LoginPage());
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(responseModel.message!),
                  backgroundColor: AppColors.primary,
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
                  context.read<LogoutBloc>().add(const LogoutEvent.logout());
                },
                child: const Icon(Icons.logout),
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

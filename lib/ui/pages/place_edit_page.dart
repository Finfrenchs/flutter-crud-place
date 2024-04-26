// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_place_app/data/model/request/update_places_request_model.dart';

import 'package:flutter_place_app/data/model/response/get_places_response_model.dart';
import 'package:flutter_place_app/ui/bloc/update_places/update_places_bloc.dart';
import 'package:flutter_place_app/ui/pages/home_page.dart';

import '../../core/core.dart';

class PlaceEditPage extends StatefulWidget {
  final Places places;
  const PlaceEditPage({
    super.key,
    required this.places,
  });

  @override
  State<PlaceEditPage> createState() => _PlaceEditPageState();
}

class _PlaceEditPageState extends State<PlaceEditPage> {
  late final TextEditingController nameController = TextEditingController();
  late final TextEditingController addressController = TextEditingController();
  late final TextEditingController coordinateController =
      TextEditingController();
  late final TextEditingController descriptionController =
      TextEditingController();

  @override
  void initState() {
    nameController.text = widget.places.name ?? '';
    addressController.text = widget.places.address ?? '';
    coordinateController.text = widget.places.coordinates ?? '';
    descriptionController.text = widget.places.description ?? '';
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    coordinateController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Place'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(
                controller: nameController,
                label: 'Name',
              ),
              const SpaceHeight(20),
              CustomTextField(
                controller: addressController,
                label: 'Address',
              ),
              const SpaceHeight(20),
              CustomTextField(
                controller: coordinateController,
                label: 'Coordinate',
              ),
              const SpaceHeight(20),
              CustomTextField(
                controller: descriptionController,
                label: 'Description',
              ),
              const SpaceHeight(50),
              BlocConsumer<UpdatePlacesBloc, UpdatePlacesState>(
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
                      context.push(const HomePage());
                    },
                  );
                },
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return Button.filled(
                        onPressed: () {
                          final requestModel = UpdatePlacesRequestModel(
                            name: nameController.text,
                            address: addressController.text,
                            coordinates: coordinateController.text,
                            description: descriptionController.text,
                          );
                          context.read<UpdatePlacesBloc>().add(
                                UpdatePlacesEvent.update(
                                    requestModel, widget.places.id!),
                              );
                        },
                        label: 'Save',
                      );
                    },
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

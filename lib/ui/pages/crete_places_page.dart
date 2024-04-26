// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_place_app/data/model/response/get_places_response_model.dart';
import 'package:flutter_place_app/ui/bloc/create_place/create_place_bloc.dart';
import 'package:flutter_place_app/ui/pages/home_page.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/core.dart';
import '../widgets/image_picker_widget.dart';

class PlaceCreatePage extends StatefulWidget {
  const PlaceCreatePage({
    super.key,
  });

  @override
  State<PlaceCreatePage> createState() => _PlaceCreatePageState();
}

class _PlaceCreatePageState extends State<PlaceCreatePage> {
  late final TextEditingController nameController;
  late final TextEditingController addressController;
  late final TextEditingController coordinateController;
  late final TextEditingController descriptionController;

  XFile? imageFile;

  @override
  void initState() {
    nameController = TextEditingController();
    addressController = TextEditingController();
    coordinateController = TextEditingController();
    descriptionController = TextEditingController();
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
              const SpaceHeight(20),
              ImagePickerWidget(
                label: 'Foto Place',
                onChanged: (file) {
                  if (file == null) {
                    return;
                  }
                  imageFile = file;
                },
              ),
              const SpaceHeight(50),
              BlocConsumer<CreatePlaceBloc, CreatePlaceState>(
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
                          final requestModel = Places(
                            name: nameController.text,
                            address: addressController.text,
                            coordinates: coordinateController.text,
                            description: descriptionController.text,
                            image: imageFile!.path,
                          );
                          context.read<CreatePlaceBloc>().add(
                              CreatePlaceEvent.create(
                                  requestModel, imageFile!));
                        },
                        label: 'Save Place',
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

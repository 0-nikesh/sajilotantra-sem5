import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/di/di.dart';
import '../../domain/use_case/get_all_guidance_usecase.dart';
import '../../domain/use_case/get_guidance_by_id_usecase.dart';
import '../view_model/guidance_bloc.dart';
import '../view_model/guidance_event.dart';
import '../view_model/guidance_state.dart';
import 'guidance_detail_view.dart';

class GuidanceListScreen extends StatelessWidget {
  const GuidanceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => GuidanceBloc(
          getAllGuidancesUseCase: getIt<GetAllGuidancesUseCase>(),
          getGuidanceByIdUseCase: getIt<GetGuidanceByIdUseCase>(),
        )..add(LoadAllGuidancesEvent()),
        child: BlocBuilder<GuidanceBloc, GuidanceState>(
          builder: (context, state) {
            if (state is GuidanceLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GuidanceLoadedState) {
              return ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: state.guidances.length,
                itemBuilder: (context, index) {
                  final guidance = state.guidances[index];
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: Image.network(
                        guidance.thumbnail ?? '',
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.image_not_supported);
                        },
                      ),
                      title: Text(guidance.title),
                      subtitle: Text(guidance.category),
                      onTap: () {
                        print("Guidance ID: ${guidance.id}");
                        if (guidance.id != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GuidanceDetailScreen(
                                  guidanceId: guidance.id!),
                            ),
                          );
                        } else {
                          print("Guidance ID is null!");
                        }
                      },
                    ),
                  );
                },
              );
            } else if (state is GuidanceErrorState) {
              return Center(child: Text(state.message));
            }
            return const Center(child: Text("No Data Available"));
          },
        ),
      ),
    );
  }
}

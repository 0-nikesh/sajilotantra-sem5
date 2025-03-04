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
    final isTablet = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: BlocProvider(
        create: (context) => GuidanceBloc(
          getAllGuidancesUseCase: getIt<GetAllGuidancesUseCase>(),
          getGuidanceByIdUseCase: getIt<GetGuidanceByIdUseCase>(),
        )..add(LoadAllGuidancesEvent()),
        child: BlocBuilder<GuidanceBloc, GuidanceState>(
          builder: (context, state) {
            if (state is GuidanceLoadedState) {
              if (state.guidances.isEmpty) {
                return Center(
                  child: Text(
                    "No Guidance Available",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                );
              }

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: isTablet
                    ? GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 3,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemCount: state.guidances.length,
                        itemBuilder: (context, index) {
                          return _buildGuidanceCard(
                              context, state.guidances[index], isTablet);
                        },
                      )
                    : ListView.builder(
                        itemCount: state.guidances.length,
                        itemBuilder: (context, index) {
                          return _buildGuidanceCard(
                              context, state.guidances[index], isTablet);
                        },
                      ),
              );
            } else if (state is GuidanceErrorState) {
              return Center(
                child: Text(
                  state.message,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.redAccent,
                      ),
                ),
              );
            }
            return Center(
              child: Text(
                "Waiting for Guidance...",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildGuidanceCard(
      BuildContext context, dynamic guidance, bool isTablet) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Theme.of(context).cardColor,
      child: InkWell(
        onTap: () {
          if (guidance.id != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    GuidanceDetailScreen(guidanceId: guidance.id!),
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  guidance.thumbnail ?? '',
                  width: isTablet ? 100 : 70,
                  height: isTablet ? 100 : 70,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: isTablet ? 100 : 70,
                      height: isTablet ? 100 : 70,
                      color: Colors.grey[300],
                      child: const Icon(Icons.image_not_supported, size: 40),
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      guidance.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      guidance.category,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

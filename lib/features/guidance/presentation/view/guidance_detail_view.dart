import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../../app/di/di.dart';
import '../../domain/use_case/get_all_guidance_usecase.dart';
import '../../domain/use_case/get_guidance_by_id_usecase.dart';
import '../view_model/guidance_bloc.dart';
import '../view_model/guidance_event.dart';
import '../view_model/guidance_state.dart';

class GuidanceDetailScreen extends StatelessWidget {
  final String guidanceId;

  const GuidanceDetailScreen({super.key, required this.guidanceId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text(
          "Guidance Details",
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: BlocProvider(
        create: (context) => GuidanceBloc(
          getAllGuidancesUseCase: getIt<GetAllGuidancesUseCase>(),
          getGuidanceByIdUseCase: getIt<GetGuidanceByIdUseCase>(),
        )..add(LoadGuidanceDetailsEvent(guidanceId: guidanceId)),
        child: BlocBuilder<GuidanceBloc, GuidanceState>(
          builder: (context, state) {
            if (state is GuidanceDetailsLoadedState) {
              final guidance = state.guidance;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      guidance.thumbnail,
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 250,
                          color: Colors.grey[300],
                          child: const Center(
                            child: Icon(Icons.image_not_supported, size: 60),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            guidance.title,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Category: ${guidance.category}",
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Colors.grey[600],
                                    ),
                          ),
                          const SizedBox(height: 20),
                          _buildAccordion(
                            context,
                            title: "Documents Required",
                            content: guidance.documentsRequired?.join("\n") ??
                                "No documents specified.",
                          ),
                          _buildAccordion(
                            context,
                            title: "Steps to Follow",
                            content: guidance.description,
                            isHtml: true,
                          ),
                          _buildAccordion(
                            context,
                            title: "Cost Required",
                            content: guidance.costRequired ??
                                "No cost information available.",
                          ),
                        ],
                      ),
                    ),
                  ],
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
                "Waiting for Details...",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildAccordion(BuildContext context,
      {required String title, required String content, bool isHtml = false}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Theme.of(context).cardColor,
      child: ExpansionTile(
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: isHtml
                ? Html(data: content)
                : Text(
                    content,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
          ),
        ],
      ),
    );
  }
}

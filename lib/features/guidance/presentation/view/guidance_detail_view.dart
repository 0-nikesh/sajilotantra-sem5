import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart'; // Import flutter_html

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
      appBar: AppBar(title: const Text("Guidance Details")),
      body: BlocProvider(
        create: (context) => GuidanceBloc(
          getAllGuidancesUseCase: getIt<GetAllGuidancesUseCase>(),
          getGuidanceByIdUseCase: getIt<GetGuidanceByIdUseCase>(),
        )..add(LoadGuidanceDetailsEvent(guidanceId: guidanceId)),
        child: BlocBuilder<GuidanceBloc, GuidanceState>(
          builder: (context, state) {
            if (state is GuidanceLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GuidanceDetailsLoadedState) {
              final guidance = state.guidance;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Full-width image with fixed height
                    Image.network(
                      guidance.thumbnail,
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            guidance.title,
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text("Category: ${guidance.category}"),
                          const SizedBox(height: 16),
                          _buildAccordion(
                            title: "Documents Required",
                            content: guidance.documentsRequired?.join("\n") ??
                                "No documents specified.",
                          ),
                          _buildAccordion(
                            title: "Steps to Follow",
                            content:
                                guidance.description, // Render HTML content
                            isHtml: true,
                          ),
                          _buildAccordion(
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
              return Center(child: Text(state.message));
            }
            return const Center(child: Text("No Details Available"));
          },
        ),
      ),
    );
  }

  Widget _buildAccordion(
      {required String title, required String content, bool isHtml = false}) {
    return ExpansionTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: isHtml
              ? Html(data: content) // Render HTML content
              : Text(content, style: const TextStyle(fontSize: 16)),
        ),
      ],
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../../app/di/di.dart';
// import '../../domain/use_case/get_all_guidance_usecase.dart';
// import '../../domain/use_case/get_guidance_by_id_usecase.dart';
// import '../view_model/guidance_bloc.dart';
// import '../view_model/guidance_event.dart';
// import '../view_model/guidance_state.dart';
// import 'guidance_detail_view.dart';

// class GuidanceListScreen extends StatelessWidget {
//   const GuidanceListScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocProvider(
//         create: (context) => GuidanceBloc(
//           getAllGuidancesUseCase: getIt<GetAllGuidancesUseCase>(),
//           getGuidanceByIdUseCase: getIt<GetGuidanceByIdUseCase>(),
//         )..add(LoadAllGuidancesEvent()),
//         child: BlocBuilder<GuidanceBloc, GuidanceState>(
//           builder: (context, state) {
//             if (state is GuidanceLoadingState) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is GuidanceLoadedState) {
//               return ListView.builder(
//                 padding: const EdgeInsets.all(8.0),
//                 itemCount: state.guidances.length,
//                 itemBuilder: (context, index) {
//                   final guidance = state.guidances[index];
//                   return Card(
//                     elevation: 2,
//                     margin: const EdgeInsets.symmetric(vertical: 6),
//                     child: ListTile(
//                       leading: Image.network(
//                         guidance.thumbnail ?? '',
//                         width: 60,
//                         height: 60,
//                         fit: BoxFit.cover,
//                         errorBuilder: (context, error, stackTrace) {
//                           return const Icon(Icons.image_not_supported);
//                         },
//                       ),
//                       title: Text(guidance.title),
//                       subtitle: Text(guidance.category),
//                       onTap: () {
//                         print("Guidance ID: ${guidance.id}");
//                         if (guidance.id != null) {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => GuidanceDetailScreen(
//                                   guidanceId: guidance.id!),
//                             ),
//                           );
//                         } else {
//                           print("Guidance ID is null!");
//                         }
//                       },
//                     ),
//                   );
//                 },
//               );
//             } else if (state is GuidanceErrorState) {
//               return Center(child: Text(state.message));
//             }
//             return const Center(child: Text("No Data Available"));
//           },
//         ),
//       ),
//     );
//   }
// }

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
    final isTablet =
        MediaQuery.of(context).size.width > 600; // 📱➡️📟 Check for tablet mode

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
              if (state.guidances.isEmpty) {
                return const Center(child: Text("No Data Available"));
              }

              return Padding(
                padding: const EdgeInsets.all(
                    12.0), // More padding for larger screens
                child: isTablet
                    ? GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // 📟 Two columns for tablets
                          childAspectRatio: 3, // Adjust item size
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
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
              return Center(child: Text(state.message));
            }
            return const Center(child: Text("No Data Available"));
          },
        ),
      ),
    );
  }

  /// 📌 A reusable method to create a guidance card
  Widget _buildGuidanceCard(
      BuildContext context, dynamic guidance, bool isTablet) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  guidance.thumbnail ?? '',
                  width: isTablet ? 100 : 60, // Bigger images for tablets
                  height: isTablet ? 100 : 60,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.image_not_supported, size: 40);
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      guidance.title,
                      style: TextStyle(
                          fontSize: isTablet ? 20 : 16,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      guidance.category,
                      style: TextStyle(
                          fontSize: isTablet ? 16 : 14, color: Colors.grey),
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

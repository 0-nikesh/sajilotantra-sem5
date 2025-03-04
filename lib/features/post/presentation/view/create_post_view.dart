import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sajilotantra/app/di/di.dart';
import 'package:sajilotantra/features/post/domain/entity/post_entity.dart';
import 'package:sajilotantra/features/post/presentation/view_model/post_bloc.dart';
import 'package:sajilotantra/features/post/presentation/view_model/post_event.dart';
import 'package:sajilotantra/features/post/presentation/view_model/post_state.dart';

class CreatePostView extends StatefulWidget {
  const CreatePostView({super.key});

  @override
  State<CreatePostView> createState() => _CreatePostViewState();
}

class _CreatePostViewState extends State<CreatePostView> {
  final _captionController = TextEditingController();
  final _categoryController = TextEditingController();
  final List<XFile> _selectedImages = []; // Store selected images
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _captionController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  Future<void> _pickImages() async {
    if (_selectedImages.length >= 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Maximum 5 images allowed')),
      );
      return;
    }

    final pickedFiles = await _picker.pickMultiImage();
    setState(() {
      _selectedImages.addAll(
        pickedFiles.take(5 - _selectedImages.length), // Limit to 5 total
      );
    });
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  void _submitPost(BuildContext context) {
    if (_captionController.text.trim().isEmpty ||
        _categoryController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Caption and category are required')),
      );
      return;
    }

    final post = PostEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(), // Temporary ID
      userId: 'current_user_id', // Replace with actual user ID from auth
      caption: _captionController.text.trim(),
      category: _categoryController.text.trim(),
      images: _selectedImages.map((xFile) => xFile.path).toList(),
      createdAt: DateTime.now(),
      likeCount: 0,
      comments: const [],
    );
    context.read<PostBloc>().add(CreatePostEvent(post: post));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<PostBloc>(),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
          elevation: Theme.of(context).appBarTheme.elevation,
          title: Text(
            'Create Post',
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
          actions: [
            BlocBuilder<PostBloc, PostState>(
              builder: (context, state) {
                return TextButton(
                  onPressed:
                      state is PostLoading ? null : () => _submitPost(context),
                  child: Text(
                    'Post',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                );
              },
            ),
          ],
        ),
        body: BlocListener<PostBloc, PostState>(
          listener: (context, state) {
            if (state is PostError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error: ${state.message}'),
                  backgroundColor: Theme.of(context).colorScheme.error,
                ),
              );
            } else if (state is PostCreated) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Post created successfully'),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              );
              Navigator.pop(context);
            }
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Caption Input
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: Theme.of(context).cardColor,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextField(
                      controller: _captionController,
                      decoration: InputDecoration(
                        hintText: 'Write a caption...',
                        hintStyle:
                            Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.color
                                      ?.withOpacity(0.6),
                                ),
                        border: InputBorder.none,
                      ),
                      maxLines: 5,
                      textInputAction: TextInputAction.next,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Category Input
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: Theme.of(context).cardColor,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextField(
                      controller: _categoryController,
                      decoration: InputDecoration(
                        hintText: 'Category',
                        hintStyle:
                            Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.color
                                      ?.withOpacity(0.6),
                                ),
                        border: InputBorder.none,
                      ),
                      textInputAction: TextInputAction.done,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Image Picker Button
                ElevatedButton.icon(
                  onPressed: _pickImages,
                  icon: Icon(Icons.image,
                      color: Theme.of(context).iconTheme.color),
                  label: Text(
                    'Add Images (Max 5)',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).iconTheme.color,
                        ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).primaryColor.withOpacity(0.1),
                    foregroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                  ),
                ),
                const SizedBox(height: 16),

                // Selected Images Preview
                if (_selectedImages.isNotEmpty)
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _selectedImages.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    File(_selectedImages[index].path),
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: 100,
                                        height: 100,
                                        color: Colors.grey[300],
                                        child: const Icon(Icons.error,
                                            color: Colors.red),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Positioned(
                                top: -10,
                                right: -10,
                                child: IconButton(
                                  icon: Icon(Icons.remove_circle,
                                      color:
                                          Theme.of(context).colorScheme.error),
                                  onPressed: () => _removeImage(index),
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  iconSize: 24,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                const SizedBox(height: 24),

                // Loading Indicator
                BlocBuilder<PostBloc, PostState>(
                  builder: (context, state) {
                    if (state is PostLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

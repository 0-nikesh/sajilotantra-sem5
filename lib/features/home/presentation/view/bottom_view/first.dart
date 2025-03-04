import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';
import 'package:sajilotantra/features/post/presentation/view_model/post_event.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../../app/di/di.dart';
import '../../../../post/domain/entity/post_entity.dart';
import '../../../../post/presentation/view/create_post_view.dart';
import '../../../../post/presentation/view_model/post_bloc.dart';
import '../../../../post/presentation/view_model/post_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => getIt<PostBloc>()..add(FetchPostsEvent()),
        child: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            if (state is PostLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PostLoaded) {
              if (state.posts.isEmpty) {
                return _buildEmptyState();
              }
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<PostBloc>().add(FetchPostsEvent());
                },
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.posts.length,
                  itemBuilder: (context, index) {
                    final post = state.posts[index];
                    return _buildPostCard(context, post, index);
                  },
                ),
              );
            } else if (state is PostError) {
              return _buildErrorState(state.message, context);
            }
            return _buildEmptyState();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to create post screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreatePostView()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildPostCard(BuildContext context, PostEntity post, int index) {
    return Hero(
      tag: 'post_${post.id}',
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: InkWell(
          onTap: () {
            // Navigate to post detail
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Viewing details for post ${post.id}')),
            );
          },
          borderRadius: BorderRadius.circular(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User info header
              ListTile(
                contentPadding:
                    const EdgeInsets.only(left: 16, right: 16, top: 8),
                leading: CircleAvatar(
                  backgroundImage:
                      post.userImage != null && post.userImage!.isNotEmpty
                          ? CachedNetworkImageProvider(post.userImage!)
                          : null, // Use user image if available
                  backgroundColor: Colors.grey.shade200, // Fallback color
                  child: post.userImage == null || post.userImage!.isEmpty
                      ? const Icon(Icons.person, size: 20, color: Colors.grey)
                      : null, // Fallback icon if no image
                ),
                title: Text(
                  post.username ??
                      'Unknown User', // Use username (fname + lname) or fallback
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  timeago.format(post.createdAt),
                  style: const TextStyle(fontSize: 12),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {
                    _showPostOptions(context);
                  },
                ),
              ),

              // Post content
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category chip
                    if (post.category.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Chip(
                          label: Text(post.category),
                          backgroundColor: Colors.blue.shade50,
                          labelStyle: TextStyle(
                            color: Colors.blue.shade800,
                            fontSize: 12,
                          ),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          padding: const EdgeInsets.all(0),
                          visualDensity: VisualDensity.compact,
                        ),
                      ),

                    // Caption
                    if (post.caption.isNotEmpty)
                      Text(
                        post.caption,
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.4,
                        ),
                      ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),

              // Post Images
              if (post.images.isNotEmpty)
                SizedBox(
                  height: 250,
                  child: PageView.builder(
                    itemCount: post.images.length,
                    controller: PageController(viewportFraction: 0.9),
                    itemBuilder: (context, imgIndex) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: GestureDetector(
                            onTap: () {
                              _showFullScreenImage(
                                  context, post.images, imgIndex);
                            },
                            child: CachedNetworkImage(
                              imageUrl: post.images[imgIndex],
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) => Container(
                                color: Colors.grey.shade200,
                                child: const Icon(
                                  Icons.image_not_supported,
                                  size: 50,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

              // Interaction bar
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    LikeButton(
                      size: 28,
                      likeCount: post.likeCount,
                      countBuilder: (count, isLiked, text) {
                        return Text(
                          count.toString(),
                          style: TextStyle(
                            color: isLiked ? Colors.red : Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 16),
                    GestureDetector(
                      onTap: () {
                        _showCommentSheet(context, post);
                      },
                      child: Row(
                        children: [
                          Icon(Icons.chat_bubble_outline,
                              color: Colors.grey.shade700, size: 22),
                          const SizedBox(width: 6),
                          Text(
                            post.comments.length.toString(),
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.bookmark_border,
                        color: Colors.grey.shade700, size: 22),
                    const SizedBox(width: 16),
                    Icon(Icons.share_outlined,
                        color: Colors.grey.shade700, size: 22),
                  ],
                ),
              ),

              // Comments preview
              if (post.comments.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Show only first comment if there are many
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '${post.comments[0].user} ',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            TextSpan(
                              text: post.comments[0].text,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      if (post.comments.length > 1)
                        TextButton(
                          onPressed: () {
                            _showCommentSheet(context, post);
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            alignment: Alignment.centerLeft,
                          ),
                          child: Text(
                            'View all ${post.comments.length} comments',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

              // Comment input
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.grey.shade200,
                      child: const Icon(Icons.person,
                          size: 20, color: Colors.grey),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Add a comment...',
                          hintStyle: TextStyle(color: Colors.grey.shade400),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 8),
                        ),
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Comment feature coming soon')),
                        );
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(50, 30),
                      ),
                      child: const Text('Post',
                          style: TextStyle(fontWeight: FontWeight.bold)),
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

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.post_add, size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text(
            'No posts yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Be the first to share something',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message, BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 60, color: Colors.red.shade300),
          const SizedBox(height: 16),
          Text(
            'Something went wrong',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              context.read<PostBloc>().add(FetchPostsEvent());
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Try Again'),
          ),
        ],
      ),
    );
  }

  void _showPostOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.bookmark_outline),
                title: const Text('Save post'),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Post saved')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.share),
                title: const Text('Share post'),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Share feature coming soon')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.report_outlined),
                title: const Text('Report post'),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Report feature coming soon')),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showFullScreenImage(
      BuildContext context, List<String> images, int initialIndex) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: PageView.builder(
            itemCount: images.length,
            controller: PageController(initialPage: initialIndex),
            itemBuilder: (context, index) {
              return InteractiveViewer(
                minScale: 0.5,
                maxScale: 3.0,
                child: Center(
                  child: CachedNetworkImage(
                    imageUrl: images[index],
                    fit: BoxFit.contain,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.error,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _showCommentSheet(BuildContext context, PostEntity post) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          maxChildSize: 0.9,
          minChildSize: 0.5,
          expand: false,
          builder: (context, scrollController) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      const Text(
                        'Comments',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Expanded(
                  child: post.comments.isEmpty
                      ? Center(
                          child: Text(
                            'No comments yet',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        )
                      : ListView.builder(
                          controller: scrollController,
                          itemCount: post.comments.length,
                          itemBuilder: (context, index) {
                            final comment = post.comments[index];
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors
                                    .primaries[index % Colors.primaries.length],
                                child: Text(
                                    comment.user.substring(0, 1).toUpperCase()),
                              ),
                              title: Text(
                                comment.user,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(comment.text),
                              trailing: Text(
                                '${index + 1}m',
                                style: TextStyle(
                                    color: Colors.grey.shade500, fontSize: 12),
                              ),
                            );
                          },
                        ),
                ),
                const Divider(height: 1),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.grey.shade200,
                        child: const Icon(Icons.person,
                            size: 24, color: Colors.grey),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Add a comment...',
                            hintStyle: TextStyle(color: Colors.grey.shade400),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.send, color: Colors.blue),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Comment feature coming soon')),
                          );
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

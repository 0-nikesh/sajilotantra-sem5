import 'package:bloc/bloc.dart';

import '../../domain/use_case/add_comment_usecase.dart';
import '../../domain/use_case/crearte_posts_usecase.dart';
import '../../domain/use_case/fetch_posts_usecase.dart';
import '../../domain/use_case/get_post_by_id.dart';
import '../../domain/use_case/like_posts_usecase.dart';
import 'post_event.dart';
import 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final FetchPostsUseCase fetchPostsUseCase;
  final LikePostUseCase likePostUseCase;
  final AddCommentUseCase addCommentUseCase;
  final CreatePostUseCase createPostUseCase;
  final GetPostByIdUseCase getPostByIdUseCase;

  PostBloc({
    required this.fetchPostsUseCase,
    required this.likePostUseCase,
    required this.addCommentUseCase,
    required this.createPostUseCase,
    required this.getPostByIdUseCase,
  }) : super(PostInitial()) {
    on<FetchPostsEvent>(_onFetchPosts);
    on<LikePostEvent>(_onLikePost);
    on<AddCommentEvent>(_onAddComment);
    on<CreatePostEvent>(_onCreatePost);
    // Uncomment if needed
    // on<GetPostByIdEvent>(_onGetPostById);
  }

  Future<void> _onFetchPosts(
      FetchPostsEvent event, Emitter<PostState> emit) async {
    emit(PostLoading());
    final result = await fetchPostsUseCase();
    result.fold(
      (failure) => emit(PostError(message: failure.message)),
      (posts) => emit(PostLoaded(posts: posts)),
    );
  }

  Future<void> _onLikePost(LikePostEvent event, Emitter<PostState> emit) async {
    emit(PostLoading()); // Start loading
    final result = await likePostUseCase(event.postId);
    result.fold(
      (failure) => emit(PostError(message: failure.message)),
      (_) {
        emit(PostLiked());
        add(FetchPostsEvent()); // Refresh posts
      },
    );
  }

  Future<void> _onAddComment(
      AddCommentEvent event, Emitter<PostState> emit) async {
    emit(PostLoading()); // Start loading
    final result = await addCommentUseCase(event.postId, event.commentText);
    result.fold(
      (failure) => emit(PostError(message: failure.message)),
      (_) {
        emit(CommentAdded());
        add(FetchPostsEvent()); // Refresh posts
      },
    );
  }

  Future<void> _onCreatePost(
      CreatePostEvent event, Emitter<PostState> emit) async {
    emit(PostLoading()); // Start loading
    final result = await createPostUseCase(event.post);
    result.fold(
      (failure) => emit(PostError(message: failure.message)),
      (_) async {
        emit(PostCreated()); // Emit success state first
        // Fetch updated posts and emit new state
        final fetchResult = await fetchPostsUseCase();
        fetchResult.fold(
          (failure) => emit(PostError(message: failure.message)),
          (posts) => emit(PostLoaded(posts: posts)),
        );
      },
    );
  }

  // Uncomment and use if needed
  // Future<void> _onGetPostById(
  //     GetPostByIdEvent event, Emitter<PostState> emit) async {
  //   emit(PostLoading());
  //   final result = await getPostByIdUseCase(event.postId);
  //   result.fold(
  //     (failure) => emit(PostError(message: failure.message)),
  //     (post) => emit(PostByIdLoaded(post: post!)),
  //   );
  // }
}

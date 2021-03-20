// import 'package:rxdart/rxdart.dart';
// import 'package:chat_gh/models/myposts_model.dart';
// import 'package:chat_gh/services/api_services.dart';

// class Repository {
//   Future<MyPosts> fetchMyPosts() => myPosts();
// }

// class MyPostsBloc {
//   final repository = Repository();
//   final fetcher = PublishSubject<MyPosts>();

//   Observable<MyPosts> get myPosts => fetcher.stream;

//   fetchMyPosts() async {
//     MyPosts myPosts = await repository.fetchMyPosts();
//     fetcher.sink.add(myPosts);
//   }

//   dispose() {
//     fetcher.close();
//   }
// }

// final bloc = MyPostsBloc();

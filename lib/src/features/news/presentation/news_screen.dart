import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gold_silver/src/features/news/presentation/bloc/news_bloc.dart';
import 'package:gold_silver/src/features/news/presentation/bloc/news_state.dart';
import 'package:localization/localization.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsBloc, NewsState>(builder: (context, state) {
      if (state is NewsLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is NewsError) {
        return Center(child: Text(state.message));
      } else if (state is NewsLoaded) {
        return ListView.builder(
            itemCount: state.news.length,
            itemBuilder: (_, index) {
              final news = state.news[index];
              return InkWell(
                onTap: () => launchUrl(Uri.parse(news.url)),
                child: Container(
                  margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                    border: Border.all(
                      color: Colors.grey.shade300,
                    ),
                  ),
                  child: Row(
                    children: [
                      Image.network(
                        news.urlToImage,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              news.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              news.publishedAt,
                              style: const TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              news.description,
                              style: const TextStyle(fontSize: 12),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'xem_them'.i18n(),
                                style: const TextStyle(fontSize: 14, color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
      }
      return const SizedBox();
    }, listener: (context, state) {
      if (state is NewsError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.message),
          ),
        );
      }
    });
  }
}

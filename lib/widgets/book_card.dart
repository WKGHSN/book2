import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../models/book.dart';
import '../constants/app_colors.dart';

class BookCard extends StatelessWidget {
  final Book book;
  final VoidCallback onTap;

  const BookCard({
    super.key,
    required this.book,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Обкладинка
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.darkSurfaceVariant
                    : AppColors.lightGold.withValues(alpha: 0.3),
                child: book.coverUrl != null
                    ? Image.asset(
                        book.coverUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Icon(
                              Icons.book,
                              size: 48,
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? AppColors.secondaryAccent
                                  : AppColors.goldenAccent,
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Icon(
                          Icons.book,
                          size: 48,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? AppColors.secondaryAccent
                              : AppColors.goldenAccent,
                        ),
                      ),
              ),
            ),
            
            // Інформація про книгу
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Назва
                    Text(
                      book.title,
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    
                    // Автор
                    Text(
                      book.author,
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    
                    // Рейтинг
                    Row(
                      children: [
                        RatingBarIndicator(
                          rating: book.averageRating,
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: Theme.of(context).brightness == Brightness.dark
                                ? AppColors.secondaryAccent
                                : AppColors.goldenAccent,
                          ),
                          itemCount: 5,
                          itemSize: 14.0,
                          direction: Axis.horizontal,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          book.averageRating.toStringAsFixed(1),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

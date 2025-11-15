import 'package:flutter/material.dart';
import 'package:newsapp/feature/home/models/news_article_model.dart';

class NewsDetailScreen extends StatelessWidget {
  const NewsDetailScreen({super.key, required this.newsArticle});

  final NewsArticleModel newsArticle;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        title: Text(
          'News Detail',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: colorScheme.onPrimary,
          ),
        ),
        centerTitle: true,
        backgroundColor: colorScheme.primary,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.share, color: colorScheme.onPrimary),
            onPressed: () => _shareArticle(context),
          ),
          IconButton(
            icon: Icon(Icons.bookmark_border, color: colorScheme.onPrimary),
            onPressed: () => _bookmarkArticle(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Image
            _buildHeroImage(context),

            // Content Padding
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category & Date
                  _buildArticleMeta(context),

                  const SizedBox(height: 16),

                  // Title
                  _buildArticleTitle(textTheme),

                  const SizedBox(height: 20),

                  // Author
                  if (newsArticle.author != null &&
                      newsArticle.author!.isNotEmpty)
                    _buildAuthorSection(textTheme, colorScheme),

                  const SizedBox(height: 24),

                  // Description
                  if (newsArticle.description != null &&
                      newsArticle.description!.isNotEmpty)
                    _buildDescription(textTheme),

                  const SizedBox(height: 24),

                  // Content
                  if (newsArticle.content != null &&
                      newsArticle.content!.isNotEmpty)
                    _buildContent(textTheme),

                  const SizedBox(height: 30),

                  // Source Info
                  _buildSourceInfo(colorScheme),
                ],
              ),
            ),
          ],
        ),
      ),

      // Floating Action Button for quick actions
      floatingActionButton: FloatingActionButton(
        onPressed: () => _shareArticle(context),
        backgroundColor: colorScheme.primary,
        child: Icon(Icons.share, color: colorScheme.onPrimary),
      ),
    );
  }

  Widget _buildHeroImage(BuildContext context) {
    return Hero(
      tag: 'news-image-${newsArticle.urlToImage}',
      child: Container(
        height: 250,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          child:
              newsArticle.urlToImage != null &&
                  newsArticle.urlToImage!.isNotEmpty
              ? Image.network(
                  newsArticle.urlToImage!,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: Colors.grey[200],
                      child: Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[200],
                      child: const Icon(
                        Icons.article,
                        size: 60,
                        color: Colors.grey,
                      ),
                    );
                  },
                )
              : Container(
                  color: Colors.grey[200],
                  child: const Icon(
                    Icons.article,
                    size: 60,
                    color: Colors.grey,
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildArticleMeta(BuildContext context) {
    return Row(
      children: [
        // Category Chip
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            'News',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        const Spacer(),
        // Published Date
        Row(
          children: [
            Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
            const SizedBox(width: 4),
            Text(
              _formatDate(newsArticle.publishedAt),
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildArticleTitle(TextTheme textTheme) {
    return Text(
      newsArticle.title,
      style: textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.w700,
        height: 1.3,
      ),
    );
  }

  Widget _buildAuthorSection(TextTheme textTheme, ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outline.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: colorScheme.primary.withOpacity(0.1),
            child: Icon(Icons.person, color: colorScheme.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Author',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                const SizedBox(height: 2),
                Text(
                  newsArticle.author!,
                  style: textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Summary',
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Text(
          newsArticle.description!,
          style: textTheme.bodyLarge?.copyWith(
            height: 1.6,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }

  Widget _buildContent(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Full Story',
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Text(
          newsArticle.content!,
          style: textTheme.bodyLarge?.copyWith(
            height: 1.6,
            color: Colors.grey[800],
          ),
        ),
      ],
    );
  }

  Widget _buildSourceInfo(ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: colorScheme.primary, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Source: ${newsArticle.author ?? 'Unknown'} • ${_formatDate(newsArticle.publishedAt)}',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return dateString;
    }
  }

  void _shareArticle(BuildContext context) {
    // Implement share functionality
    // You can use packages like share_plus for this
  }

  void _bookmarkArticle() {
    // Implement bookmark functionality
  }
}

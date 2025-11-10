import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../../models/user.dart';
import '../../models/book.dart';
import '../../services/hive_service.dart';
import '../auth/login_screen.dart';
import '../book/book_detail_screen.dart';
import '../../constants/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? _currentUser;
  List<Book> _readBooks = [];

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    final user = HiveService.getCurrentUser();
    if (user != null) {
      setState(() {
        _currentUser = user;
        _readBooks = HiveService.getReadBooks(user.id);
      });
    }
  }

  Future<void> _logout() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Вихід'),
        content: const Text('Ви впевнені, що хочете вийти з акаунту?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Скасувати'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Вийти'),
          ),
        ],
      ),
    );

    if (confirm == true && mounted) {
      await HiveService.logout();
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    }
  }

  void _showAddBookDialog() {
    final titleController = TextEditingController();
    final authorController = TextEditingController();
    final descriptionController = TextEditingController();
    String selectedGenre = 'Романтика';
    final genres = [
      'Романтика',
      'Фантастика',
      'Детективи',
      'Психологія',
      'Пригоди',
      'Класика',
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Додати власну книгу'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Назва книги'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: authorController,
                decoration: const InputDecoration(labelText: 'Автор'),
              ),
              const SizedBox(height: 8),
              StatefulBuilder(
                builder: (context, setState) => DropdownButtonFormField<String>(
                  initialValue: selectedGenre,
                  decoration: const InputDecoration(labelText: 'Жанр'),
                  items: genres
                      .map((genre) => DropdownMenuItem(
                            value: genre,
                            child: Text(genre),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() => selectedGenre = value!);
                  },
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Опис'),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () async {
                  final result = await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['pdf', 'txt'],
                  );
                  if (result != null && mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Файл вибрано: ${result.files.first.name}'),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.attach_file),
                label: const Text('Вибрати файл'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Скасувати'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (titleController.text.isNotEmpty &&
                  authorController.text.isNotEmpty) {
                final newBook = Book(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  title: titleController.text,
                  author: authorController.text,
                  genre: selectedGenre,
                  description: descriptionController.text.isNotEmpty
                      ? descriptionController.text
                      : 'Опис відсутній',
                );
                await HiveService.addBook(newBook);
                if (mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Книгу успішно додано!')),
                  );
                }
              }
            },
            child: const Text('Додати'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_currentUser == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 200,
          pinned: true,
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? AppColors.darkSurface.withValues(alpha: 0.9)
              : AppColors.goldenAccent.withValues(alpha: 0.9),
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: Theme.of(context).brightness == Brightness.dark
                      ? [
                          AppColors.darkSurface,
                          AppColors.darkBackground,
                        ]
                      : [
                          AppColors.goldenAccent,
                          AppColors.lightGold,
                        ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Theme.of(context).brightness == Brightness.dark
                        ? AppColors.darkSurfaceVariant
                        : AppColors.white,
                    child: Text(
                      _currentUser!.name[0].toUpperCase(),
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppColors.darkText
                            : AppColors.darkBrownText,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _currentUser!.name,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? AppColors.darkText
                              : AppColors.darkBrownText,
                        ),
                  ),
                  Text(
                    _currentUser!.email,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? AppColors.darkTextSecondary
                              : AppColors.softBrown,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Статистика
                Card(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppColors.darkSurface.withValues(alpha: 0.9)
                      : Colors.white.withValues(alpha: 0.9),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildStatItem(
                              'Улюблених',
                              _currentUser!.favoriteBooks.length.toString(),
                              Icons.favorite,
                            ),
                            _buildStatItem(
                              'Прочитано',
                              _currentUser!.booksRead.toString(),
                              Icons.book,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Прочитані книги
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Прочитані книги',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    if (_readBooks.isNotEmpty)
                      Text(
                        '${_readBooks.length}',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? AppColors.darkTextSecondary
                              : AppColors.softBrown,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                _readBooks.isEmpty
                    ? Card(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppColors.darkSurface.withValues(alpha: 0.5)
                            : Colors.white.withValues(alpha: 0.9),
                        child: Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Center(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.menu_book_outlined,
                                  size: 48,
                                  color: Theme.of(context).brightness == Brightness.dark
                                      ? AppColors.darkTextSecondary
                                      : AppColors.softBrown,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Ви ще не прочитали жодної книги',
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Theme.of(context).brightness == Brightness.dark
                                        ? AppColors.darkTextSecondary
                                        : AppColors.softBrown,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : SizedBox(
                        height: 180,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _readBooks.length,
                          itemBuilder: (context, index) {
                            final book = _readBooks[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => BookDetailScreen(book: book),
                                  ),
                                ).then((_) => _loadUserData());
                              },
                              child: Container(
                                width: 120,
                                margin: const EdgeInsets.only(right: 12),
                                child: Card(
                                  color: Theme.of(context).brightness == Brightness.dark
                                      ? AppColors.darkSurface
                                      : Colors.white,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: const BorderRadius.vertical(
                                              top: Radius.circular(12),
                                            ),
                                            color: AppColors.lightGold.withValues(alpha: 0.3),
                                          ),
                                          child: book.coverUrl != null
                                              ? ClipRRect(
                                                  borderRadius: const BorderRadius.vertical(
                                                    top: Radius.circular(12),
                                                  ),
                                                  child: Image.asset(
                                                    book.coverUrl!,
                                                    fit: BoxFit.cover,
                                                    width: double.infinity,
                                                    errorBuilder: (context, error, stackTrace) {
                                                      return const Center(
                                                        child: Icon(
                                                          Icons.book,
                                                          size: 40,
                                                          color: AppColors.goldenAccent,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                )
                                              : const Center(
                                                  child: Icon(
                                                    Icons.book,
                                                    size: 40,
                                                    color: AppColors.goldenAccent,
                                                  ),
                                                ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              book.title,
                                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              book.author,
                                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                fontSize: 10,
                                                color: Theme.of(context).brightness == Brightness.dark
                                                    ? AppColors.darkTextSecondary
                                                    : AppColors.softBrown,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                const SizedBox(height: 24),

                // Дії
                Text(
                  'Дії',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                Card(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppColors.darkSurface.withValues(alpha: 0.9)
                      : Colors.white.withValues(alpha: 0.9),
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.add_circle_outline),
                        title: const Text('Додати власну книгу'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: _showAddBookDialog,
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(
                          Icons.logout,
                          color: AppColors.error,
                        ),
                        title: const Text(
                          'Вийти з акаунту',
                          style: TextStyle(color: AppColors.error),
                        ),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: _logout,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Icon(
          icon,
          size: 32,
          color: isDark ? AppColors.secondaryAccent : AppColors.goldenAccent,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}

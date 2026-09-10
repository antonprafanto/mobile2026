// =====================================================================
// SLIDE 07: DOMAIN LAYER - REPOSITORY CONTRACT (INTERFACE)
// Topik: Kontrak Abstrak Yang Menentukan Apa Saja Yang Bisa Dilakukan
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class BookEntity extends Equatable {
  final String title;
  const BookEntity(this.title);
  @override
  List<Object?> get props => [title];
}

// Kontrak Abstrak di Domain Layer: Domain TIDAK PEDULI data diambil dari mana!
abstract class BookRepository {
  Future<List<BookEntity>> getBooks();
}

// Simulasi Mock Sederhana untuk membuktikan kontrak:
class MockBookRepository implements BookRepository {
  @override
  Future<List<BookEntity>> getBooks() async {
    return const [
      BookEntity('Clean Architecture 2026'),
      BookEntity('Flutter BLoC Master'),
    ];
  }
}

void main() {
  runApp(const RepoContractApp());
}

class RepoContractApp extends StatelessWidget {
  const RepoContractApp({super.key});

  @override
  Widget build(BuildContext context) {
    final BookRepository repo = MockBookRepository();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 07 - Repository Contract',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.cyan),
      home: Scaffold(
        appBar: AppBar(title: const Text('Slide 07: Repository Contract')),
        body: FutureBuilder<List<BookEntity>>(
          future: repo.getBooks(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return const Center(child: CircularProgressIndicator());
            final books = snapshot.data!;
            return ListView.builder(
              itemCount: books.length,
              itemBuilder: (ctx, i) => ListTile(
                leading: const Icon(Icons.book),
                title: Text(books[i].title),
              ),
            );
          },
        ),
      ),
    );
  }
}

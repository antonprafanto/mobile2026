// =====================================================================
// SLIDE 16: ALUR DATA LENGKAP END-TO-END CLEAN ARCHITECTURE
// Topik: UI -> Cubit -> Use Case -> Repo Contract -> Repo Impl -> Data Source
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 1. Domain Entity
class Item {
  final String title;
  const Item(this.title);
}

// 2. Domain Repository Contract
abstract class ItemRepository {
  Future<Item> fetchItem();
}

// 3. Domain Use Case
class GetItemUseCase {
  final ItemRepository repository;
  GetItemUseCase(this.repository);
  Future<Item> call() => repository.fetchItem();
}

// 4. Data Layer Repository Impl
class ItemRepositoryImpl implements ItemRepository {
  @override
  Future<Item> fetchItem() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const Item('Data Sukses Mengalir dari Data Layer ke UI!');
  }
}

// 5. Presentation Cubit
class ItemCubit extends Cubit<String> {
  final GetItemUseCase getItem;
  ItemCubit(this.getItem) : super('Menunggu Aksi...');

  Future<void> load() async {
    emit('Sedang Mengambil...');
    final res = await getItem();
    emit(res.title);
  }
}

void main() {
  final repo = ItemRepositoryImpl();
  final useCase = GetItemUseCase(repo);

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 16 - End to End Flow',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: BlocProvider(
        create: (context) => ItemCubit(useCase),
        child: const EndToEndScreen(),
      ),
    ),
  );
}

class EndToEndScreen extends StatelessWidget {
  const EndToEndScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Slide 16: Alur End-to-End')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<ItemCubit, String>(
                builder: (context, state) => Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      state,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: () => context.read<ItemCubit>().load(),
                icon: const Icon(Icons.play_arrow),
                label: const Text('Mulai Alur End-to-End'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =====================================================================
// SLIDE 19: MODE KONKURENSI EVENT (BLOC CONCURRENCY)
// Topik: Melindungi Aplikasi dari Spam Klik Transaksi & Debounce Pencarian
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// --- EVENT ---
abstract class TransactionEvent {}
class ProcessPaymentEvent extends TransactionEvent {
  final int amount;
  ProcessPaymentEvent(this.amount);
}
class ResetPaymentEvent extends TransactionEvent {}

// --- STATE ---
enum PaymentStatus { idle, processing, success, dropped }

class TransactionState {
  final PaymentStatus status;
  final String message;
  final int transactionCount;

  const TransactionState({
    required this.status,
    required this.message,
    required this.transactionCount,
  });

  TransactionState copyWith({
    PaymentStatus? status,
    String? message,
    int? transactionCount,
  }) {
    return TransactionState(
      status: status ?? this.status,
      message: message ?? this.message,
      transactionCount: transactionCount ?? this.transactionCount,
    );
  }
}

// --- BLOC DENGAN SIMULASI DROPPABLE ---
// Di produksi nyata: gunakan package 'bloc_concurrency' dengan transformer: droppable()
class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  bool _isProcessing = false;

  TransactionBloc()
      : super(const TransactionState(
          status: PaymentStatus.idle,
          message: 'Siap memproses transaksi. Coba klik berkali-kali cepat!',
          transactionCount: 0,
        )) {
    // Implementasi logika droppable: abaikan event jika sedang sibuk
    on<ProcessPaymentEvent>((event, emit) async {
      if (_isProcessing) {
        // [DROPPED] Abaikan spam klik!
        debugPrint('[BLOC DROPPABLE] Event diabaikan karena transaksi sedang berjalan!');
        emit(state.copyWith(
          status: PaymentStatus.dropped,
          message: '[DITOLAK] Klik kedua diabaikan: Sistem sedang memproses transaksi sebelumnya.',
        ));
        return;
      }

      _isProcessing = true;
      emit(state.copyWith(
        status: PaymentStatus.processing,
        message: 'Memproses pembayaran Rp ${event.amount} ke gateway bank...',
      ));

      // Simulasi delay jaringan 2 detik
      await Future<void>.delayed(const Duration(seconds: 2));

      _isProcessing = false;
      emit(state.copyWith(
        status: PaymentStatus.success,
        message: '[SUKSES] Pembayaran Rp ${event.amount} telah dikonfirmasi.',
        transactionCount: state.transactionCount + 1,
      ));
    });

    on<ResetPaymentEvent>((event, emit) {
      _isProcessing = false;
      emit(const TransactionState(
        status: PaymentStatus.idle,
        message: 'Siap memproses transaksi.',
        transactionCount: 0,
      ));
    });
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: BlocConcurrencyDemoPage(),
  ));
}

class BlocConcurrencyDemoPage extends StatelessWidget {
  const BlocConcurrencyDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TransactionBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Slide 19: Proteksi Spam Klik (droppable)'),
          backgroundColor: Colors.amber,
          foregroundColor: Colors.black,
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.security, size: 80, color: Colors.blueAccent),
                const SizedBox(height: 16),
                const Text(
                  'Simulasi Proteksi Checkout Perbankan',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Ketik tombol "BAYAR" 3x dengan sangat cepat! Perhatikan bagaimana sistem menolak klik duplikat.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 32),
                BlocBuilder<TransactionBloc, TransactionState>(
                  builder: (context, state) {
                    Color statusColor = Colors.grey.shade200;
                    if (state.status == PaymentStatus.processing) statusColor = Colors.blue.shade100;
                    if (state.status == PaymentStatus.success) statusColor = Colors.green.shade100;
                    if (state.status == PaymentStatus.dropped) statusColor = Colors.orange.shade100;

                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: Column(
                        children: [
                          Text(
                            state.message,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text('Total Transaksi Sukses: ${state.transactionCount} kali'),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BlocBuilder<TransactionBloc, TransactionState>(
                      builder: (context, state) {
                        return FilledButton.icon(
                          onPressed: () {
                            context.read<TransactionBloc>().add(ProcessPaymentEvent(500000));
                          },
                          icon: const Icon(Icons.payment),
                          label: const Text('BAYAR Rp 500.000'),
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.amber,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 16),
                    Builder(
                      builder: (context) {
                        return OutlinedButton(
                          onPressed: () => context.read<TransactionBloc>().add(ResetPaymentEvent()),
                          child: const Text('Reset'),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

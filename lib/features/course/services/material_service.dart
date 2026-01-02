import '../models/material_model.dart';

class MaterialService {
  // Method untuk mengambil data materi berdasarkan moduleId
  static MaterialModel getMaterialByModuleId(String moduleId) {
    
    // Data untuk modul "Cara Memegang Pensil" (id: '1')
    if (moduleId == '1') {
      return MaterialModel(
        id: 'mat-1',
        moduleId: moduleId,
        title: 'Cara Memegang Pensil',
        sections: [
          MaterialSection(
            type: 'text',
            content: 'Memegang pensil dengan benar adalah langkah pertama yang penting dalam belajar menulis. Cara memegang pensil yang tepat akan membantu kamu menulis dengan rapi dan tidak cepat lelah.',
          ),
          MaterialSection(
            type: 'image',
            imageUrl: 'https://via.placeholder.com/300x200/1A6585/FFFFFF?text=Cara+Memegang+Pensil',
          ),
          MaterialSection(
            type: 'highlight',
            highlightTitle: 'Kenapa Penting?',
            highlightContent: 'Memegang pensil dengan benar membuat tulisan lebih rapi dan tangan tidak mudah lelah saat menulis.',
          ),
          MaterialSection(
            type: 'text',
            content: 'Berikut adalah langkah-langkah memegang pensil yang benar:',
          ),
          MaterialSection(
            type: 'list',
            listItems: [
              'Pegang pensil dengan tiga jari: ibu jari, jari telunjuk, dan jari tengah',
              'Jari manis dan kelingking sebagai penopang di bawah',
              'Jangan terlalu keras memegang pensil',
              'Posisi pensil miring sekitar 45 derajat',
              'Jarak jari ke ujung pensil sekitar 2-3 cm',
            ],
          ),
          MaterialSection(
            type: 'text',
            content: 'Latih terus cara memegang pensil yang benar agar menjadi kebiasaan. Setelah terbiasa, kamu akan menulis dengan lebih mudah dan rapi!',
          ),
        ],
      );
    }
    
    // Data untuk modul "Latihan Menulis Huruf A-E" (id: '2')
    if (moduleId == '2') {
      return MaterialModel(
        id: 'mat-2',
        moduleId: moduleId,
        title: 'Latihan Menulis Huruf A-E',
        sections: [
          MaterialSection(
            type: 'text',
            content: 'Sekarang kita akan belajar menulis huruf vokal A, E, I, O, U. Huruf-huruf ini adalah dasar penting dalam menulis.',
          ),
          MaterialSection(
            type: 'image',
            imageUrl: 'https://via.placeholder.com/300x200/1A6585/FFFFFF?text=Huruf+Vokal+A-E',
          ),
          MaterialSection(
            type: 'highlight',
            highlightTitle: 'Tips Menulis',
            highlightContent: 'Mulai dari garis atas, turun perlahan, dan ikuti arah panah pada contoh huruf.',
          ),
          MaterialSection(
            type: 'text',
            content: 'Mari kita pelajari satu per satu:',
          ),
          MaterialSection(
            type: 'list',
            listItems: [
              'Huruf A: Buat garis miring ke kanan, lalu garis miring ke kiri, tambahkan garis tengah',
              'Huruf E: Buat garis vertikal, lalu tambahkan tiga garis horizontal',
              'Huruf I: Buat garis vertikal dengan titik di atas',
              'Huruf O: Buat lingkaran sempurna dari atas',
              'Huruf U: Buat garis melengkung dari atas ke bawah',
            ],
          ),
          MaterialSection(
            type: 'text',
            content: 'Latih menulis setiap huruf minimal 10 kali agar semakin mahir!',
          ),
        ],
      );
    }

    // Data untuk modul "Latihan Menulis Huruf F-J" (id: '4')
    if (moduleId == '4') {
      return MaterialModel(
        id: 'mat-4',
        moduleId: moduleId,
        title: 'Latihan Menulis Huruf F-J',
        sections: [
          MaterialSection(
            type: 'text',
            content: 'Setelah belajar huruf A-E, sekarang kita lanjut ke huruf F, G, H, I, dan J. Huruf-huruf ini memiliki bentuk yang unik.',
          ),
          MaterialSection(
            type: 'image',
            imageUrl: 'https://via.placeholder.com/300x200/1A6585/FFFFFF?text=Huruf+F-J',
          ),
          MaterialSection(
            type: 'list',
            listItems: [
              'Huruf F: Buat garis vertikal, tambahkan dua garis horizontal di bagian atas',
              'Huruf G: Buat lingkaran tidak sempurna dengan garis horizontal di tengah',
              'Huruf H: Buat dua garis vertikal dengan garis horizontal di tengah',
              'Huruf I: Garis vertikal sederhana (sudah dipelajari)',
              'Huruf J: Garis melengkung ke bawah dengan titik di atas',
            ],
          ),
          MaterialSection(
            type: 'highlight',
            highlightTitle: 'Perhatian!',
            highlightContent: 'Huruf G dan J memiliki bagian yang turun ke bawah. Pastikan proporsinya tepat!',
          ),
        ],
      );
    }

    // Default material jika moduleId tidak ditemukan
    return MaterialModel(
      id: 'mat-default',
      moduleId: moduleId,
      title: 'Materi Pembelajaran',
      sections: [
        MaterialSection(
          type: 'text',
          content: 'Materi ini sedang dalam pengembangan. Silakan coba modul lainnya atau hubungi guru untuk informasi lebih lanjut.',
        ),
        MaterialSection(
          type: 'highlight',
          highlightTitle: 'Info',
          highlightContent: 'Materi akan segera tersedia. Terima kasih atas kesabarannya!',
        ),
      ],
    );
  }
}
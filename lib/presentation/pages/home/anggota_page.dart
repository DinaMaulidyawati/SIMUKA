import 'package:flutter/material.dart';

class AnggotaPage extends StatefulWidget {
  final String ukmName;
  const AnggotaPage({super.key, required this.ukmName});

  @override
  State<AnggotaPage> createState() => _AnggotaPageState();
}

class _AnggotaPageState extends State<AnggotaPage> {
  // Database sementara (List)
  final List<Map<String, String>> _listAnggota = [
    {'nama': 'Ahmad Fauzi', 'nim': '22010101', 'divisi': 'Inti'},
    {'nama': 'Siti Maryam', 'nim': '22010105', 'divisi': 'Humas'},
    {'nama': 'Budi Doremi', 'nim': '22010109', 'divisi': 'Minat Bakat'},
  ];

  List<Map<String, String>> _filteredAnggota = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredAnggota = _listAnggota; // Tampilkan semua saat awal
  }

  // Fungsi Cari Anggota
  void _filterSearch(String query) {
    setState(() {
      _filteredAnggota = _listAnggota
          .where((item) => item['nama']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  // Dialog Tambah/Edit Anggota
  void _showForm({int? index}) {
    TextEditingController namaC = TextEditingController();
    TextEditingController nimC = TextEditingController();
    String selectedDivisi = 'Humas';

    // Jika mode EDIT, isi field dengan data lama
    if (index != null) {
      namaC.text = _filteredAnggota[index]['nama']!;
      nimC.text = _filteredAnggota[index]['nim']!;
      selectedDivisi = _filteredAnggota[index]['divisi']!;
    }

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(index == null ? "Tambah Anggota" : "Edit Anggota"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Placeholder Foto (Nantinya bisa diganti ImagePicker)
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey[200],
                  child: const Icon(Icons.camera_alt, color: Colors.grey, size: 30),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: namaC,
                  decoration: const InputDecoration(labelText: "Nama Lengkap", border: OutlineInputBorder()),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: nimC,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "NIM", border: OutlineInputBorder()),
                ),
                const SizedBox(height: 15),
                DropdownButtonFormField(
                  value: selectedDivisi,
                  decoration: const InputDecoration(labelText: "Divisi", border: OutlineInputBorder()),
                  items: ['Inti', 'Humas', 'Perlengkapan', 'Minat Bakat'].map((e) {
                    return DropdownMenuItem(value: e, child: Text(e));
                  }).toList(),
                  onChanged: (val) => setDialogState(() => selectedDivisi = val.toString()),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("Batal")),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFE082)),
              onPressed: () {
                setState(() {
                  var data = {
                    'nama': namaC.text,
                    'nim': nimC.text,
                    'divisi': selectedDivisi
                  };
                  if (index == null) {
                    _listAnggota.add(data);
                  } else {
                    int idxAsli = _listAnggota.indexOf(_filteredAnggota[index]);
                    _listAnggota[idxAsli] = data;
                  }
                  _filterSearch(_searchController.text);
                });
                Navigator.pop(context);
              },
              child: const Text("Simpan", style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Anggota", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        backgroundColor: const Color(0xFFFFE082),
        elevation: 0,
      ),
      body: Column(
        children: [
          // HEADER & SEARCH BAR
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xFFFFE082),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
            ),
            child: TextField(
              controller: _searchController,
              onChanged: _filterSearch,
              decoration: InputDecoration(
                hintText: "Cari nama anggota...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
              ),
            ),
          ),
          
          // DAFTAR ANGGOTA
          Expanded(
            child: _filteredAnggota.isEmpty
                ? const Center(child: Text("Anggota tidak ditemukan"))
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredAnggota.length,
                    itemBuilder: (context, index) {
                      final item = _filteredAnggota[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          leading: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.orange[100],
                            child: Text(item['nama']![0], style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)),
                          ),
                          title: Text(item['nama']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("NIM: ${item['nim']}"),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(color: Colors.orange[50], borderRadius: BorderRadius.circular(5)),
                                child: Text(item['divisi']!, style: const TextStyle(fontSize: 10, color: Colors.orange)),
                              ),
                            ],
                          ),
                          trailing: PopupMenuButton(
                            onSelected: (val) {
                              if (val == 'edit') _showForm(index: index);
                              if (val == 'delete') {
                                setState(() {
                                  _listAnggota.remove(item);
                                  _filterSearch(_searchController.text);
                                });
                              }
                            },
                            itemBuilder: (context) => [
                              const PopupMenuItem(value: 'edit', child: Row(children: [Icon(Icons.edit, size: 18), SizedBox(width: 8), Text("Edit")])),
                              const PopupMenuItem(value: 'delete', child: Row(children: [Icon(Icons.delete, color: Colors.red, size: 18), SizedBox(width: 8), Text("Hapus", style: TextStyle(color: Colors.red))])),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFFFE082),
        onPressed: () => _showForm(),
        child: const Icon(Icons.person_add, color: Colors.black),
      ),
    );
  }
}
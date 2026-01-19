import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../state/app_state.dart';

class DetailKegiatanPage extends StatefulWidget {
  final String title;
  final String ukmName; // Tambahkan ini untuk tahu UKM mana yang diupdate
  const DetailKegiatanPage({super.key, required this.title, required this.ukmName});

  @override
  State<DetailKegiatanPage> createState() => _DetailKegiatanPageState();
}

class _DetailKegiatanPageState extends State<DetailKegiatanPage> {
  List<Map<String, String>> dataList = [];

  void _bukaForm({int? index}) {
    TextEditingController namaC = TextEditingController();
    DateTime tglS = DateTime.now();

    if (index != null) namaC.text = dataList[index]['nama']!;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDt) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(index == null ? "Tambah ${widget.title}" : "Edit Data"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.title == 'Event / Lomba') 
                Container(
                  height: 120, width: double.infinity,
                  decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Icon(Icons.add_photo_alternate, size: 40, color: Colors.grey), Text("Tambah Poster")],
                  ),
                ),
              const SizedBox(height: 15),
              TextField(controller: namaC, decoration: const InputDecoration(labelText: "Judul Kegiatan", border: OutlineInputBorder())),
              const SizedBox(height: 10),
              ListTile(
                title: Text("Tanggal: ${DateFormat('dd MMMM yyyy').format(tglS)}"),
                trailing: const Icon(Icons.calendar_month, color: Colors.orange),
                onTap: () async {
                  DateTime? p = await showDatePicker(context: context, initialDate: tglS, firstDate: DateTime(2025), lastDate: DateTime(2100));
                  if (p != null) setDt(() => tglS = p);
                },
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("Batal")),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFE082)),
              onPressed: () {
                setState(() {
                  var d = {'nama': namaC.text, 'tgl': DateFormat('dd MMMM yyyy').format(tglS)};
                  index == null ? dataList.add(d) : dataList[index] = d;

                  // LOGIKA UTAMA: Jika nambah/edit di menu Event, aktifkan status di HomePage
                  if (widget.title == 'Event / Lomba' && dataList.isNotEmpty) {
                    AppState.ukmEventStatus[widget.ukmName] = true;
                  }
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
    bool isEvent = widget.title == 'Event / Lomba';
    return Scaffold(
      appBar: AppBar(title: Text(widget.title), backgroundColor: const Color(0xFFFFE082)),
      body: dataList.isEmpty
          ? const Center(child: Text("Data kosong, klik + untuk menambah"))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: dataList.length,
              itemBuilder: (context, index) => Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    if (isEvent) 
                      Container(height: 150, width: double.infinity, color: Colors.grey[300], child: const Icon(Icons.image, size: 50)),
                    ListTile(
                      title: Text(dataList[index]['nama']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(dataList[index]['tgl']!),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(icon: const Icon(Icons.edit, color: Colors.blue), onPressed: () => _bukaForm(index: index)),
                          IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () {
                            setState(() {
                              dataList.removeAt(index);
                              if (isEvent && dataList.isEmpty) AppState.ukmEventStatus[widget.ukmName] = false;
                            });
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFFFE082),
        onPressed: () => _bukaForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:prakmob3/UTS/Controller/service.dart';
import 'package:prakmob3/UTS/Models/stasiun.dart';

class Local extends StatefulWidget {
  @override
  _LocalState createState() => _LocalState();
}

class _LocalState extends State<Local> {
  List<Stasiun> departureStations = []; // List stasiun lokal
  List<Stasiun> allStations = []; // List semua stasiun (local + intercity)
  List<String> departureCities = []; // List nama stasiun untuk departure
  List<String> destinationCities = []; // List nama stasiun untuk destination
  List<Stasiun> stasiunList = []; // List of Stasiun objects
  List<String> cities = []; // List of station names (strings)
  String? selectedDepartureCity;
  String? selectedDestinationCity;
  DateTime? selectedDate;
  String? selectedTime;
  Map<String, dynamic> selectedData = {};
  String selectedTab = "Local"; // Variabel untuk menyimpan tab yang dipilih

  // Controllers for each TextFormField
  final TextEditingController nameController = TextEditingController();
  final TextEditingController departureController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  final TextEditingController classController = TextEditingController();
  final TextEditingController passengersController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadDepartureStations();
    _loadAllStations();
  }

  Future<void> _loadDepartureStations() async {
    try {
      List<Stasiun> localStations = await ApiService().fetchLocalStasiun();
      setState(() {
        departureStations = localStations;
        departureCities = localStations.map((stasiun) => stasiun.nama).toList();
      });
    } catch (e) {
      print("Error loading local stations: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load local stations')),
      );
    }
  }

  // Memuat semua stasiun untuk "Arriving at"
  Future<void> _loadAllStations() async {
    try {
      List<Stasiun> allStationsData = await ApiService().fetchAllStasiun();
      setState(() {
        allStations = allStationsData;
        destinationCities =
            allStationsData.map((stasiun) => stasiun.nama).toList();
      });
    } catch (e) {
      print("Error loading all stations: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load stations')),
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEAF2FF),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Book Your Next Trip!",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF00226B),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            // 2. Column untuk memilih jenis perjalanan (Local / Intercity)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTabButton(context, "Local"),
                _buildTabButton(context, "Intercity"),
              ],
            ),
            SizedBox(height: 20),

            // 3. Column untuk input keterangan tiket sesuai desain
            _buildInputField(
                "Name:", "Enter Your Name", Icons.person, nameController),
            SizedBox(height: 20),

            _buildDropdownField(
              "From:",
              "Select Departure Station",
              departureCities, // Gunakan departureCities untuk departure
              selectedDepartureCity,
              (value) {
                setState(() {
                  selectedDepartureCity = value;
                });
              },
            ),

            SizedBox(height: 20),

            _buildDropdownField(
              "Arriving at:",
              "Select Destination Station",
              destinationCities, // Gunakan destinationCities untuk destination
              selectedDestinationCity,
              (value) {
                setState(() {
                  selectedDestinationCity = value;
                });
              },
            ),
             SizedBox(height: 20),

            _buildDateInputField(
                "Departure:", "Select Date", Icons.calendar_today),
            SizedBox(height: 20),
            _buildInputField("Passengers:", "1 Passenger", Icons.people,
                passengersController),
            SizedBox(height: 30),

            // Tombol Book Ticket
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    selectedDepartureCity != null &&
                    selectedDestinationCity != null &&
                    selectedDate != null &&
                    passengersController.text.isNotEmpty) {
                  selectedData = {
                    'name': nameController.text,
                    'departureCity': selectedDepartureCity,
                    'destinationCity': selectedDestinationCity,
                    'date': selectedDate,
                    'passengers': passengersController.text,
                  };
                  Navigator.pushNamed(context, '/seat_selection',
                      arguments: selectedData);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please complete all fields')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF00226B),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "Book Ticket",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Color(0xFF00226B)),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark, color: Color(0xFF00226B)),
            label: "Saved",
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField(String label, String placeholder,
      List<String> items, String? selectedItem, Function(String?) onChanged) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0xFF99B9FF), width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(Icons.train, color: Color(0xFF00226B)),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Color(0xFF00226B),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                DropdownButton<String>(
                  value: selectedItem,
                  hint: Text(placeholder),
                  isExpanded: true,
                  items: items.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: onChanged,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(BuildContext context, String title) {
    Color activeColor = Color(0xFF00226B); // Warna saat tab aktif
    Color inactiveColor = Color(0xFF0062A1); // Warna saat tab tidak aktif

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedTab = title; // Update selected tab
          });

          // Navigasi ke halaman yang sesuai berdasarkan tab yang dipilih
          if (title == "Local") {
            Navigator.pushNamed(context, '/local');
          } else if (title == "Intercity") {
            Navigator.pushNamed(context, '/intercity');
          }
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          padding: EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: selectedTab == title ? activeColor : Colors.white,
            border: Border.all(
                color: selectedTab == title ? activeColor : Color(0xFF00226B),
                width: 1.5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: selectedTab == title ? Colors.white : inactiveColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String label, String placeholder, IconData icon,
      TextEditingController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0xFF99B9FF), width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, color: Color(0xFF00226B)),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Color(0xFF00226B),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: placeholder,
                    border: InputBorder.none,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateInputField(String label, String placeholder, IconData icon) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color(0xFF99B9FF), width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(icon, color: Color(0xFF00226B)),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      color: Color(0xFF00226B),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    selectedDate == null
                        ? placeholder
                        : "${selectedDate?.toLocal()}"
                            .split(' ')[0], // Tampilkan tanggal yang dipilih
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // // Fungsi untuk memilih waktu (optional, jika Anda ingin menambahkan)
  // Widget _buildTimeInputField(String label, String placeholder) {
  //   return Container(
  //     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       border: Border.all(color: Color(0xFF99B9FF), width: 1),
  //       borderRadius: BorderRadius.circular(10),
  //     ),
  //     child: Row(
  //       children: [
  //         Icon(Icons.access_time, color: Color(0xFF00226B)),
  //         SizedBox(width: 10),
  //         Expanded(
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 label,
  //                 style: TextStyle(
  //                   color: Color(0xFF00226B),
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //               DropdownButton<String>(
  //                 value: selectedTime,
  //                 hint: Text(placeholder),
  //                 isExpanded: true,
  //                 items: times.map((String time) {
  //                   return DropdownMenuItem<String>(
  //                     value: time,
  //                     child: Text(time),
  //                   );
  //                 }).toList(),
  //                 onChanged: (String? newValue) {
  //                   setState(() {
  //                     selectedTime = newValue;
  //                   });
  //                 },
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}

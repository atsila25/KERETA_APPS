import 'package:flutter/material.dart';
import 'package:prakmob3/UTS/Controller/service.dart';

class Intercity extends StatefulWidget {
  @override
  _IntercityState createState() => _IntercityState();
}

class _IntercityState extends State<Intercity> {
  List<String> cities = [];
  final List<String> times = ['08:00 AM', '12:00 PM', '03:00 PM', '07:00 PM'];
  String? selectedDepartureCity;
  String? selectedDestinationCity;
  String? selectedTime;
  DateTime? selectedDate;
  Map<String, dynamic> selectedData = {};
  String selectedTab = "Intercity"; // Variabel untuk menyimpan tab yang dipilih

  // Controllers for each TextFormField
  final TextEditingController nameController = TextEditingController();
  final TextEditingController departureController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  final TextEditingController classController = TextEditingController();
  final TextEditingController passengersController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadStations();
  }

  Future<void> _loadStations() async {
    try {
      // final fetchedStations = await ukRailService.getStations();
      setState(() {
        // cities = fetchedStations.cast<String>();
      });
    } catch (e) {
      print("Error loading stations: $e");
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
            _buildInputField(
                "From:", "Station Name", Icons.train, departureController),
            SizedBox(height: 20),
            _buildInputField("Arriving at:", "Station Name",
                Icons.train_outlined, destinationController),
            SizedBox(height: 20),
            _buildDateInputField(
                "Departure:", "Select Date", Icons.calendar_today),
            SizedBox(height: 20),
            _buildInputField(
                "Class:", "Economy", Icons.class_, classController),
            SizedBox(height: 20),
            _buildInputField("Passengers:", "1 Passenger", Icons.people,
                passengersController),
            SizedBox(height: 30),

            // Tombol Book Ticket
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    departureController.text.isNotEmpty &&
                    destinationController.text.isNotEmpty &&
                    selectedDate != null &&
                    classController.text.isNotEmpty &&
                    passengersController.text.isNotEmpty) {
                  selectedData = {
                    'name': nameController.text,
                    'departureCity': departureController.text,
                    'destinationCity': destinationController.text,
                    'time': selectedTime,
                    'date': selectedDate,
                    'class': classController.text,
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

      // 4. Bottom Navigation Bar
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

Widget _buildTabButton(BuildContext context, String title) {
  Color activeColor = Color(0xFF00226B); // Warna saat tab aktif
  Color inactiveColor = Color(0xFF0062A1); // Warna saat tab tidak aktif

  return Expanded(
    child: GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = title;  // Update selected tab
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
          border: Border.all(color: selectedTab == title ? activeColor : Color(0xFF00226B), width: 1.5),
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

  // Fungsi untuk memilih waktu (optional, jika Anda ingin menambahkan)
  Widget _buildTimeInputField(String label, String placeholder) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0xFF99B9FF), width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(Icons.access_time, color: Color(0xFF00226B)),
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
                  value: selectedTime,
                  hint: Text(placeholder),
                  isExpanded: true,
                  items: times.map((String time) {
                    return DropdownMenuItem<String>(
                      value: time,
                      child: Text(time),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedTime = newValue;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

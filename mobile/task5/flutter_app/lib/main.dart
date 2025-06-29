import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant Manager',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const RestaurantListScreen(),
    );
  }
}

class RestaurantListScreen extends StatefulWidget {
  const RestaurantListScreen({super.key});

  @override
  State<RestaurantListScreen> createState() => _RestaurantListScreenState();
}

class _RestaurantListScreenState extends State<RestaurantListScreen> {
  List<dynamic> _restaurants = [];
  bool _loading = true;
  String? _error;
  final String baseUrl = 'http://127.0.0.1:8000/api/restaurants/'; // For emulator

  @override
  void initState() {
    super.initState();
    fetchRestaurants();
  }

  Future<void> fetchRestaurants() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          _restaurants = data;
          _loading = false;
        });
      } else {
        setState(() {
          _error = 'Error: ${response.statusCode}';
          _loading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Failed to load data';
        _loading = false;
      });
    }
  }

  Future<void> addRestaurant(Map<String, dynamic> restaurant) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(restaurant),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Restaurant added successfully!')),
        );
        fetchRestaurants();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add restaurant: ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error submitting restaurant.')),
      );
    }
  }

  void showAddRestaurantForm() {
    showDialog(
      context: context,
      builder: (context) => AddRestaurantDialog(onSubmit: addRestaurant),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurants'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: showAddRestaurantForm,
          )
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text(_error!))
              : _restaurants.isEmpty
                  ? const Center(child: Text("No restaurants found."))
                  : RefreshIndicator(
                      onRefresh: fetchRestaurants,
                      child: ListView.builder(
                        itemCount: _restaurants.length,
                        itemBuilder: (context, index) {
                          final restaurant = _restaurants[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            child: ListTile(
                              title: Text(restaurant['name']),
                              subtitle: Text("Rating: ${restaurant['rating']}"),
                            ),
                          );
                        },
                      ),
                    ),
    );
  }
}

class AddRestaurantDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;

  const AddRestaurantDialog({super.key, required this.onSubmit});

  @override
  State<AddRestaurantDialog> createState() => _AddRestaurantDialogState();
}

class _AddRestaurantDialogState extends State<AddRestaurantDialog> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String address = '';
  String phoneNumber = '';
  double? rating;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Restaurant'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Name'),
              onSaved: (val) => name = val ?? '',
              validator: (val) => val!.isEmpty ? 'Required' : null,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Address'),
              onSaved: (val) => address = val ?? '',
              validator: (val) => val!.isEmpty ? 'Required' : null,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Phone Number'),
              onSaved: (val) => phoneNumber = val ?? '',
              validator: (val) => val!.isEmpty ? 'Required' : null,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Rating (0–5)'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSaved: (val) => rating = double.tryParse(val ?? '0'),
              validator: (val) {
                final r = double.tryParse(val ?? '');
                if (r == null || r < 0 || r > 5) return 'Enter valid rating (0–5)';
                return null;
              },
            ),
          ]),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel')),
        ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                final restaurant = {
                  "name": name,
                  "address": address,
                  "phone_number": phoneNumber,
                  "rating": rating
                };
                widget.onSubmit(restaurant);
                Navigator.pop(context);
              }
            },
            child: const Text('Submit'))
      ],
    );
  }
}
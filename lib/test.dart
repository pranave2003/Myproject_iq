import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myproject_iq/Custom_widget.dart';
import 'package:shimmer/shimmer.dart';

class TradeDropdown extends StatefulWidget {
  @override
  _TradeDropdownState createState() => _TradeDropdownState();
}

class _TradeDropdownState extends State<TradeDropdown> {
  String? _selectedTrade;
  String? _selectlocation;

  Stream<List<String>> _getDomainStream() {
    return FirebaseFirestore.instance.collection('DOMAIN').snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => doc['DOMAIN'] as String).toList());
  }

  Stream<List<String>> _getLocationStream() {
    return FirebaseFirestore.instance.collection('LOCATION').snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => doc['LOCATION'] as String).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder<List<String>>(
            stream: _getDomainStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(labelText: 'Select domain'),
                      items: [
                        DropdownMenuItem(
                          value: null,
                          child: Text('Loading...'),
                        ),
                      ],
                      onChanged: null,
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text("Error loading data");
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'Select domain'),
                  items: [
                    DropdownMenuItem(
                      value: null,
                      child: Text('No domain available'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedTrade = value;
                      print(_selectedTrade);
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Please select your trade' : null,
                );
              } else {
                final domains = snapshot.data!;
                return DropdownButtonFormField<String>(
                  value: _selectedTrade,
                  decoration: InputDecoration(labelText: 'Select domain'),
                  dropdownColor: Colors.grey[300], // Replace with `mycolor3`
                  items: domains
                      .map((trade) => DropdownMenuItem(
                            value: trade,
                            child: Text(
                              trade,
                              style: TextStyle(
                                  color:
                                      Colors.black), // Replace with `mycolor1`
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedTrade = value;
                      print(_selectedTrade);
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Please select your trade' : null,
                );
              }
            },
          ),
          StreamBuilder<List<String>>(
            stream: _getLocationStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(labelText: 'Select domain'),
                      items: [
                        DropdownMenuItem(
                          value: null,
                          child: Text('Loading...'),
                        ),
                      ],
                      onChanged: null,
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text("Error loading data");
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'Select Location'),
                  items: [
                    DropdownMenuItem(
                      value: null,
                      child: Text('No Location available'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectlocation = value;
                      print(_selectlocation);
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Please select your Location' : null,
                );
              } else {
                final domains = snapshot.data!;
                return DropdownButtonFormField<String>(
                  value: _selectlocation,
                  decoration: InputDecoration(labelText: 'Select Location'),
                  dropdownColor: mycolor2, // Replace with `mycolor3`
                  items: domains
                      .map((trade) => DropdownMenuItem(
                            value: trade,
                            child: Text(
                              trade,
                              style: TextStyle(
                                  color:
                                      Colors.black), // Replace with `mycolor1`
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectlocation = value;
                      print(_selectlocation);
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Please select your Location' : null,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

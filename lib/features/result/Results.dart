import 'package:ez_english/features/levels/data/upload_data_viewmodel.dart';
import 'package:ez_english/features/models/level.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class Results extends StatefulWidget {
  const Results({super.key});

  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  late UploadDataViewmodel _dataViewmodel;
  @override
  void initState() {
    _dataViewmodel = Provider.of<UploadDataViewmodel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              List<Level> levels = await _dataViewmodel.parseData();
              for (Level level in levels) {
                await _dataViewmodel.saveLevelToFirestore(level);
              }
            },
            child: const Text("Add data"),
          ),
          ElevatedButton(
            onPressed: () {
              context.push('/youtube');
            },
            child: const Text("To Youtube"),
          ),
          const Center(
            child: Text('Results'),
          ),
        ],
      ),
    );
  }
}

import 'package:bank_loan/features/clients_page/presentation/manger/clients_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientsPage extends StatelessWidget {
  const ClientsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClientsCubit, ClientsState>(
      builder: (context, state) {
        var cubit = context.read<ClientsCubit>();
        return Scaffold(
          appBar: AppBar(
            title: const Text('العملاء'),
          ),
          body: Column(
            children: [
              ElevatedButton(onPressed: () {
                cubit.createDataBase();
                }, child: Text('Create client')),
              ElevatedButton(onPressed: () {
                cubit.insertToDataBase(name: 'name', date: '2024-06-05');
                }, child: Text('Insert client')),  ElevatedButton(onPressed: () {
                cubit.deleteData(id: 3);
                }, child: Text('delete client')),
            ],
          ),
        );
      },
    );
  }
}

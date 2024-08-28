import 'package:flutter/material.dart';

import '../../manger/clients_cubit.dart';

class ClientsSearchBar extends StatelessWidget {
  const ClientsSearchBar({
    super.key,
    required this.cubit,
  });

  final ClientsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      leading: const Icon(
        Icons.search,
        color: Colors.grey,
      ),
      controller: cubit.searchController,
      hintText: 'ابحث عن زبون',
      hintStyle: const MaterialStatePropertyAll(
        TextStyle(height: -0.6, color: Colors.grey),
      ),
      onChanged: (val) {
        val.length > 0
            ? cubit.searchClient(name: val)
            : val.length == 0
            ? cubit.getClients()
            : null;
      },
    );
  }
}

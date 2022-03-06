import 'package:flutter/material.dart';
import 'package:local_farm_backstage/modules/service/model/service.dart';

class ServiceListTile extends StatelessWidget {
  const ServiceListTile({
    Key? key,
    required this.service,
    required this.onDelete,
    required this.onEdit,
  }) : super(key: key);
  final Service service;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(service.title),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}

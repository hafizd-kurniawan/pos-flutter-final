import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pos_responsive_app/core/constants/colors.dart';
import 'package:flutter_pos_responsive_app/data/models/response/outlet_response_model.dart';
import 'package:flutter_pos_responsive_app/presentation/outlet/bloc/outlet_bloc.dart';

class OutletPage extends StatefulWidget {
  const OutletPage({super.key});

  @override
  State<OutletPage> createState() => _OutletPageState();
}

class _OutletPageState extends State<OutletPage> {
  @override
  void initState() {
    super.initState();
    context.read<OutletBloc>().add(GetOutletsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Outlet Management'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _showAddOutletDialog(context);
            },
          ),
        ],
      ),
      body: BlocConsumer<OutletBloc, OutletState>(
        listener: (context, state) {
          if (state is OutletError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is OutletSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
            context.read<OutletBloc>().add(GetOutletsEvent());
          }
        },
        builder: (context, state) {
          if (state is OutletLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is OutletLoaded) {
            return _buildOutletList(state.outlets);
          } else if (state is OutletError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red[300],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${state.message}',
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<OutletBloc>().add(GetOutletsEvent());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          return const Center(child: Text('No data available'));
        },
      ),
    );
  }

  Widget _buildOutletList(List<Outlet> outlets) {
    if (outlets.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.store_outlined,
              size: 64,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              'No outlets found',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: outlets.length,
      itemBuilder: (context, index) {
        final outlet = outlets[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.primary,
              child: Icon(
                Icons.store,
                color: AppColors.white,
              ),
            ),
            title: Text(
              outlet.outletName ?? 'Unknown Outlet',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${outlet.branchType} - ${outlet.city}'),
                if (outlet.address != null) Text(outlet.address!),
                if (outlet.phoneNumber != null) Text(outlet.phoneNumber!),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: outlet.status == 'Aktif' ? Colors.green : Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        outlet.status ?? 'Unknown',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            trailing: PopupMenuButton(
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit),
                      SizedBox(width: 8),
                      Text('Edit'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete, color: Colors.red),
                      SizedBox(width: 8),
                      Text('Delete', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ],
              onSelected: (value) {
                if (value == 'edit') {
                  _showEditOutletDialog(context, outlet);
                } else if (value == 'delete') {
                  _showDeleteConfirmation(context, outlet);
                }
              },
            ),
          ),
        );
      },
    );
  }

  void _showAddOutletDialog(BuildContext context) {
    final nameController = TextEditingController();
    final branchTypeController = TextEditingController();
    final cityController = TextEditingController();
    final addressController = TextEditingController();
    final phoneController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Outlet'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Outlet Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: branchTypeController,
                decoration: const InputDecoration(
                  labelText: 'Branch Type',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: cityController,
                decoration: const InputDecoration(
                  labelText: 'City',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: addressController,
                decoration: const InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty &&
                  branchTypeController.text.isNotEmpty &&
                  cityController.text.isNotEmpty) {
                final data = {
                  'outlet_name': nameController.text,
                  'branch_type': branchTypeController.text,
                  'city': cityController.text,
                  'address': addressController.text,
                  'phone_number': phoneController.text,
                  'status': 'Aktif',
                };
                context.read<OutletBloc>().add(CreateOutletEvent(data));
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showEditOutletDialog(BuildContext context, Outlet outlet) {
    final nameController = TextEditingController(text: outlet.outletName);
    final branchTypeController = TextEditingController(text: outlet.branchType);
    final cityController = TextEditingController(text: outlet.city);
    final addressController = TextEditingController(text: outlet.address);
    final phoneController = TextEditingController(text: outlet.phoneNumber);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Outlet'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Outlet Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: branchTypeController,
                decoration: const InputDecoration(
                  labelText: 'Branch Type',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: cityController,
                decoration: const InputDecoration(
                  labelText: 'City',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: addressController,
                decoration: const InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty &&
                  branchTypeController.text.isNotEmpty &&
                  cityController.text.isNotEmpty) {
                final data = {
                  'outlet_name': nameController.text,
                  'branch_type': branchTypeController.text,
                  'city': cityController.text,
                  'address': addressController.text,
                  'phone_number': phoneController.text,
                  'status': outlet.status,
                };
                context.read<OutletBloc>().add(UpdateOutletEvent(outlet.outletId!, data));
                Navigator.pop(context);
              }
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, Outlet outlet) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Outlet'),
        content: Text('Are you sure you want to delete "${outlet.outletName}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<OutletBloc>().add(DeleteOutletEvent(outlet.outletId!));
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
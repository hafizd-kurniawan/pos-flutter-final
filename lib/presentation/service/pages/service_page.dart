import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pos_responsive_app/core/constants/colors.dart';
import 'package:flutter_pos_responsive_app/data/models/response/service_response_model.dart';
import 'package:flutter_pos_responsive_app/presentation/service/bloc/service_bloc.dart';
import 'package:intl/intl.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({super.key});

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  final TextEditingController _searchController = TextEditingController();
  int? selectedCategoryId;

  @override
  void initState() {
    super.initState();
    context.read<ServiceBloc>().add(GetServicesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Service Management'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _showAddServiceDialog(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search services...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          context.read<ServiceBloc>().add(GetServicesEvent());
                        },
                      ),
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        context.read<ServiceBloc>().add(SearchServicesEvent(value));
                      } else {
                        context.read<ServiceBloc>().add(GetServicesEvent());
                      }
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DropdownButton<int>(
                    value: selectedCategoryId,
                    hint: const Text('Category'),
                    underline: const SizedBox(),
                    items: const [
                      DropdownMenuItem(value: null, child: Text('All Categories')),
                      DropdownMenuItem(value: 1, child: Text('Maintenance')),
                      DropdownMenuItem(value: 2, child: Text('Engine Repair')),
                      DropdownMenuItem(value: 3, child: Text('Electrical')),
                      DropdownMenuItem(value: 4, child: Text('Body Work')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedCategoryId = value;
                      });
                      if (value == null) {
                        context.read<ServiceBloc>().add(GetServicesEvent());
                      } else {
                        context.read<ServiceBloc>().add(GetServicesByCategoryEvent(value));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocConsumer<ServiceBloc, ServiceState>(
              listener: (context, state) {
                if (state is ServiceError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else if (state is ServiceSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.green,
                    ),
                  );
                  context.read<ServiceBloc>().add(GetServicesEvent());
                }
              },
              builder: (context, state) {
                if (state is ServiceLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ServiceLoaded) {
                  return _buildServiceList(state.services);
                } else if (state is ServiceError) {
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
                            context.read<ServiceBloc>().add(GetServicesEvent());
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
          ),
        ],
      ),
    );
  }

  Widget _buildServiceList(List<Service> services) {
    if (services.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.miscellaneous_services_outlined,
              size: 64,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              'No services found',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.primary,
              child: Icon(
                Icons.build,
                color: AppColors.white,
              ),
            ),
            title: Text(
              service.name ?? 'Unknown Service',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Code: ${service.serviceCode ?? 'N/A'}'),
                Text('Category: ${service.serviceCategory?.name ?? 'N/A'}'),
                Text(
                  'Fee: Rp ${NumberFormat('#,##0').format(service.fee ?? 0)}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: service.status == 'Aktif' ? Colors.green : Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        service.status ?? 'Unknown',
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
                  _showEditServiceDialog(context, service);
                } else if (value == 'delete') {
                  _showDeleteConfirmation(context, service);
                }
              },
            ),
          ),
        );
      },
    );
  }

  void _showAddServiceDialog(BuildContext context) {
    final nameController = TextEditingController();
    final codeController = TextEditingController();
    final feeController = TextEditingController();
    int selectedCategory = 1;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Service'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Service Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: codeController,
                decoration: const InputDecoration(
                  labelText: 'Service Code',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: feeController,
                decoration: const InputDecoration(
                  labelText: 'Service Fee',
                  border: OutlineInputBorder(),
                  prefixText: 'Rp ',
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<int>(
                value: selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 1, child: Text('Maintenance Rutin')),
                  DropdownMenuItem(value: 2, child: Text('Perbaikan Mesin')),
                  DropdownMenuItem(value: 3, child: Text('Perbaikan Kelistrikan')),
                  DropdownMenuItem(value: 4, child: Text('Perbaikan Body')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    selectedCategory = value;
                  }
                },
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
                  codeController.text.isNotEmpty &&
                  feeController.text.isNotEmpty) {
                final data = {
                  'name': nameController.text,
                  'service_code': codeController.text,
                  'fee': double.tryParse(feeController.text) ?? 0,
                  'service_category_id': selectedCategory,
                  'status': 'Aktif',
                };
                context.read<ServiceBloc>().add(CreateServiceEvent(data));
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showEditServiceDialog(BuildContext context, Service service) {
    final nameController = TextEditingController(text: service.name);
    final codeController = TextEditingController(text: service.serviceCode);
    final feeController = TextEditingController(text: service.fee?.toString());
    int selectedCategory = service.serviceCategoryId ?? 1;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Service'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Service Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: codeController,
                decoration: const InputDecoration(
                  labelText: 'Service Code',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: feeController,
                decoration: const InputDecoration(
                  labelText: 'Service Fee',
                  border: OutlineInputBorder(),
                  prefixText: 'Rp ',
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<int>(
                value: selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 1, child: Text('Maintenance Rutin')),
                  DropdownMenuItem(value: 2, child: Text('Perbaikan Mesin')),
                  DropdownMenuItem(value: 3, child: Text('Perbaikan Kelistrikan')),
                  DropdownMenuItem(value: 4, child: Text('Perbaikan Body')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    selectedCategory = value;
                  }
                },
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
                  codeController.text.isNotEmpty &&
                  feeController.text.isNotEmpty) {
                final data = {
                  'name': nameController.text,
                  'service_code': codeController.text,
                  'fee': double.tryParse(feeController.text) ?? 0,
                  'service_category_id': selectedCategory,
                  'status': service.status,
                };
                context.read<ServiceBloc>().add(UpdateServiceEvent(service.serviceId!, data));
                Navigator.pop(context);
              }
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, Service service) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Service'),
        content: Text('Are you sure you want to delete "${service.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<ServiceBloc>().add(DeleteServiceEvent(service.serviceId!));
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
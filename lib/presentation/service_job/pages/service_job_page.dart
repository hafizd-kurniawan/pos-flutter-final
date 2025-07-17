import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pos_responsive_app/core/constants/colors.dart';
import 'package:flutter_pos_responsive_app/data/models/response/service_job_response_model.dart';
import 'package:flutter_pos_responsive_app/presentation/service_job/bloc/service_job_bloc.dart';
import 'package:intl/intl.dart';

class ServiceJobPage extends StatefulWidget {
  const ServiceJobPage({super.key});

  @override
  State<ServiceJobPage> createState() => _ServiceJobPageState();
}

class _ServiceJobPageState extends State<ServiceJobPage> {
  String? selectedStatus;
  final List<String> statusOptions = [
    'All',
    'Menunggu',
    'Dalam Proses',
    'Menunggu Sparepart',
    'Selesai',
    'Diambil'
  ];

  @override
  void initState() {
    super.initState();
    context.read<ServiceJobBloc>().add(GetServiceJobsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Service Jobs'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _showAddServiceJobDialog(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: DropdownButtonFormField<String>(
              value: selectedStatus,
              decoration: InputDecoration(
                labelText: 'Filter by Status',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.filter_list),
              ),
              items: statusOptions.map((status) {
                return DropdownMenuItem(
                  value: status,
                  child: Text(status),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedStatus = value;
                });
                if (value == null || value == 'All') {
                  context.read<ServiceJobBloc>().add(GetServiceJobsEvent());
                } else {
                  context.read<ServiceJobBloc>().add(GetServiceJobsByStatusEvent(value));
                }
              },
            ),
          ),
          Expanded(
            child: BlocConsumer<ServiceJobBloc, ServiceJobState>(
              listener: (context, state) {
                if (state is ServiceJobError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else if (state is ServiceJobSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.green,
                    ),
                  );
                  context.read<ServiceJobBloc>().add(GetServiceJobsEvent());
                }
              },
              builder: (context, state) {
                if (state is ServiceJobLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ServiceJobLoaded) {
                  return _buildServiceJobList(state.serviceJobs);
                } else if (state is ServiceJobError) {
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
                            context.read<ServiceJobBloc>().add(GetServiceJobsEvent());
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

  Widget _buildServiceJobList(List<ServiceJob> serviceJobs) {
    if (serviceJobs.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.build_outlined,
              size: 64,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              'No service jobs found',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: serviceJobs.length,
      itemBuilder: (context, index) {
        final serviceJob = serviceJobs[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ExpansionTile(
            leading: CircleAvatar(
              backgroundColor: _getStatusColor(serviceJob.status),
              child: Text(
                '#${serviceJob.queueNumber}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              serviceJob.serviceCode ?? 'Unknown Job',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Customer: ${serviceJob.customer?.name ?? 'Unknown'}'),
                Text('Vehicle: ${serviceJob.vehicle?.plateNumber ?? 'Unknown'}'),
                Text('Problem: ${serviceJob.problemDescription ?? 'N/A'}'),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getStatusColor(serviceJob.status),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        serviceJob.status ?? 'Unknown',
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
                  _showEditServiceJobDialog(context, serviceJob);
                } else if (value == 'delete') {
                  _showDeleteConfirmation(context, serviceJob);
                }
              },
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailSection('Customer Info', [
                      'Name: ${serviceJob.customer?.name ?? 'N/A'}',
                      'Phone: ${serviceJob.customer?.phoneNumber ?? 'N/A'}',
                      'Address: ${serviceJob.customer?.address ?? 'N/A'}',
                    ]),
                    const SizedBox(height: 16),
                    _buildDetailSection('Vehicle Info', [
                      'Plate: ${serviceJob.vehicle?.plateNumber ?? 'N/A'}',
                      'Brand: ${serviceJob.vehicle?.brand ?? 'N/A'} ${serviceJob.vehicle?.model ?? ''}',
                      'Type: ${serviceJob.vehicle?.type ?? 'N/A'}',
                      'Year: ${serviceJob.vehicle?.productionYear ?? 'N/A'}',
                      'Color: ${serviceJob.vehicle?.color ?? 'N/A'}',
                    ]),
                    const SizedBox(height: 16),
                    _buildDetailSection('Service Info', [
                      'Service In: ${serviceJob.serviceInDate != null ? DateFormat('dd/MM/yyyy HH:mm').format(serviceJob.serviceInDate!) : 'N/A'}',
                      'Technician: ${serviceJob.technician?.name ?? 'Not assigned'}',
                      'Notes: ${serviceJob.technicianNotes ?? 'No notes'}',
                      'Down Payment: Rp ${NumberFormat('#,##0').format(serviceJob.downPayment ?? 0)}',
                      'Total: Rp ${NumberFormat('#,##0').format(serviceJob.grandTotal ?? 0)}',
                    ]),
                    if (serviceJob.serviceDetails != null && serviceJob.serviceDetails!.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      const Text(
                        'Service Details:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      ...serviceJob.serviceDetails!.map((detail) => Card(
                        child: ListTile(
                          title: Text(detail.description ?? 'N/A'),
                          subtitle: Text(
                            'Qty: ${detail.quantity} x Rp ${NumberFormat('#,##0').format(detail.pricePerItem ?? 0)}'
                          ),
                          trailing: Text(
                            'Rp ${NumberFormat('#,##0').format((detail.quantity ?? 0) * (detail.pricePerItem ?? 0))}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      )).toList(),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailSection(String title, List<String> details) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        ...details.map((detail) => Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Text(detail),
        )).toList(),
      ],
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'menunggu':
        return Colors.orange;
      case 'dalam proses':
        return Colors.blue;
      case 'menunggu sparepart':
        return Colors.purple;
      case 'selesai':
        return Colors.green;
      case 'diambil':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  void _showAddServiceJobDialog(BuildContext context) {
    final problemController = TextEditingController();
    final notesController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Service Job'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: problemController,
                decoration: const InputDecoration(
                  labelText: 'Problem Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: notesController,
                decoration: const InputDecoration(
                  labelText: 'Technician Notes',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              const Text(
                'Note: Customer and vehicle selection would be implemented with proper dropdowns in a real app.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
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
              if (problemController.text.isNotEmpty) {
                final data = {
                  'customer_id': 1, // Dummy customer ID
                  'vehicle_id': 1,  // Dummy vehicle ID
                  'problem_description': problemController.text,
                  'technician_notes': notesController.text,
                  'status': 'Menunggu',
                };
                context.read<ServiceJobBloc>().add(CreateServiceJobEvent(data));
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showEditServiceJobDialog(BuildContext context, ServiceJob serviceJob) {
    final problemController = TextEditingController(text: serviceJob.problemDescription);
    final notesController = TextEditingController(text: serviceJob.technicianNotes);
    String selectedStatus = serviceJob.status ?? 'Menunggu';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Service Job'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: problemController,
                decoration: const InputDecoration(
                  labelText: 'Problem Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: notesController,
                decoration: const InputDecoration(
                  labelText: 'Technician Notes',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedStatus,
                decoration: const InputDecoration(
                  labelText: 'Status',
                  border: OutlineInputBorder(),
                ),
                items: statusOptions.where((s) => s != 'All').map((status) {
                  return DropdownMenuItem(
                    value: status,
                    child: Text(status),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    selectedStatus = value;
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
              if (problemController.text.isNotEmpty) {
                final data = {
                  'problem_description': problemController.text,
                  'technician_notes': notesController.text,
                  'status': selectedStatus,
                };
                context.read<ServiceJobBloc>().add(UpdateServiceJobEvent(serviceJob.serviceJobId!, data));
                Navigator.pop(context);
              }
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, ServiceJob serviceJob) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Service Job'),
        content: Text('Are you sure you want to delete service job "${serviceJob.serviceCode}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<ServiceJobBloc>().add(DeleteServiceJobEvent(serviceJob.serviceJobId!));
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
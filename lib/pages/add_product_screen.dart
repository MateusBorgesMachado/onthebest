import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _groupController = TextEditingController();
  final _subgroupController = TextEditingController();
  final _costController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _groupController.dispose();
    _subgroupController.dispose();
    _costController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    super.dispose();
  }

  void _saveProduct() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Produto salvo com sucesso!'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Novo Produto',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField(
                controller: _nameController,
                label: 'Nome do Produto',
                icon: Icons.shopping_bag_outlined,
                validatorMsg: 'Informe o nome do produto',
              ),
              const SizedBox(height: 16),

              _buildTextField(
                controller: _groupController,
                label: 'Grupo (Ex: Roupas)',
                icon: Icons.category_outlined,
                validatorMsg: 'Informe o grupo',
              ),
              const SizedBox(height: 16),

              _buildTextField(
                controller: _subgroupController,
                label: 'Subgrupo (Ex: Camisetas)',
                icon: Icons.subdirectory_arrow_right,
                validatorMsg: 'Informe o subgrupo',
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      controller: _costController,
                      label: 'Custo',
                      icon: Icons.attach_money,
                      isNumeric: true,
                      prefixText: 'R\$ ',
                      validatorMsg: 'Informe o custo',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField(
                      controller: _priceController,
                      label: 'Venda',
                      icon: Icons.sell_outlined,
                      isNumeric: true,
                      prefixText: 'R\$ ',
                      validatorMsg: 'Informe o valor',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              _buildTextField(
                controller: _stockController,
                label: 'Estoque Inicial',
                icon: Icons.inventory_2_outlined,
                isNumeric: true,
                suffixText: 'unid',
                validatorMsg: 'Informe a quantidade',
              ),

              const SizedBox(height: 32),

              ElevatedButton(
                onPressed: _saveProduct,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFCC00),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Salvar Produto',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String validatorMsg,
    bool isNumeric = false,
    String? prefixText,
    String? suffixText,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey[500]),
        prefixIcon: Icon(icon, color: Colors.grey[400]),
        prefixText: prefixText,
        prefixStyle: const TextStyle(color: Colors.white, fontSize: 16),
        suffixText: suffixText,
        suffixStyle: TextStyle(color: Colors.grey[400]),

        filled: true,
        fillColor: const Color(0xFF1E1E1E),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFFFCC00), width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validatorMsg;
        }
        return null;
      },
    );
  }
}

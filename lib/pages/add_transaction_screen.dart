import 'package:flutter/material.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  // Estado que controla se é Venda (true) ou Compra (false)
  bool _isSale = true;

  // Controladores de texto
  final _totalController = TextEditingController();
  final _quantityController = TextEditingController(text: '1');

  // Valores selecionados nos Dropdowns (Mockados visualmente)
  String? _selectedEntity;
  String? _selectedGroup;
  String? _selectedSubgroup;
  String? _selectedProduct;

  // Lista para simular os itens adicionados
  final List<Map<String, dynamic>> _addedItems = [];

  @override
  void dispose() {
    _totalController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  // Função apenas para simular a adição visual de um item na lista
  void _addMockItem() {
    if (_selectedProduct != null) {
      setState(() {
        _addedItems.add({
          'name': _selectedProduct,
          'group': '$_selectedGroup > $_selectedSubgroup',
          'quantity': _quantityController.text,
          'price': '45,00', // Valor fixo apenas para o mock visual
        });
        // Limpa os campos após adicionar
        _selectedProduct = null;
        _quantityController.text = '1';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Cores dinâmicas dependendo do tipo da transação
    final activeColor = _isSale
        ? Colors.greenAccent[400]!
        : Colors.redAccent[400]!;
    final entityLabel = _isSale ? 'Cliente' : 'Fornecedor';
    final entityIcon = _isSale
        ? Icons.person_outline
        : Icons.storefront_outlined;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Nova Transação',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. TOGGLE: Venda ou Compra
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF2A2A2A)),
              ),
              child: Row(
                children: [
                  _buildToggleButton(
                    title: 'Venda',
                    isActive: _isSale,
                    activeColor: Colors.greenAccent[400]!,
                    onTap: () => setState(() => _isSale = true),
                  ),
                  _buildToggleButton(
                    title: 'Compra',
                    isActive: !_isSale,
                    activeColor: Colors.redAccent[400]!,
                    onTap: () => setState(() => _isSale = false),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 2. DADOS PRINCIPAIS
            const Text(
              'Dados Principais',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            // Dropdown Cliente / Fornecedor dinâmico
            _buildDropdown(
              label: 'Selecionar $entityLabel',
              icon: entityIcon,
              value: _selectedEntity,
              items: _isSale
                  ? ['Rafael Mendes', 'Lucas Almeida', 'Thiago Costa']
                  : ['Atacadão Têxtil', 'Importadora Alfa', 'Fábrica de Fios'],
              onChanged: (val) => setState(() => _selectedEntity = val),
            ),
            const SizedBox(height: 16),

            // Valor Total Gasto
            _buildTextField(
              controller: _totalController,
              label: 'Valor Total',
              icon: Icons.attach_money,
              isNumeric: true,
              prefixText: 'R\$ ',
            ),
            const SizedBox(height: 24),
            const Divider(color: Color(0xFF2A2A2A), thickness: 1),
            const SizedBox(height: 16),

            // 3. ADICIONAR ITENS
            const Text(
              'Adicionar Item',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _buildDropdown(
                    label: 'Grupo',
                    icon: Icons.category_outlined,
                    value: _selectedGroup,
                    items: ['Roupas', 'Acessórios'],
                    onChanged: (val) => setState(() => _selectedGroup = val),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildDropdown(
                    label: 'Subgrupo',
                    icon: Icons.subdirectory_arrow_right,
                    value: _selectedSubgroup,
                    items: ['Camisetas', 'Calças', 'Jaquetas'],
                    onChanged: (val) => setState(() => _selectedSubgroup = val),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildDropdown(
              label: 'Produto',
              icon: Icons.shopping_bag_outlined,
              value: _selectedProduct,
              items: [
                'Camiseta Básica Preta',
                'Calça Sarja Caqui',
                'Jaqueta de Couro',
              ],
              onChanged: (val) => setState(() => _selectedProduct = val),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: _buildTextField(
                    controller: _quantityController,
                    label: 'Qtd',
                    icon: Icons.numbers,
                    isNumeric: true,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 3,
                  child: ElevatedButton.icon(
                    onPressed: _addMockItem,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E1E1E),
                      foregroundColor:
                          activeColor, // Cor dinâmica baseada no tipo
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: activeColor.withValues(alpha: 0.5)),
                      ),
                    ),
                    icon: const Icon(Icons.add_shopping_cart, size: 20),
                    label: const Text(
                      'Adicionar',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // 4. LISTA DE ITENS ADICIONADOS
            if (_addedItems.isNotEmpty) ...[
              const Text(
                'Itens na Transação',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _addedItems.length,
                itemBuilder: (context, index) {
                  final item = _addedItems[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1A1A),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFF2A2A2A)),
                    ),
                    child: ListTile(
                      title: Text(
                        item['name'],
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        item['group'],
                        style: TextStyle(color: Colors.grey[500], fontSize: 12),
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'R\$ ${item['price']}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Qtd: ${item['quantity']}',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],

            const SizedBox(height: 80), // Espaço para o botão inferior
          ],
        ),
      ),

      // Botão Flutuante de Salvar Fixo na parte inferior
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SizedBox(
          width: double.infinity,
          child: FloatingActionButton.extended(
            backgroundColor:
                activeColor, // Verde ou Vermelho dependendo do toggle
            foregroundColor: Colors
                .black, // Texto em preto para dar contraste nas cores claras
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.check),
            label: Text(
              'Salvar ${_isSale ? 'Venda' : 'Compra'}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

  // =========================================================
  // WIDGETS AUXILIARES
  // =========================================================

  // Widget para os botões do Toggle (Venda/Compra)
  Widget _buildToggleButton({
    required String title,
    required bool isActive,
    required Color activeColor,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: isActive
                ? activeColor.withValues(alpha: 0.15)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isActive ? activeColor : Colors.grey[600],
            ),
          ),
        ),
      ),
    );
  }

  // Widget para Dropdown padronizado
  Widget _buildDropdown({
    required String label,
    required IconData icon,
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      dropdownColor: const Color(0xFF2A2A2A),
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey[500]),
        prefixIcon: Icon(icon, color: Colors.grey[400]),
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
      ),
      items: items.map((String item) {
        return DropdownMenuItem(value: item, child: Text(item));
      }).toList(),
      onChanged: onChanged,
    );
  }

  // Widget para TextField padronizado
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isNumeric = false,
    String? prefixText,
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
      ),
    );
  }
}

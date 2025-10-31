import 'package:flutter/material.dart';

class FabBottomItem extends StatefulWidget {
  @override
  _FabBottomItemState createState() => _FabBottomItemState();
}

class _FabBottomItemState extends State<FabBottomItem>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0; // TAB selecionada
  bool _isExpanded = false; // Estado dos botões flutuantes

  late AnimationController _animationController;
  late Animation<double> _animation;

  final List<Map<String, dynamic>> _items = [
    {'icon': Icons.home, 'label': 'Home'},
    {'icon': Icons.search, 'label': 'Buscar'},
    {'icon': Icons.message, 'label': 'Mensagens'},
    {'icon': Icons.person, 'label': 'Perfil'},
  ];

  // =========================
  // FUNÇÕES DOS BOTÕES FLUTUANTES
  // =========================

  // Atualiza TAB para 10 quando o botão "Ligação" for clicado
  void _callPhone() {
    setState(() => _selectedIndex = 10);
  }

  // Atualiza TAB para 11 quando o botão "Email" for clicado
  void _sendEmail() {
    setState(() => _selectedIndex = 11);
  }

  // Atualiza TAB para 12 quando o botão "Outro" for clicado
  void _otherAction() {
    setState(() => _selectedIndex = 12);
  }

  // Inicializa controlador de animação
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Alterna a expansão do FAB (abre/fecha os botões flutuantes)
  void _toggleFab() {
    if (_isExpanded) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  // Atualiza a aba selecionada no BottomAppBar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "BottomAppBar with FAB",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Text("TAB: $_selectedIndex", style: TextStyle(fontSize: 24)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          // Botões flutuantes acima do FAB
          Positioned(
            bottom: 80,
            child: IgnorePointer(
              ignoring: !_isExpanded,
              child: Column(
                children: [
                  AnimatedScale(
                    scale: _isExpanded ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 200),
                    child: FloatingActionButton(
                      mini: true,
                      heroTag: 'btn1',
                      onPressed: _callPhone,
                      backgroundColor: Colors.white,
                      elevation: 6,
                      shape: const CircleBorder(),
                      child: const Icon(Icons.call, color: Colors.blue),
                    ),
                  ),
                  const SizedBox(height: 10),
                  AnimatedScale(
                    scale: _isExpanded ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 200),
                    child: FloatingActionButton(
                      mini: true,
                      heroTag: 'btn2',
                      onPressed: _sendEmail,
                      backgroundColor: Colors.white,
                      elevation: 6,
                      shape: const CircleBorder(),
                      child: const Icon(Icons.email, color: Colors.blue),
                    ),
                  ),
                  const SizedBox(height: 10),
                  AnimatedScale(
                    scale: _isExpanded ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 200),
                    child: FloatingActionButton(
                      mini: true,
                      heroTag: 'btn3',
                      onPressed: _otherAction,
                      backgroundColor: Colors.white,
                      elevation: 6,
                      shape: const CircleBorder(),
                      child: const Icon(Icons.star, color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // FAB principal
          Transform.translate(
            offset: Offset(0, -20),
            child: FloatingActionButton(
              onPressed: _toggleFab,
              backgroundColor: Colors.blue,
              shape: CircleBorder(),
              child: AnimatedRotation(
                turns: _isExpanded ? 0.125 : 0,
                duration: Duration(milliseconds: 250),
                child: Icon(Icons.add, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color.fromARGB(255, 235, 235, 235),
        shape: CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_items.length + 1, (index) {
              if (index == _items.length ~/ 2) return SizedBox(width: 50);
              int itemIndex = index > _items.length ~/ 2 ? index - 1 : index;
              return Expanded(
                child: InkWell(
                  onTap: () => _onItemTapped(itemIndex),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _items[itemIndex]['icon'],
                        color: _selectedIndex == itemIndex
                            ? Colors.blue
                            : Colors.grey,
                      ),
                      Text(
                        _items[itemIndex]['label'],
                        style: TextStyle(
                          color: _selectedIndex == itemIndex
                              ? Colors.blue
                              : Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: FabBottomItem()));

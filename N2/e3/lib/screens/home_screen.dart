import 'package:flutter/material.dart';
import 'package:agenda_eventos/data/initial_events.dart';
import 'package:agenda_eventos/models/event.dart';
import 'package:agenda_eventos/screens/lifecycle_screen.dart';
import 'package:agenda_eventos/screens/settings_screen.dart';
import 'package:agenda_eventos/screens/event_details_screen.dart';
import 'package:agenda_eventos/screens/entry_screen.dart';
import 'package:agenda_eventos/screens/new_event_screen.dart';
import 'package:agenda_eventos/widgets/event_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.name});

  final String name;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Event> events = createInitialEvents();
  String search = "";
  String selectedCategory = "Todos";
  bool onlyRegistered = false;
  bool notifications = true;
  bool compactMode = false;

  List<Event> get filteredEvents {
    final query = search.trim().toLowerCase();
    return events.where((event) {
      final matchesSearch =
          event.title.toLowerCase().contains(query) ||
          event.location.toLowerCase().contains(query);
      final matchesCategory =
          selectedCategory == "Todos" || event.category == selectedCategory;
      final matchesRegistration = !onlyRegistered || event.registered;
      return matchesSearch && matchesCategory && matchesRegistration;
    }).toList();
  }

  Future<void> openDetails(Event event) async {
    final deleteEvent = await Navigator.push<bool>(
      context,
      MaterialPageRoute<bool>(
        builder: (context) => EventDetailsScreen(event: event),
      ),
    );
    if (!mounted) return;
    setState(() {
      if (deleteEvent == true) events.remove(event);
    });
    if (deleteEvent == true) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("${event.title} excluído")));
    }
  }

  Future<void> addEvent() async {
    final event = await Navigator.push<Event>(
      context,
      MaterialPageRoute<Event>(builder: (context) => const NewEventScreen()),
    );
    if (!mounted || event == null) return;
    setState(() => events.add(event));
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("${event.title} cadastrado")));
  }

  Future<void> logout() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Sair da agenda?"),
        content: const Text("Os dados desta sessão serão descartados."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancelar"),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Sair"),
          ),
        ],
      ),
    );
    if (!mounted || confirm != true) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute<void>(builder: (context) => const EntryScreen()),
      (route) => false,
    );
  }

  Future<void> openSettings() async {
    final result = await Navigator.push<Map<String, bool>>(
      context,
      MaterialPageRoute<Map<String, bool>>(
        builder: (context) => SettingsScreen(
          notifications: notifications,
          compactMode: compactMode,
        ),
      ),
    );
    if (!mounted || result == null) return;
    setState(() {
      notifications = result['notificacoes']!;
      compactMode = result['modoCompacto']!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final visibleEvents = filteredEvents;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Agenda"),
        actions: [
          IconButton(
            tooltip: "Configurações",
            onPressed: openSettings,
            icon: const Icon(Icons.settings),
          ),
          IconButton(
            tooltip: "Ciclo de vida",
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (context) => const LifecycleScreen(),
              ),
            ),
            icon: const Icon(Icons.history),
          ),
          IconButton(
            tooltip: "Sair",
            onPressed: logout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Novo evento",
        onPressed: addEvent,
        child: const Icon(Icons.add),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 88),
        children: [
          Text("Olá, ${widget.name}!", style: const TextStyle(fontSize: 22)),
          Text("Notificações: ${notifications ? 'ativadas' : 'desativadas'}"),
          const SizedBox(height: 16),
          TextField(
            decoration: const InputDecoration(
              labelText: "Pesquisar por título ou local",
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: (value) => setState(() => search = value),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,

            children: categories.map((category) {
              return FilterChip(
                label: Text(category),
                selected: selectedCategory == category,
                onSelected: (_) => setState(() => selectedCategory = category),
              );
            }).toList(),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text("Mostrar somente minhas inscrições"),
            value: onlyRegistered,
            onChanged: (value) => setState(() => onlyRegistered = value),
          ),
          Text("${visibleEvents.length} evento(s) encontrado(s)"),
          const SizedBox(height: 12),
          if (visibleEvents.isEmpty)
            const Padding(
              padding: EdgeInsets.all(24),
              child: Text("Nenhum evento encontrado."),
            ),
          ...visibleEvents.map(
            (event) => EventCard(
              event: event,
              compact: compactMode,
              onDetails: () => openDetails(event),

              onRegistrationToggle: () =>
                  setState(() => event.registered = !event.registered),
            ),
          ),
        ],
      ),
    );
  }
}

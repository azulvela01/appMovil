import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth/auth_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Genshin Novatos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar sesión',
            onPressed: () {
              context.read<AuthBloc>().add(SignOutRequested());
            },
          ),
        ],
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthUnauthenticated) {
            // Volver al login automáticamente después de logout
            Navigator.pushReplacementNamed(context, '/login'); // o usa tu ruta
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                '¡Bienvenid@, aventur@!',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Aquí encontrarás guías para principiantes en Genshin Impact',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 40),

              // Tarjetas de ejemplo (puedes expandir con tu contenido)
              Card(
                child: ListTile(
                  leading: const Icon(Icons.person, color: Colors.amber, size: 40),
                  title: const Text('Personajes recomendados para novatos'),
                  subtitle: const Text('Conoce los mejores starters y cómo usarlos'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Navegar a pantalla de personajes
                  },
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.build, color: Colors.amber, size: 40),
                  title: const Text('Builds básicos'),
                  subtitle: const Text('Guías rápidas para armar tus personajes'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Navegar a builds
                  },
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.tips_and_updates, color: Colors.amber, size: 40),
                  title: const Text('Consejos para principiantes'),
                  subtitle: const Text('Errores comunes y cómo evitarlos'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Navegar a tips
                  },
                ),
              ),

              const Spacer(),

              // Información del usuario (opcional)
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthAuthenticated) {
                    return Center(
                      child: Text(
                        'Conectado como: ${state.user.email ?? "Usuario"}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
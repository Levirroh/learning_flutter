
import 'package:flutter/material.dart';
import 'package:items_supabase/pages/items_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final supabase = Supabase.instance.client;

  bool _isLogin = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _mostrarMensagem(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensagem)),
    );
  }

  bool _validarCampos() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      _mostrarMensagem('Preencha o e-mail e a senha.');
      return false;
    }

    if (!email.contains('@')) {
      _mostrarMensagem('Digite um e-mail válido.');
      return false;
    }

    return true;
  }

  void _abrirLista(String email) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) => ItemsPage(email: email),
      ),
    );
  }

  Future<void> _entrar() async {
    if (_isLoading || !_validarCampos()) return;

    final email = _emailController.text.trim();
    final password = _passwordController.text;

    setState(() => _isLoading = true);

    try {
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (!mounted) return;

      if (response.session != null) {
        _abrirLista(response.user?.email ?? email);
      } else {
        _mostrarMensagem('Não foi possível iniciar a sessão.');
      }
    } on AuthException catch (error) {
      if (!mounted) return;

      if (error.code == 'email_not_confirmed') {
        _mostrarMensagem('Confirme seu e-mail antes de entrar.');
      } else {
        _mostrarMensagem('Falha no login: ${error.message}');
      }
    } catch (error) {
      if (!mounted) return;
      _mostrarMensagem('Erro inesperado ao realizar login.');
      debugPrint('Erro de login: $error');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _signUp() async {
    if (_isLoading || !_validarCampos()) return;

    final email = _emailController.text.trim();
    final password = _passwordController.text;

    setState(() => _isLoading = true);

    try {
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
      );

      if (!mounted) return;

      if (response.session != null) {
        // Cadastro realizado com sessão ativa.
        _abrirLista(response.user?.email ?? email);
      } else {
        // Pode ser necessário confirmar o e-mail.
        _mostrarMensagem(
          'Verifique seu e-mail para confirmar o cadastro.',
        );

        _passwordController.clear();

        setState(() {
          _isLogin = true;
        });
      }
    } on AuthException catch (error) {
      if (!mounted) return;

      _mostrarMensagem('Falha no cadastro: ${error.message}');
    } catch (error) {
      if (!mounted) return;
      _mostrarMensagem('Erro inesperado ao criar conta.');
      debugPrint('Erro de cadastro: $error');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _alternarModo() {
    if (_isLoading) return;

    _passwordController.clear();

    setState(() {
      _isLogin = !_isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isLogin ? 'Entrar' : 'Criar conta'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: AutofillGroup(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.account_circle_outlined,
                      size: 72,
                    ),

                    const SizedBox(height: 16),

                    Text(
                      _isLogin ? 'Bem-vindo!' : 'Crie sua conta',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),

                    const SizedBox(height: 8),

                    Text(
                      _isLogin
                          ? 'Entre para acessar seus itens.'
                          : 'Cadastre-se para começar.',
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 32),

                    // E-mail
                    TextField(
                      controller: _emailController,
                      enabled: !_isLoading,
                      keyboardType: TextInputType.emailAddress,
                      textCapitalization: TextCapitalization.none,
                      textInputAction: TextInputAction.next,
                      autofillHints: const [AutofillHints.email],
                      autocorrect: false,
                      decoration: const InputDecoration(
                        labelText: 'E-mail',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                      onSubmitted: (_) {
                        FocusScope.of(context).nextFocus();
                      },
                    ),

                    const SizedBox(height: 20),

                    // Senha
                    TextField(
                      controller: _passwordController,
                      enabled: !_isLoading,
                      obscureText: true,
                      autocorrect: false,
                      enableSuggestions: false,
                      textInputAction: TextInputAction.done,
                      autofillHints: [
                        _isLogin
                            ? AutofillHints.password
                            : AutofillHints.newPassword,
                      ],
                      decoration: const InputDecoration(
                        labelText: 'Senha',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock_outline),
                      ),
                      onSubmitted: (_) {
                        if (_isLogin) {
                          _entrar();
                        } else {
                          _signUp();
                        }
                      },
                    ),

                    const SizedBox(height: 24),

                    // Botão principal
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: _isLoading
                            ? null
                            : (_isLogin ? _entrar : _signUp),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(
                                  _isLogin ? 'Entrar' : 'Criar conta',
                                ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Alternar entre login e cadastro
                    TextButton(
                      onPressed: _isLoading ? null : _alternarModo,
                      child: Text(
                        _isLogin
                            ? 'Não possui conta? Cadastre-se'
                            : 'Já possui uma conta? Entrar',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

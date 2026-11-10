# items_supabase

A new Flutter project.

comando para iniciar:

flutter run --dart-define-from-file=supabase_config.json

# Para depois:

Funções recomendadas:

 // Cadastro
await supabase.auth.signUp(
  email: email,
  password: password,
);

// Login
await supabase.auth.signInWithPassword(
  email: email,
  password: password,
);

// Logout
await supabase.auth.signOut();


---

Identificar usuário conectado:

final user = supabase.auth.currentUser;


---


CRUD Básico:

SELECT:

final items = await supabase
    .from('items')
    .select('id, name, user_id, created_at')
    .order('created_at', ascending: false);
  

INSERT:

final user = supabase.auth.currentUser!;

await supabase.from('items').insert({
  'name': name,
  'user_id': user.id,
});
  
UPDATE:

await supabase
    .from('items')
    .update({'name': newName})
    .eq('id', itemId);

DELETE:


await supabase
    .from('items')
    .delete()
    .eq('id', itemId);

---

# Sujestão de páginas:

main.dart
Inicialização do Flutter e Supabase

app.dart
Configuração do aplicativo

pages/login_page.dart
Interface de login e autenticação

pages/items_page.dart
Listagem e interação com os itens

services/item_service.dart
Operações SELECT, INSERT, UPDATE e DELETE

models/item.dart
Representação de um item em Dart

## Observações:

Durante as operações assíncronas, exiba carregamento; em caso de sucesso, atualize os dados; em caso de erro, apresente uma mensagem útil. Após um await, verifique mounted antes de utilizar setState ou context, quando aplicável

*Mensagem* do slide 27
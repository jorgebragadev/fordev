Feature: Login 
Como um cliente
Quero poder acessar minha conta e me manter logado
Para que eu possa ver e responder enquetes de forma rápida

Cenário: Crendenciais Válidas
Dado que o cliente informou as Credenciais Válidas
Quando solicitar para fazer o Login
Então o sistema deve enviar o usuário para a tela de pesquisa
E manter o usuário conectado

Cenário: Crendenciais Inválidos
Dado que o cliente informou as Credenciais inválidas
Quando solicitar para fazer o Login
Então o sistema deve retornar uma mensagem de erro
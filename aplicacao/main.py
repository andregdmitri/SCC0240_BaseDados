from dotenv import load_dotenv
import os
import questionary
from questionary import Choice, Separator
import oracledb

from db_actions import *

# Menu principal
def main_menu(connection: oracledb.Connection):

    os.system("cls||clear")

    questionary.print("Bem-vindo ao sistema de gerenciamento do aplicativo de ensino!\n", style="bold italic")

    # Pergunta ao usuário qual ação ele deseja realizar
    option = questionary.select(
        "O que você deseja fazer?",
        choices=[
            Choice(title="Cadastrar um novo cliente", value=1),
            Choice(title="Cadastrar um novo voluntário", value=2),
            Choice(title="Cadastrar um novo administrador", value=3),
            Choice(title="Consulta de clientes (Dados, Módulos Cursados, Aprovações e Reprovações)", value=4),
            Separator(),
            Choice(title="Sair do sistema", value=5, shortcut_key="q")
        ],
        instruction="Use as setas para navegar",
        use_shortcuts=True
    ).ask(kbi_msg="")

    print()

    # Chama a função correspondente à opção selecionada
    if option == 1:
        register_client(connection)
    elif option == 2:
        register_volunteer(connection)
    elif option == 3:
        register_admin(connection)
    elif option == 4:
        query_clients(connection)
    elif option == 5 or option == None:
        questionary.print("Saindo do sistema...", style="bold italic")
        return

    # Volta para o menu principal
    main_menu(connection)

# === PROGRAMA PRINCIPAL ===

# Carrega as variáveis de ambiente
load_dotenv()
db_user = os.getenv("DB_USER")
db_password = os.getenv("DB_PASSWORD")
db_host = os.getenv("DB_HOST")
db_port = os.getenv("DB_PORT")
db_service = os.getenv("DB_SERVICE")

# Cria uma conexão com o banco de dados
try:

    questionary.print("Conectando ao banco de dados...", style="bold italic")
    with oracledb.connect(user=db_user, password=db_password, host=db_host, port=db_port, service_name=db_service) as connection:
        # Inicia o fluxo de execução
        main_menu(connection)

except oracledb.DatabaseError as e:
    questionary.print("Erro ao conectar ao banco de dados!", style="bold fg:red")
    questionary.print(e.args[0].message, style="bold italic fg:red")
    exit()
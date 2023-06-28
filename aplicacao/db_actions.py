import questionary
from questionary import Choice
import oracledb

from validators import *

# Cadastra um novo cliente
def register_client(connection: oracledb.Connection):

        questionary.print("Cadastro de cliente - insira os dados:\n", style="bold italic")

        # Pergunta ao usuário os dados do cliente
        client_data = questionary.form(
            email = questionary.text("Qual o e-mail do cliente?", validate=email_validator),

            username = questionary.text("Qual o nome de usuário do cliente?", validate=username_validator),

            passw = questionary.password("Qual a senha do cliente?", validate=password_validator),

            name = questionary.text("Qual o nome do cliente?", validate=name_validator),

            birth_date = questionary.text("Qual a data de nascimento do cliente?", validate=birth_date_validator),

            kw_level = questionary.select(
                "Qual o nível de conhecimento do cliente?",
                choices=["Basico", "Intermediario", "Avancado"],
                instruction="Use as setas para navegar"
            ),

            needs_help = questionary.confirm(message="O cliente precisa de atendimento?"),
        ).ask()

        client_data["needs_help"] = 1 if client_data["needs_help"] else 0
    
        # Cria um cursor para executar comandos SQL
        # (Implicitamente abre uma transação)
        cursor = connection.cursor()
    
        # Executa o comando SQL
        try:
            cursor.execute(
                """
                INSERT INTO Cliente (Email, Username, Senha, Nome, Data_Nascimento, Nivel_Conhecimento, Precisa_De_Atendimento)
                VALUES (:email, :username, :passw, :name, TO_DATE(:birth_date, 'DD/MM/YYYY'), :kw_level, :needs_help)
                """,
                client_data
            )
        except oracledb.DatabaseError as e:
            # Mostra mensagem de erro
            questionary.print("\nErro ao cadastrar cliente!", style="bold fg:red")
            questionary.print(e.args[0].message, style="bold fg:red")
            questionary.print("Pressione ENTER para continuar...", style="italic")
            input()
    
            # Volta para o menu principal
            return
    
        # Confirma a transação
        connection.commit()
    
        # Fecha o cursor
        cursor.close()
    
        # Mostra mensagem de sucesso
        questionary.print("\nCliente cadastrado com sucesso!", style="bold fg:green")
        questionary.print("Pressione ENTER para continuar...", style="italic")
        input()
    
        # Volta para o menu principal
        return

# Cadastra um novo voluntário
def register_volunteer(connection: oracledb.Connection):
    questionary.print("Cadastro de voluntário - insira os dados:\n", style="bold italic")

    # Pergunta ao usuário os dados do voluntário
    volunteer_data = questionary.form(
        email = questionary.text("Qual o e-mail do voluntário?", validate=email_validator),

        username = questionary.text("Qual o nome de usuário do voluntário?", validate=username_validator),

        passw = questionary.password("Qual a senha do voluntário?", validate=password_validator),

        name = questionary.text("Qual o nome do voluntário?", validate=name_validator),

        birth_date = questionary.text("Qual a data de nascimento do voluntário?", validate=birth_date_validator),
    ).ask()
    
    # Cria um cursor para executar comandos SQL
    # (Implicitamente abre uma transação)
    cursor = connection.cursor()
    
    # Executa o comando SQL
    try:
        cursor.execute(
            """
            INSERT INTO Voluntario (Email, Username, Senha, Nome, Data_Nascimento)
            VALUES (:email, :username, :passw, :name, TO_DATE(:birth_date, 'DD/MM/YYYY'))
            """,
            volunteer_data
        )
    except oracledb.DatabaseError as e:
        # Mostra mensagem de erro
        questionary.print("\nErro ao cadastrar voluntário!", style="bold fg:red")
        questionary.print(e.args[0].message, style="bold fg:red")
        questionary.print("Pressione ENTER para continuar...", style="italic")
        input()
    
        # Volta para o menu principal
        return
    
    # Confirma a transação
    connection.commit()
    
    # Fecha o cursor
    cursor.close()
    
    # Mostra mensagem de sucesso
    questionary.print("\nCliente cadastrado com voluntário!", style="bold fg:green")
    questionary.print("Pressione ENTER para continuar...", style="italic")
    input()
    
    # Volta para o menu principal
    return

# Cadastra um novo administrador
def register_admin(connection: oracledb.Connection):
    questionary.print("Cadastro de administrador - insira os dados:\n", style="bold italic")

    # Pergunta ao usuário os dados do admin
    admin_data = questionary.form(
        email = questionary.text("Qual o e-mail do administrador?", validate=email_validator),

        username = questionary.text("Qual o nome de usuário do administrador?", validate=username_validator),

        passw = questionary.password("Qual a senha do administrador?", validate=password_validator),

        name = questionary.text("Qual o nome do administrador?", validate=name_validator),

        birth_date = questionary.text("Qual a data de nascimento do administrador?", validate=birth_date_validator),
    ).ask()

    # Cria um cursor para executar comandos SQL
    # (Implicitamente abre uma transação)
    cursor = connection.cursor()

    # Executa o comando SQL
    try:
        cursor.execute(
            """
            INSERT INTO Administrador (Email, Username, Senha, Nome, Data_Nascimento)
            VALUES (:email, :username, :passw, :name, TO_DATE(:birth_date, 'DD/MM/YYYY'))
            """,
            admin_data
        )
    except oracledb.DatabaseError as e:
        # Mostra mensagem de erro
        questionary.print("\nErro ao cadastrar administrador!", style="bold fg:red")
        questionary.print(e.args[0].message, style="bold fg:red")
        questionary.print("Pressione ENTER para continuar...", style="italic")
        input()

        # Volta para o menu principal
        return

    # Confirma a transação
    connection.commit()

    # Fecha o cursor
    cursor.close()

    # Mostra mensagem de sucesso
    questionary.print("\nAministrador cadastrado com sucesso!", style="bold fg:green")
    questionary.print("Pressione ENTER para continuar...", style="italic")
    input()

    # Volta para o menu principal
    return

# TODO: Consulta 1
def query_1(connection: oracledb.Connection):
    questionary.print("Ainda não implementado!", style="bold fg:red")
    questionary.print("Pressione ENTER para continuar...", style="italic")
    input()

# TODO: Consulta 2
def query_2(connection: oracledb.Connection):
    questionary.print("Ainda não implementado!", style="bold fg:red")
    questionary.print("Pressione ENTER para continuar...", style="italic")
    input()
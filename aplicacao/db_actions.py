import questionary
from questionary import Choice
import oracledb
import tabulate

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

def query_clients(connection: oracledb.Connection):
    questionary.print("Consulta de clientes:\n", style="bold italic")

    # Pergunta ao usuário os parâmetros da consulta
    questionary.print("Parâmetros da consulta:", style="italic")
    query_params = questionary.form(
        kw_level = questionary.checkbox(
            "Nível de conhecimento:",
            choices=["Basico", "Intermediario", "Avancado"],
            validate=knowledge_level_checkbox_validator,
        ),

        needs_help = questionary.select(
            "Precisa de atendimento?",
            choices=["Ambos", "Sim", "Não"],
            default="Ambos",
            instruction="Use as setas para navegar"
        ),

        name = questionary.text("Pesquisa por nome (vazio para todos):", validate=name_search_validator),
    ).ask()
    order_by = questionary.select(
        "Como você deseja ordenar os resultados?",
        choices=[
            Choice(title="Nome", value="Nome"),
            Choice(title="Username", value="Username"),
            Choice(title="Módulos Cursados", value="Modulos_Cursados"),
            Choice(title="Aprovações", value="Aprovacoes"),
            Choice(title="Reprovações", value="Reprovacoes"),
        ],
        instruction="Use as setas para navegar",
    ).ask()

    order_dir = "ASC" if order_by == "Nome" or order_by == "Username" else "DESC"

    # Formata os parâmetros da consulta
    query_params["needs_help"] = [1] if query_params["needs_help"] == "Sim" else [0] if query_params["needs_help"] == "Não" else [0, 1]

    # Monta o comando SQL
    kw_level_vars = ",".join([":kw_level" + str(i) for i in range(len(query_params["kw_level"]))])
    needs_help_vars = ",".join([":needs_help" + str(i) for i in range(len(query_params["needs_help"]))])
    query = (
    f"""
    SELECT C.Nome, C.Username, C.Data_Nascimento, C.Nivel_Conhecimento, C.Precisa_De_Atendimento,
    COUNT(M.Modulo_Tema) as Modulos_Cursados,
    COUNT(CASE WHEN R.Aprovacao = 1 THEN 1 END) as Aprovacoes,
    COUNT(CASE WHEN R.Aprovacao = 0 THEN 1 END) as Reprovacoes
        FROM (Cliente C 
            LEFT JOIN Cursa M ON C.Email = M.Cliente_Email
            LEFT JOIN Teste T ON M.Modulo_Tema = T.Modulo_Tema
            LEFT JOIN Resultado R ON (
                C.Email = R.Cliente_Email
                AND
                T.Modulo_Tema = R.Teste_Tema
                AND
                T.Numero = R.Teste_Numero ))
        WHERE
            C.Nivel_Conhecimento IN ({kw_level_vars})
            AND
            C.Precisa_De_Atendimento IN ({needs_help_vars})
            AND
            C.Nome LIKE '%' || :name || '%'
        GROUP BY C.Nome, C.Username, C.Data_Nascimento, C.Nivel_Conhecimento, C.Precisa_De_Atendimento
        ORDER BY {order_by} {order_dir}
    """
    )

    # Cria as variáveis de ligação para o comando SQL
    for i in range(len(query_params["kw_level"])):
        query_params["kw_level" + str(i)] = query_params["kw_level"][i]
    del query_params["kw_level"]
    
    for i in range(len(query_params["needs_help"])):
        query_params["needs_help" + str(i)] = query_params["needs_help"][i]
    del query_params["needs_help"]

    # Cria um cursor para executar comandos SQL
    cursor = connection.cursor()

    # Executa o comando SQL
    try:
        cursor.execute(query, query_params)
    except oracledb.DatabaseError as e:
        # Mostra mensagem de erro
        questionary.print("\nErro ao consultar clientes!", style="bold fg:red")
        questionary.print(e.args[0].message, style="bold fg:red")
        questionary.print("Pressione ENTER para continuar...", style="italic")
        input()

        # Volta para o menu principal
        return

    # Mostra os resultados
    table = [
        ["Nome", "Username", "Data de Nasc.", "N. Conhecimento", "Atendimento?", "Módulos Cursados", "Aprovações", "Reprovações"]
    ]
    for row in cursor:
        table.append(
            [row[0], row[1], row[2].strftime("%d/%m/%Y"), row[3], "Sim" if row[4] == 1 else "Não", row[5], row[6], row[7]]
        )

    questionary.print("\nResultados da consulta:", style="italic")
    questionary.print(tabulate.tabulate(table, tablefmt="fancy_grid"), style="bold")

    # Fecha o cursor
    cursor.close()

    # Mostra mensagem de sucesso
    questionary.print("\nConsulta realizada com sucesso!", style="bold fg:green")
    questionary.print("Pressione ENTER para continuar...", style="italic")
    input()

    # Volta para o menu principal
    return
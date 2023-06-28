from questionary import ValidationError
import re
import datetime

def email_validator(email):
    if len(email) > 50:
        return "O e-mail deve ter no máximo 32 caracteres."
    if not re.match(r"[^@]+@[^@]+\.[^@]+", email):
        return "O e-mail deve ser válido."

    return True

def username_validator(username):
    if len(username) > 32:
        return "O nome de usuário deve ter no máximo 32 caracteres."
    if not re.match(r"^[a-zA-Z0-9_]+$", username):
        return "O nome de usuário deve conter apenas letras, números e _."

    return True

def password_validator(password):
    if len(password) > 32:
        return "A senha deve ter no máximo 32 caracteres."
    if not re.match(r"^[a-zA-Z0-9_]+$", password):
        return "A senha deve conter apenas letras, números e _."

    return True

def name_validator(name):
    if len(name) > 32:
        return "O nome deve ter no máximo 32 caracteres."
    if not re.match(r"^[a-zA-Z0-9_ ]+$", name):
        return "O nome deve conter apenas letras, números, _ e espaços."

    return True

def birth_date_validator(birth_date):
    try:
        date = datetime.datetime.strptime(birth_date, "%d/%m/%Y")
        if date > datetime.datetime.now():
            return "A data de nascimento deve ser anterior à data atual."
    except ValueError:
        return "A data de nascimento deve estar no formato DD/MM/YYYY."

    return True
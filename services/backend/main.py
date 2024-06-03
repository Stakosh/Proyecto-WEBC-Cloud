################ importacion librerias #####################
import time
import bcrypt
import jwt
from datetime import datetime, timedelta
from models import db
from config import app
from flask import request, jsonify
from models import CREDENCIAL
from flask_cors import CORS

CORS(app)


################ generacion token #####################
def generate_token(user_id):
    payload = {
        'exp': datetime.utcnow() + timedelta(days=1),  # Token expira en 1 día
        'iat': datetime.utcnow(),
        'sub': user_id
    }
    return jwt.encode(payload, app.config['SECRET_KEY'], algorithm='HS256')

def token_required(f):
    def decorator(*args, **kwargs):
        token = None
        if 'Authorization' in request.headers:
            token = request.headers['Authorization'].split(" ")[1]
        if not token:
            return jsonify({"message": "Token is missing"}), 403
        try:
            data = jwt.decode(token, app.config['SECRET_KEY'], algorithms=['HS256'])
            current_user = CREDENCIAL.query.get(data['sub'])
        except:
            return jsonify({"message": "Token is invalid"}), 403
        return f(current_user, *args, **kwargs)
    decorator.__name__ = f.__name__
    return decorator
################ fin generacion token #####################





################ RUTAS #####################
@app.route("/users", methods=["GET"])
@token_required
def get_university_credentials(current_user):
    alumnos = CREDENCIAL.query.all()
    json_alumnos = list(map(lambda x: x.to_json(), alumnos))
    return jsonify({"alumnos": json_alumnos}), 200

@app.route("/", methods=["POST"])
def login():
    email = request.json.get("email")
    password = request.json.get("password")

    if not email or not password:
        return jsonify({"message": "Por favor, rellene todos los campos"}), 400

    alumno = CREDENCIAL.query.filter_by(email=email).first()

    if alumno and bcrypt.checkpw(password.encode('utf-8'), alumno.password.encode('utf-8')):
        token = generate_token(alumno.id)
        return jsonify({"message": "Inicio de sesión exitoso", "token": token}), 200
    else:
        return jsonify({"message": "Credenciales inválidas"}), 401

@app.route("/create_contact", methods=["POST"])
@token_required
def create_CREDENCIAL(current_user):
    student_id = request.json.get("studentId")
    first_name = request.json.get("firstName")
    last_name = request.json.get("lastName")
    email = request.json.get("email")
    password = request.json.get("password")
    tipo_acceso = request.json.get("tipoAcceso")

    if not student_id or not first_name or not last_name or not email or not password or not tipo_acceso:
        return jsonify({"message": "Rellenar todos los campos, por favor"}), 400

    hashed_password = bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt()).decode('utf-8')
    new_alumno = CREDENCIAL(
        student_id=student_id, 
        first_name=first_name, 
        last_name=last_name, 
        email=email, 
        password=hashed_password,
        tipo_acceso=tipo_acceso
    )

    try:
        db.session.add(new_alumno)
        db.session.commit()
    except Exception as e:
        return jsonify({"message": str(e)}), 400

    return jsonify({"message": "Usuario creado exitosamente"}), 201

@app.route("/update_contact/<int:user_id>", methods=["PATCH"])
@token_required
def update_CREDENCIAL(current_user, user_id):
    alumno = CREDENCIAL.query.get(user_id)

    if not alumno:
        return jsonify({"message": "Usuario no encontrado"}), 404

    data = request.json
    alumno.student_id = data.get("studentId", alumno.student_id)
    alumno.first_name = data.get("firstName", alumno.first_name)
    alumno.last_name = data.get("lastName", alumno.last_name)
    alumno.email = data.get("email", alumno.email)
    if "password" in data:
        alumno.password = bcrypt.hashpw(data["password"].encode('utf-8'), bcrypt.gensalt()).decode('utf-8')
    if "tipoAcceso" in data:
        alumno.tipo_acceso = data["tipoAcceso"]

    db.session.commit()

    return jsonify({"message": "Usuario modificado exitosamente"}), 200

################ FIN RUTAS #####################

def initialize_default_user():
    if not CREDENCIAL.query.first():
        hashed_password = bcrypt.hashpw('queso'.encode('utf-8'), bcrypt.gensalt()).decode('utf-8')
        default_user = CREDENCIAL(
            student_id='20.723.182-7',
            first_name='Javiera',
            last_name='Soto',
            email='queso@queso.cl',
            password=hashed_password,
            tipo_acceso='admin'
        )
        db.session.add(default_user)
        db.session.commit()
        print("Usuario por defecto creado.")

if __name__ == "__main__":
    with app.app_context():
        time.sleep(8)
        db.create_all()
        initialize_default_user()
        app.run(debug=True, host='0.0.0.0')

from flask import Flask, request, jsonify
from flask_cors import CORS

app = Flask(__name__)
CORS(app)


def init_db():
    with sqlite3.connect("UniTrade.db") as conn:
        cursor = conn.cursor()
        cursor.execute('''create table if not exists users(
                        user_id int primary key,
                        username varchar(40) not null,
                        mail_id varchar(40) unique,
                        phone_no int unique,
                        password varchar(40) not null,
                        logged bool default False
                        );''')
        cursor.execute('''create table categories(
                        cat_id int primary key,
                        cat_name varchar(30) not null
                        )''')
        cursor.execute('''insert into categories
                        values
                        (101, "Books"),
                        (102, "Electronics"),
                        (103, "Lab Instruments"),
                        (104, "Uniform"),
                        (105, "Others")''')
        cursor.execute('''create table products(
                        prod_id int primary key,
                        prod_name varchar(40) not null,
                        cat_id int not null,
                        owner_id int not null,
                        prod_img blob not null,
                        price int not null,
                        company varchar(40) not null,
                        mfg_date date not null,
                        exp_date date,
                        specification varchar(8000),
                        prod_status varchar(30) check (prod_status in ("uploaded","requested","sold")),
                        foreign key(cat_id) references categories(cat_id),
                        foreign key(owner_id) references users(user_id)
                        );''')
        cursor.execute('''create table orders(
                        order_id int primary key,
                        seller_id int not null,
                        buyer_id int not null,
                        prod_id int not null,
                        purchase_date date not null,
                        status varchar(30)
                        );''')
        conn.commit()


@app.route('/api/login', methods=['POST'])
def login():
    data = request.json
    email = data.get('email')
    password = data.get('password')
    query = "Select * from users where email = ? and password = ?"
    params = (email,password,)
    with sqlite3.connect("UniTrade.db") as conn:
        cursor = conn.cursor()
        cursor.execute(query, params)
        items = cursor.fetchall()
    return jsonify(items)

@app.route("/api/register", methods=["POST"])
def register():
    data = request.json
    with sqlite3.connect("UniTrade.db") as conn:
        cursor = conn.cursor()
        try:
            cursor.execute("INSERT INTO users (username, email_ID, passowrd) VALUES (?, ?, ?)", (data["username"], data["email_ID"], data["password"]))
            conn.commit()
            return jsonify({"message": "User registered successfully"}), 201
        except sqlite3.IntegrityError:
            return jsonify({"error": "Email already exists"}), 400

@app.route("/api/categories", methods=["GET"])
def get_items():
    query = "SELECT * FROM categories"
    with sqlite3.connect("UniTrade.db") as conn:
        cursor = conn.cursor()
        cursor.execute(query)
        items = cursor.fetchall()
    return jsonify(items)

@app.route("/api/products", methods=["GET"])
def get_items():
    category = request.args.get("category")
    query = "SELECT * FROM products"
    params = ()
    if category:
        query += " WHERE category = ?"
        params = (category,)
    with sqlite3.connect("UniTrade.db") as conn:
        cursor = conn.cursor()
        cursor.execute(query, params)
        items = cursor.fetchall()
    return jsonify(items)

@app.route("/api/addProduct", methods=["POST"])
def add_item():
    data = request.json
    with sqlite3.connect("UniTrade.db") as conn:
        cursor = conn.cursor()
        cursor.execute("Select cat_ID from categories where cat_name = ?",data['category'])
        cat_ID = cursor.fetchall()
    with sqlite3.connect("UniTrade.db") as conn:
        cursor = conn.cursor()
        cursor.execute("INSERT INTO products (prod_name, cat_ID, owner_ID, prod_img, price, specification) VALUES (?, ?, ?, ?, ?, ?)", 
                       (data["prod_name"], cat_ID,  data["user_ID"], data["prod_img"], data["price"],data["specification"))
        conn.commit()
        return jsonify({"message": "Product added successfully"}), 201
    
if __name__ == '__main__':
    app.run(debug=True)

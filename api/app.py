from flask import Flask, render_template

app = Flask(__name__)

esculturas = [
    {'id': 1, 'nome': 'Escultura do Pensador', 'preco': 150, 'imagem': '/static/images/pensadorclay.webp'},
    {'id': 2, 'nome': 'Escultura de Hades', 'preco': 200, 'imagem': '/static/images/hadesclay.webp'}
]

@app.route('/')
def index():
    
    return render_template('index.html', esculturas=esculturas)

if __name__ == '__main__':
    app.run(debug=True)

from flask import Flask, render_template

app = Flask(__name__)

esculturas = [
    {'id': 1, 'nome': 'Escultura do Pensador', 'preco': 150, 'imagem': '/static/images/pensadorclay.webp'},
    {'id': 2, 'nome': 'Escultura de Hades', 'preco': 200, 'imagem': '/static/images/hadesclay.webp'},
    {'id': 3, 'nome': 'Escultura de Pensadora', 'preco': 200, 'imagem': '/static/images/hadesclay.webp'},
    {'id': 4, 'nome': 'Escultura de Pensadora 2', 'preco': 200, 'imagem': '/static/images/hadesclay.webp'},
    {'id': 5, 'nome': 'Escultura de Pensadora 5', 'preco': 200, 'imagem': '/static/images/hadesclay.webp'},
    {'id': 6, 'nome': 'Escultura de Pensadora 6', 'preco': 200, 'imagem': '/static/images/hadesclay.webp'}

]

@app.route('/')
def index():
    
    return render_template('index.html', esculturas=esculturas)

if __name__ == '__main__':
    app.run(debug=True)

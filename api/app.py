from flask import Flask, render_template

app = Flask(__name__)

esculturas = [
    {'id': 1, 'nome': 'Escultura do Pensador', 'preco': 150, 'imagem': '/static/images/pensadorclay.webp'},
    {'id': 2, 'nome': 'Escultura de Hades', 'preco': 200, 'imagem': '/static/images/hadesclay.webp'},
    {'id': 3, 'nome': 'Escultura de Homem', 'preco': 200, 'imagem': '/static/images/4003925b3b7564fa9d6b29423e6dbc1b.jpg'},
    {'id': 4, 'nome': 'Escultura de Gato', 'preco': 200, 'imagem': '/static/images/b2bc114a9a17c5f0f080d8d165f13afa.jpg'},
    {'id': 5, 'nome': 'Escultura de Palhaço', 'preco': 200, 'imagem': '/static/images/oil-based-sulfur-free.webp'},
    {'id': 6, 'nome': 'Escultura de Acorrentado', 'preco': 200, 'imagem': '/static/images/pow8.jpg'}
]

@app.route('/')
def index():
    return render_template('index.html', esculturas=esculturas)

@app.route('/escultura/<int:escultura_id>')
def escultura(escultura_id):
    escultura = next((item for item in esculturas if item['id'] == escultura_id), None)
    if escultura is not None:
        return render_template('escultura.html', escultura=escultura)
    else:
        return 'Escultura não encontrada', 404

if __name__ == '__main__':
    app.run(debug=True)

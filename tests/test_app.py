import pytest
from flask_testing import TestCase
from api.app import app, esculturas

class TestFlaskApp(TestCase):
    def create_app(self):
        # Configura a aplicação para testing
        app.config['TESTING'] = True
        return app

    def test_home_page(self):
        # Testa se a home page está acessível
        response = self.client.get('/')
        self.assertEqual(response.status_code, 200)

    def test_esculturas_in_context(self):
        # Testa se a lista de esculturas está sendo renderizada na página
        response = self.client.get('/')
        html = response.data.decode('utf-8')
        # Verificar se os nomes das esculturas aparecem no HTML
        self.assertIn('Escultura do Pensador', html)
        self.assertIn('Escultura de Hades', html)
        self.assertIn('150', html)  
        self.assertIn('200', html)

if __name__ == '__main__':
    pytest.main()
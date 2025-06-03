🚀 Mini-projet CI/CD – Portfolio Web Déployé Automatiquement

Un site web personnel (type CV) responsive, déployé automatiquement à l’aide d’un pipeline CI/CD complet. Ce projet illustre l’utilisation d’outils DevOps modernes tels que **GitHub**, **Docker**, **Jenkins** et **Kubernetes**, avec hébergement sur un **serveur VPS Hostinger**.

🔧 Technologies utilisées

- **GitHub** : Gestion du code source
- **Docker** : Conteneurisation de l'application
- **Jenkins** : Automatisation des builds et du déploiement
- **Kubernetes (K3s)** : Orchestration des conteneurs
- **VPS Hostinger (Ubuntu 24.04 LTS)** : Hébergement du pipeline
- **Nginx** : Serveur web léger pour servir le site statique


📁 Project Structure


miniproject_final/
│
├── css/                 # Stylesheets
│   └── style.css
│
├── js/                  # JavaScript behavior
│   └── script.js
│
├── images/              # Profile images and icons
│   └── profile.jpg
│
├── index.html           # Main HTML page
├── Dockerfile           # Docker build configuration
├── k8s-deployment.yaml  # Kubernetes deployment manifest
├── Jenkinsfile          # CI/CD pipeline definition
└── README.md            # Project documentation

🚀 Étapes de mise en œuvre

### 1. 🔐 Configuration du serveur VPS
- OS : Ubuntu 24.04 LTS
- Outil de sécurité installé : `Monarx malware scanner`
- Accès SSH activé

### 2. 🐳 Installation de Docker

sudo apt install docker.io
sudo usermod -aG docker $USER

### 3. Mise en place d’un registre Docker privé sur le port 5000
docker run -d -p 5000:5000 --name registry registry:2

### 4.☕ Installation de Java et Jenkins
sudo apt install openjdk-17-jre
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo apt install jenkins

### 5. 🔧 Configuration de Jenkins
    - Accès via http://168.231.76.181:8080

    - Plugins installés : GitHub, Pipeline, Docker, etc.

    - Ajout d’un token GitHub pour le clonage automatique


🐋 Dockerfile
FROM nginx:alpine
RUN rm -rf /usr/share/nginx/html/*
COPY . /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

📦 Jenkinsfile
pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git credentialsId: 'github-token', url: 'https://github.com/Asmaalaassal/miniproject_final.git'
            }
        }
        stage('Build Docker') {
            steps {
                sh 'docker build -t localhost:5000/cv-site .'
            }
        }
        stage('Push Image') {
            steps {
                sh 'docker push localhost:5000/cv-site'
            }
        }
        stage('Deploy') {
            steps {
                sh 'kubectl apply -f k8s-deployment.yaml'
            }
        }
    }
}

☸️ Kubernetes (K3s)

    - Installation de K3s
    - Fichier k8s-deployment.yaml pour déploiement sur le port 30080
    - Alias configuré pour kubectl

# Accès au site via NodePort
http://168.231.76.181:30080

🧪 Tests

    - Une modification dans index.html déclenche automatiquement :
    - Un build Jenkins
    - La reconstruction de l’image Docker
    - Le déploiement via Kubernetes
Exemple : modification du nom affiché → mise à jour visible sur le site


👨‍💻 Auteurs
Asmaa Laassal
Zakia Wardy
Encadré par M. Anouar Dalli – ENSA Safi

🔗 [GitHub Profile](https://github.com/Asmaalaassal)

📝 Licence
Ce projet est fourni à des fins académiques et éducatives. Utilisation libre à condition de citation.
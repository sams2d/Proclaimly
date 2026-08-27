# Proclaimly

### Presentation Software by S2D Labs

Proclaimly is a lightweight, web-based presentation application designed to make displaying lyrics, songs, and presentation content simple, reliable, and easy to manage.

Built with **Python and Django**, Proclaimly provides a clean interface for managing presentation content and displaying it through a browser.

---

## ✨ Features

* 🎵 Create and manage songs
* 📝 Organize lyrics and presentation content
* 🖥️ Display presentation slides through a web browser
* 🌐 Browser-based presentation interface
* ⚡ Lightweight Django application
* 💾 SQLite database for simple local deployment
* 🚀 Windows batch launcher for simplified startup
* 🔧 Automatic environment setup
* 📦 Designed to run locally without requiring advanced configuration
* 🏠 Suitable for churches, events, meetings, and other presentation environments

---

## 🛠️ Technology Stack

| Technology | Purpose                   |
| ---------- | ------------------------- |
| Python     | Application development   |
| Django     | Web framework             |
| HTML       | User interface            |
| CSS        | Styling                   |
| JavaScript | Client-side functionality |
|Django ORM	 |Database abstraction and data management|
|SQLite	Default| database backend        |
| Git        | Version control           |
| GitHub     | Source-code hosting       |

---

## 📋 Requirements

For development or manual installation, you will need:

* Windows 10/11
* Python 3.x
* Git
* Internet connection for initial dependency installation

> The provided setup/launcher scripts are intended to simplify the installation and startup process on Windows.

---

# 🚀 Getting Started

## 1. Clone the Repository

Clone the Proclaimly repository from GitHub:

```bash
git clone https://github.com/sams2d/Proclaimly.git
cd Proclaimly
```

---

## 2. Run the Setup

The project includes the setup batch file, run:

```text
setup.bat
```

The setup process is designed to prepare the local Python environment and install the required dependencies.

The setup script can:

1. Check whether Python is available and install it if not available.
2. Detect the Python launcher when applicable.
3. Create the project's virtual environment.
4. Install the required Python packages.
5. Prepare the application for use.

---

# ▶️ Running Proclaimly

After setup, launch Proclaimly using the provided launcher:

```text
runserver.bat
```

The launcher starts the Django development server and can automatically open Proclaimly in the default web browser.

Once the server is running, Proclaimly will normally be accessible through a local address such as:

```text
http://127.0.0.1:8000/
```

> The exact address and port depend on the configuration of the application.

---

# 🖥️ Using Proclaimly

Once Proclaimly is running:

1. Open the application in your browser.
2. Access the song/presentation management interface.
3. Create or manage presentation content.
4. Select the content you want to present.
5. Open the presentation/slides interface.
6. Use the browser window to display the content.

Proclaimly is designed to keep the workflow simple so that presentation operators can focus on presenting rather than managing complicated software.

---

# 🗄️ Database

Proclaimly uses the **Django ORM** (Object-Relational Mapping) for database operations, with **SQLite** as the default database backend for local development and deployment.

The Django ORM provides an abstraction layer between the application and the database, allowing Proclaimly to work with database records using Python and Django models instead of writing raw SQL queries directly.

The database stores application data such as:

Songs
Lyrics and presentation content
Other application-related data managed through Django models

---

# 🔐 Security

For production deployments, make sure sensitive configuration is not committed to GitHub.

In particular, do **not** commit:

* Django `SECRET_KEY`
* Passwords
* API keys
* Database credentials
* Personal information
* Private configuration files

Use environment variables or another secure configuration mechanism for sensitive values.

---

# ⚙️ Development

To manually run Proclaimly during development:

```bash
python manage.py runserver
```

Then open:

```text
http://127.0.0.1:8000/
```

If the project uses a virtual environment, activate it before running Django:

```bash
venv\Scripts\activate
```

Install dependencies with:

```bash
pip install -r requirements.txt
```

---

# 🧪 Testing

Django's testing framework can be used to run the application's tests:

```bash
python manage.py test
```

As Proclaimly continues to evolve, additional automated tests can be added for:

* Song management
* Presentation generation
* Slide navigation
* Database operations
* Views and URLs
* User workflows

---

# 🌐 Deployment

Proclaimly is currently designed primarily as a **local Windows-based application**.

The Django architecture also provides a foundation for future deployment to a server environment.

Possible future deployment targets include:

* Windows server
* Linux server
* Cloud hosting
* Internal/local network server

For production deployment, Django's development server should not be used as the production web server. A production deployment should use an appropriate WSGI/ASGI server and web server configuration.

---

# 🗺️ Roadmap

Potential future improvements include:

* [ ] Improved presentation controls
* [ ] Full-screen presentation mode
* [ ] Next/previous slide controls
* [ ] Better lyric formatting
* [ ] Song search and filtering
* [ ] Import/export functionality
* [ ] Presentation themes
* [ ] Custom backgrounds
* [ ] Multi-display support
* [ ] Remote presentation control
* [ ] User authentication and permissions
* [ ] PostgreSQL support for larger deployments
* [ ] Linux deployment support
* [ ] Improved installer/package distribution

---

# 🤝 Contributing

Contributions and suggestions are welcome.

If you would like to contribute:

1. Fork the repository.
2. Create a new branch.

```bash
git checkout -b feature/your-feature
```

3. Make your changes.
4. Test the application.
5. Commit your changes.

```bash
git add .
git commit -m "Add your feature"
```

6. Push your branch.

```bash
git push origin feature/your-feature
```

7. Open a Pull Request.

---

# 🐛 Reporting Issues

If you find a bug or encounter a problem, please open an issue in the GitHub repository.

When reporting an issue, include:

* Operating system
* Python version
* Browser and version
* Steps to reproduce the problem
* Expected behavior
* Actual behavior
* Relevant error messages or screenshots

Please avoid posting passwords, secret keys, or other sensitive information.

---

# 📄 License

The licensing terms for Proclaimly should be defined by the project owner.

If the project is not currently released under an open-source license, consider adding an appropriate license before accepting external contributions.

---

# 👨‍💻 About

**Proclaimly** is developed by **S2D Labs**.

The project is built with Python and Django with the goal of providing a simple and practical presentation solution.

### Proclaimly

**Presentation Software by S2D Labs**

---

## ⭐ Support the Project

If you find Proclaimly useful, consider giving the repository a ⭐ on GitHub.

Your feedback, suggestions, and contributions can help improve the project.

---

**Built with ❤️ using Python & Django**

**© S2D Labs 2026**

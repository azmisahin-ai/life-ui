# ![Logo](media/favicon.png)

# Project architecture document.

- Review the [Architecture Diagram](architecture/README.md).
- Folder design information of the application.

```
.
+-- build                           '	Executable version of the project.
+-- docs						    '	Project, documents.
+-- .devcontainer                   '	Project, development configuration.
+-- .docker                         '	Project, docker file.
|   +-- .env                        '	each env. the file holds or separates the development environment definitions.
|   +-- docker-compose.yaml         '	each .yml file holds or separates runtime definitions.
|   +-- Dockerfile                  '	each docker file prepares the runtime launcher image.
+-- reports                         '	Project, coverage, test, screen.
|   +-- coverage                    '	Project, coverage web content
|   |   ?-- index.html              '	Project, coverage report static file
|   +-- document                    '	Project, document web content.
|   |   ?-- index.html              '	Project, document report static file
|   +-- tests                       '	Project, test and coverage result.
|   |   +-- cobertura-coverage.xml  '	Project, coverage result.
|   |   +-- junit.xml               '	Project, Unit test result.
|   +-- screen                      '	Project, e2e screens.
+-- src							    '	Project resource files.
|   ?-- api					        '	In-app services.
|   ?-- assets			            '	Design assets.
|   ?-- controllers	                '	The parts that separate the business logic of the application and the user interface.
|   ?-- core					    '	Application core.
|   ?-- models					    '	View objects that separate the Controller From the user interface.
|   ?-- views					    '	The area users view with models.
+-- tests                           '	Project testing.
|   +-- e2e						    '	End-to-end test.
|   +-- unit					    '	Unit test.
|   +-- integration                 '	Integration testing.
+-- .editor.config                  '	Developers will use these code indents and styles in their IDEs.

```

## Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/azmisahin/azmisahin-software-web-service-template-flutter-dart-v1
   ```

2. Navigate to the project directory:

   ```bash
   cd azmisahin-software-web-service-template-flutter-dart-v1
   ```

# Docker Stacks Manager

A simple command-line tool to manage multiple Docker stack deployments. This repository contains various Docker stack configurations organized in separate directories, with each directory containing its own management scripts.


## Overview

The repository is organized with the following structure:

```
docker-stacks/
├── jupyter/
│ ├── start.sh
│ ├── stop.sh
│ └── docker-compose.yml
├── mongo/
│ ├── start.sh
│ ├── stop.sh
│ └── docker-compose.yml
├── install/
│ ├── install.sh # For Linux/MacOS
│ └── install.bat # For Windows
└── docker-stack # Main command-line tool
```


Each service directory contains its own Docker stack configuration and management scripts.

## Installation

### For Linux/MacOS

1. Clone the repository:
   ```bash
   git clone https://github.com/afzalex/docker-stacks.git
   cd docker-stacks
   ```

2. Run the installation script:
   ```bash
   ./install/install.sh
   ```

### For Windows

1. Clone the repository:
   ```bash
   git clone https://github.com/afzalex/docker-stacks.git
   cd docker-stacks
   ```

2. Run the installation script:
   ```bash
   install\install.bat
   ```

   Note: Windows installation requires Git Bash or similar bash environment to be installed.

## Usage

After installation, you can use the `docker-stack` command from anywhere. The basic syntax is:

``` bash
bash
docker-stack <service-name> <action>
```


#### Start the Jupyter stack
``` bash
docker-stack jupyter start
```

#### Stop the MongoDB stack
``` bash
docker-stack mongo stop
```

### Available Services

- `jupyter`: Jupyter Notebook stack
- `mongo`: MongoDB stack
- [Add other services as they are added to the repository]

### Available Actions

Each service supports the following actions:
- `start`: Start the Docker stack
- `stop`: Stop the Docker stack
- [Add other actions as they are implemented]

## Adding New Services

To add a new service:

1. Create a new directory with the service name
2. Add required management scripts (e.g., `start.sh`, `stop.sh`)
3. Add your Docker Compose or Stack configuration files

Example structure for a new service:

```
my-service/
├── start.sh
├── stop.sh
└── docker-compose.yml
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

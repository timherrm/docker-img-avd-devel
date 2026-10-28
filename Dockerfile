FROM node:26.12.1-trixie-slim

# Install system dependencies and Python
RUN apt-get update && \
    apt-get install -y python3 python3-pip git jq vim bash-completion && \
    rm -rf /var/lib/apt/lists/*

# Copy requirements files
COPY pip-requirements.txt .

# Install Python packages
RUN pip3 install -r pip-requirements.txt --break-system-packages --force-reinstall --ignore-installed

# Prepare work directory
WORKDIR /workspaces/arista-fabric
RUN mkdir -p /workspaces/arista-fabric

# Copy requirements files
COPY requirements.yml .

# Install Ansible collections
RUN ansible-galaxy collection install -r requirements.yml --force

# Verify installations
RUN node --version && \
    python3 --version && \
    git --version && \
    ansible --version && \
    ansible-galaxy collection list

CMD ["bash"]

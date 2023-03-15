# SSH
ssh-keygen -m PEM -t rsa -b 4096
ssh-agent bash -c 'ssh-add /somewhere/yourkey; git clone git@github.com:user/project.git'

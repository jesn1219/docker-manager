sh ./scripts/change_ssh_port.sh 
passwd;

cd /research;
git clone https://github.com/jesn1219/jesnk_packages;
sv2 && cd jesnk_packages && sh setup.sh && sv2
wandb init;







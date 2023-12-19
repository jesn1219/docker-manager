#sh ./scripts/change_ssh_port.sh # No need to change ssh port. because. docker level port binding.
passwd;

cd /research;
git clone https://github.com/jesn1219/jesnk_packages;
sv2 && cd jesnk_packages && sh setup.sh && sv2
wandb init;







#sh ./scripts/change_ssh_port.sh # No need to change ssh port. because. docker level port binding.
passwd;

cd /research;
git clone https://github.com/jesn1219/jesnk_packages;
. /env2/bin/activate && cd jesnk_packages && sh setup.sh && . /env2/bin/activate

cd /research/rl_zoo_jesnk;
. /env2/bin/activate && pip uninstall -y stable-baselines3;
git clone https://github.com/jesnk/stable_baselines3;

wandb init;







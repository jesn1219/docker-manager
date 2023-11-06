#!/bin/bash
# 원하는 SSH 포트 번호를 설정합니다.
NEW_SSH_PORT=22001

# SSH 설정 파일의 경로입니다.
SSH_CONFIG_FILE="/etc/ssh/sshd_config"

# 관리자 권한으로 실행 중인지 확인합니다.
if [[ $EUID -ne 0 ]]; then
   echo "이 스크립트는 root 권한으로 실행되어야 합니다." 
   exit 1
fi

# SSH 설정 파일의 백업을 생성합니다.
cp $SSH_CONFIG_FILE "${SSH_CONFIG_FILE}.bak"

# 설정 파일에서 기존 'Port' 지시문을 주석 처리하고 새 포트를 추가합니다.
sed -i "s/^Port .*/#&/" $SSH_CONFIG_FILE
echo "Port $NEW_SSH_PORT" >> $SSH_CONFIG_FILE

# SSH 서비스를 재시작합니다.
systemctl restart sshd

# 완료 메시지를 출력합니다.
echo "SSH 포트가 $NEW_SSH_PORT 으로 변경되었습니다."

SCRIPTDI=R$( cd "$(dirname "$0")"; pwd -P )
export SSH_AUTH_SOCK=$HOME/.ssh/agent.sock
ss -a | grep -q $SSH_AUTH_SOCK
if [ $? -ne 0   ]; then
      rm -f $SSH_AUTH_SOCK
          ( setsid socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork EXEC:"$SCRIPTDIR/npiperelay.exe -ei -s //./pipe/openssh-ssh-agent",nofork & ) >/dev/null 2>&1
fi
